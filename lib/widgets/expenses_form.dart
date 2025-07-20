import 'package:flutter/material.dart';

class ExpensesForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(String) onSavedExpense;

  const ExpensesForm({
    super.key,
    required this.formKey,
    required this.onSavedExpense,
  });

  @override
  State<ExpensesForm> createState() => _ExpensesFormState();
}

class _ExpensesFormState extends State<ExpensesForm> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SizedBox(
        height: 50,
        width: 250,
        child: Align(
          alignment: Alignment.center,
          child: TextFormField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              hintText: 'Enter expense',
              suffixIcon: Icon(Icons.money_rounded, color: theme.iconTheme.color),
              border: buildOutlineInputBorder(theme),
              enabledBorder: buildOutlineInputBorder(theme),
              focusedBorder: buildOutlineInputBorder(theme),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Add expense';
              }

              final parsed = double.tryParse(value);
              if (parsed == null || parsed <= 0) {
                return 'Enter a valid number';
              }

              return null;
            },
            onSaved: (newValue) {
              if (newValue != null) {
                widget.onSavedExpense(newValue);
              }
            },
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(ThemeData theme) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: theme.colorScheme.primary),
    );
  }
}
