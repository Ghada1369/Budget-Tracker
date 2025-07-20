import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategorySelector({super.key, required this.onCategorySelected});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  List<String> categories = [
    "Food & Drinks",
    "Transportation",
    "Rent/Housing",
    "Bills",
    "Shopping",
    "Health",
    "Education",
    "Entertainment",
    "Subscriptions",
    "Donations",
    "Debt",
    "Other",
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(categories.length, (index) {
          final isSelected = selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onCategorySelected(categories[index]);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
                foregroundColor: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: isSelected ? 2 : 0,
              ),
              child: Text(categories[index]),
            ),
          );
        }),
      ),
    );
  }
}
