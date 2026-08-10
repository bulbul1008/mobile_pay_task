import 'package:equatable/equatable.dart';

class KycDivisions extends Equatable {
  const KycDivisions({required this.divisions, required this.districts});

  final List<String> divisions;
  final Map<String, List<String>> districts;

  List<String> districtsOf(String? division) =>
      division == null ? const [] : (districts[division] ?? const []);

  @override
  List<Object?> get props => [divisions, districts];
}
