import 'package:flutter/material.dart';
import 'package:mobile_pay_task_1/features/transactions/domain/entities/transaction_entity.dart';

class TransactionsCard extends StatelessWidget {
  const TransactionsCard({
    super.key,
    required this.transaction,
    this.onAcknowledge,
  });

  final TransactionEntity transaction;
  final VoidCallback? onAcknowledge;

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.isCredit;

    Widget tile = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: transaction.acknowledged
              ? const BorderSide(color: Colors.deepPurple, width: 4)
              : BorderSide.none,
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: isCredit
                ? Colors.green.shade100
                : Colors.red.shade100,
            child: Icon(
              isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: isCredit ? Colors.green : Colors.red,
              size: 18,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Text(
                      transaction.time,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),

                    if (transaction.acknowledged) ...[
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.verified,
                        color: Colors.deepPurple,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        "Acknowledged",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          Text(
            "${isCredit ? "+" : "-"}${transaction.amount.abs()}",
            style: TextStyle(
              color: isCredit ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    if (transaction.acknowledged || onAcknowledge == null) {
      return tile;
    }

    return Dismissible(
      key: ValueKey(transaction.id),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (_) async {
        onAcknowledge!();
        return false;
      },
      background: Container(
        color: Colors.deepPurple,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Acknowledge",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      child: tile,
    );
  }
}
