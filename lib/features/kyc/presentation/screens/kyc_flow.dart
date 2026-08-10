import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/mobile_pay_app_bar.dart';
import '../bloc/kyc_bloc.dart';
import '../bloc/kyc_event.dart';
import 'kyc_step1_screen.dart';
import 'kyc_step2_screen.dart';
import 'kyc_step3_screen.dart';

class KycFlow extends StatefulWidget {
  const KycFlow({super.key});

  @override
  State<KycFlow> createState() => _KycFlowState();
}

class _KycFlowState extends State<KycFlow> {
  final GlobalKey<NavigatorState> _stepNavigatorKey =
      GlobalKey<NavigatorState>();

  int _currentStep = 1;

  late final _StepDepthObserver _stepDepthObserver = _StepDepthObserver(
    onDepthChanged: _setStep,
  );

  void _setStep(int step) {
    if (!mounted || step == _currentStep) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _currentStep = step);
      }
    });
  }

  void _closeFlow() {
    context.read<KycBloc>().add(const KycReset());
    context.pop();
  }

  void _goToStep2() {
    _stepNavigatorKey.currentState!.push(
      MaterialPageRoute<void>(
        builder: (_) => KycStep2Screen(onNext: _goToStep3),
      ),
    );
  }

  void _goToStep3() {
    _stepNavigatorKey.currentState!.push(
      MaterialPageRoute<void>(
        builder: (_) => KycStep3Screen(
          onEditStep1: _popToStep1,
          onEditStep2: _popToStep2,
          onSubmitted: _closeAfterSubmit,
        ),
      ),
    );
  }

  void _popToStep1() {
    _stepNavigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void _popToStep2() {
    _stepNavigatorKey.currentState!.pop();
  }

  void _closeAfterSubmit() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;

        final navigator = _stepNavigatorKey.currentState;

        if (navigator != null && navigator.canPop()) {
          navigator.pop();
        }
      },
      child: Scaffold(
        appBar: MobilePayAppBar(
          title: 'KYC',
          leading: IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Exit KYC',
            onPressed: _closeFlow,
          ),
        ),
        body: Column(
          children: [
            _StepIndicator(currentStep: _currentStep),
            Expanded(
              child: Navigator(
                key: _stepNavigatorKey,
                observers: [_stepDepthObserver],
                onGenerateRoute: (_) {
                  return MaterialPageRoute<void>(
                    builder: (_) => KycStep1Screen(onNext: _goToStep2),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepDepthObserver extends NavigatorObserver {
  _StepDepthObserver({required this.onDepthChanged});

  final ValueChanged<int> onDepthChanged;

  int _depth = 0;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _depth++;
    onDepthChanged(_depth);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _depth--;
    onDepthChanged(_depth);
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      color: const Color(0xFFF3EAFB),
      child: Row(
        children: [
          for (int step = 1; step <= 3; step++) ...[
            _StepDot(step: step, active: step <= currentStep),
            if (step < 3)
              Expanded(
                child: Container(
                  height: 3,
                  color: step < currentStep
                      ? Colors.blue
                      : Colors.grey.shade300,
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({required this.step, required this.active});

  final int step;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: active ? Colors.blue : Colors.grey.shade300,
      child: Text(
        '$step',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: active ? Colors.white : Colors.grey.shade600,
        ),
      ),
    );
  }
}
