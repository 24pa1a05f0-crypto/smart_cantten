import 'package:flutter/material.dart';

import '../data/demo_menu.dart';
import '../theme/app_theme.dart';
import '../widgets/food_card.dart';
import '../widgets/section_heading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.onOpenMenu, super.key});

  final void Function({String? query, String? category}) onOpenMenu;

  static const _categoryIcons = <String, IconData>{
    'Breakfast': Icons.breakfast_dining_rounded,
    'Meals': Icons.rice_bowl_rounded,
    'Snacks': Icons.lunch_dining_rounded,
    'Beverages': Icons.local_cafe_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final popularItems =
        demoMenu.where((item) => item.isAvailable).take(4).toList();

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          sliver: SliverList.list(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('GOOD FOOD, LESS WAIT',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.3,
                                color: AppTheme.orange)),
                        const SizedBox(height: 5),
                        Text('Hi, hungry student 👋',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.ink)),
                      ],
                    ),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xFFF1EDE7))),
                    child: const Icon(Icons.notifications_none_rounded,
                        color: AppTheme.ink),
                  ),
                ],
              ),
              const SizedBox(height: 23),
              InkWell(
                onTap: () => onOpenMenu(),
                borderRadius: BorderRadius.circular(17),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(color: const Color(0xFFF1EDE7))),
                  child: const Row(
                    children: [
                      Icon(Icons.search_rounded, color: AppTheme.muted),
                      SizedBox(width: 10),
                      Text('Search dishes, snacks, drinks...',
                          style:
                              TextStyle(color: AppTheme.muted, fontSize: 13)),
                      Spacer(),
                      Icon(Icons.tune_rounded,
                          color: AppTheme.orange, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 23),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: AppTheme.green,
                    borderRadius: BorderRadius.circular(22)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.17),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text('CAMPUS CANTEEN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.2)),
                          ),
                          const SizedBox(height: 12),
                          const Text('Your break,\nmade delicious.',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  height: 1.12,
                                  fontWeight: FontWeight.w800)),
                          const SizedBox(height: 8),
                          Text('Order ahead and pick up on campus.',
                              style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.82),
                                  fontSize: 11)),
                          const SizedBox(height: 15),
                          TextButton.icon(
                            onPressed: () => onOpenMenu(),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppTheme.green,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8)),
                            icon: const Icon(Icons.arrow_forward_rounded,
                                size: 16),
                            label: const Text('Explore menu',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 96,
                      width: 82,
                      decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(Icons.ramen_dining_rounded,
                          color: Colors.white, size: 52),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const SectionHeading(title: 'What are you craving?'),
              const SizedBox(height: 12),
              SizedBox(
                height: 91,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categoryIcons.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 11),
                  itemBuilder: (context, index) {
                    final category = _categoryIcons.keys.elementAt(index);
                    return InkWell(
                      onTap: () => onOpenMenu(category: category),
                      borderRadius: BorderRadius.circular(17),
                      child: Container(
                        width: 82,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17),
                            border: Border.all(color: const Color(0xFFF1EDE7))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(_categoryIcons[category],
                                color: AppTheme.orange, size: 24),
                            const SizedBox(height: 7),
                            Text(category,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.ink)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),
              SectionHeading(
                  title: 'Student favourites',
                  actionLabel: 'See all',
                  onAction: () => onOpenMenu()),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: popularItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) =>
                    FoodCard(item: popularItems[index], compact: true),
              ),
              const SizedBox(height: 12),
              const Text('Demo menu · Prices in Indian rupees',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: AppTheme.muted)),
            ],
          ),
        ),
      ],
    );
  }
}
