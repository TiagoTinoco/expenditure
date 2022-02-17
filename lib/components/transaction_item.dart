import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.tr,
    required this.onRemove,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String p1) onRemove;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$${tr.value}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          tr.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(tr.date),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => onRemove(tr.id),
        ),
      ),
    );
  }
}
