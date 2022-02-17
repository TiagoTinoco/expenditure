// ignore_for_file: unnecessary_null_comparison

import 'package:expenses/components/adaptative_textfield.dart';
import 'package:expenses/components/adaptative_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                label: 'Título',
                onSubmitted: (_) => _submitForm,
                controller: _titleController,
              ),
              AdaptativeTextField(
                label: 'Valor (R\$)',
                onSubmitted: (_) => _submitForm,
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Platform.isIOS
                      ? CupertinoButton(
                          child: const Text('Nova Transação'),
                          onPressed: _submitForm,
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        )
                      : ElevatedButton(
                          child: Text(
                            'Nova Transação',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.button?.color,
                            ),
                          ),
                          onPressed: _submitForm,
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
