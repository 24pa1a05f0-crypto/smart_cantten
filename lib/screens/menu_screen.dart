import 'package:flutter/material.dart';

import '../data/demo_menu.dart';
import '../models/menu_item.dart';
import '../theme/app_theme.dart';
import '../widgets/food_card.dart';
import '../widgets/section_heading.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen(
      {required this.initialQuery, required this.initialCategory, super.key});

  final String initialQuery;
  final String initialCategory;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late final TextEditingController _searchController;
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    _selectedCategory = widget.initialCategory;
  }

  @override
  void didUpdateWidget(covariant MenuScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialQuery != widget.initialQuery) {
      _searchController.text = widget.initialQuery;
    }
    if (oldWidget.initialCategory != widget.initialCategory) {
      _selectedCategory = widget.initialCategory;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MenuItem> get _filteredItems {
    final query = _searchController.text.trim().toLowerCase();
    return demoMenu.where((item) {
      final matchesCategory =
          _selectedCategory == 'All' || item.category == _selectedCategory;
      final matchesQuery = query.isEmpty ||
          item.name.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 21, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('OUR MENU',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.3,
                  color: AppTheme.orange)),
          const SizedBox(height: 5),
          const SectionHeading(title: 'Find your next favourite'),
          const SizedBox(height: 14),
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
                hintText: 'Search dishes, snacks, drinks...',
                prefixIcon: Icon(Icons.search_rounded)),
          ),
          const SizedBox(height: 13),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: menuCategories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = menuCategories[index];
                final selected = category == _selectedCategory;
                return ChoiceChip(
                  label: Text(category),
                  selected: selected,
                  onSelected: (_) =>
                      setState(() => _selectedCategory = category),
                  showCheckmark: false,
                  labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : AppTheme.ink),
                  backgroundColor: Colors.white,
                  selectedColor: AppTheme.orange,
                  side: BorderSide(
                      color:
                          selected ? AppTheme.orange : const Color(0xFFF1EDE7)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          Text('${items.length} dishes · Availability shown for today',
              style: const TextStyle(fontSize: 12, color: AppTheme.muted)),
          const SizedBox(height: 10),
          Expanded(
            child: items.isEmpty
                ? const _EmptyMenuState()
                : GridView.builder(
                    itemCount: items.length,
                    padding: const EdgeInsets.only(bottom: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.72),
                    itemBuilder: (context, index) =>
                        FoodCard(item: items[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _EmptyMenuState extends StatelessWidget {
  const _EmptyMenuState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 66,
              width: 66,
              decoration: const BoxDecoration(
                  color: AppTheme.paleOrange, shape: BoxShape.circle),
              child: const Icon(Icons.search_off_rounded,
                  color: AppTheme.orange, size: 30)),
          const SizedBox(height: 13),
          const Text('No dishes found',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.ink)),
          const SizedBox(height: 5),
          const Text('Try another search or category.',
              style: TextStyle(fontSize: 13, color: AppTheme.muted)),
        ],
      ),
    );
  }
}
