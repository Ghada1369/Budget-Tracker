import 'package:budget_tracker/widgets/buttom_sheet_content.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: theme.colorScheme.surface,
          context: context,
          builder: (context) {
            return const ButtomSheetContent();
          },
        );
      },
      backgroundColor: theme.colorScheme.primary,
      shape: const CircleBorder(),
      child: const Icon(Icons.add,),
    );
  }
}
