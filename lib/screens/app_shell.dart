import 'package:flutter/material.dart';
import '../state/canteen_store.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'menu_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  String _menuQuery = '';
  String _menuCategory = 'All';
  final CanteenStore store = CanteenStore.instance;

  void _openMenu({String? query, String? category}) {
    setState(() {
      _selectedIndex = 1;
      _menuQuery = query ?? '';
      _menuCategory = category ?? 'All';
    });
  }

  void _showCart() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => AnimatedBuilder(
        animation: store,
        builder: (context, _) {
          final lines = List<CartLine>.from(store.cart);
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: SizedBox(
                height: MediaQuery.of(sheetContext).size.height * 0.68,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your cart (${store.itemCount})',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.ink)),
                    const SizedBox(height: 12),
                    Expanded(
                      child: lines.isEmpty
                          ? const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.shopping_bag_outlined, size: 52, color: AppTheme.muted),
                                  SizedBox(height: 10),
                                  Text('Your cart is empty'),
                                  Text('Add something delicious from the menu.'),
                                ],
                              ),
                            )
                          : ListView(
                              children: lines.map((line) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      line.item.imageUrl,
                                      width: 54,
                                      height: 54,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => const Icon(Icons.restaurant),
                                    ),
                                  ),
                                  title: Text(line.item.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                                  subtitle: Text('₹${line.item.price.toStringAsFixed(0)} each'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () => store.changeQuantity(line.item, -1),
                                        icon: const Icon(Icons.remove_circle_outline),
                                      ),
                                      Text('${line.quantity}'),
                                      IconButton(
                                        onPressed: () => store.changeQuantity(line.item, 1),
                                        icon: const Icon(Icons.add_circle_outline),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Expanded(child: Text('Total', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700))),
                        Text('₹${store.cartTotal.toStringAsFixed(0)}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.green)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                        onPressed: store.cart.isEmpty
                            ? null
                            : () {
                                Navigator.pop(sheetContext);
                                _checkout();
                              },
                        style: FilledButton.styleFrom(backgroundColor: AppTheme.orange),
                        child: const Text('Choose pickup & place order'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _checkout() {
    String slot = 'In 15 minutes';
    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Pickup time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Choose when you will collect your order.'),
              const SizedBox(height: 12),
              ...['In 15 minutes', 'In 30 minutes', 'At lunch break', 'At 4:00 PM'].map(
                (option) => RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  value: option,
                  groupValue: slot,
                  title: Text(option),
                  onChanged: (value) => setDialogState(() => slot = value!),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
            FilledButton(
              onPressed: () {
                if (store.cart.isEmpty) {
                  Navigator.pop(dialogContext);
                  return;
                }
                store.placeOrder(slot);
                Navigator.pop(dialogContext);
                setState(() => _selectedIndex = 2);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(content: Text('Order placed! Check My Orders for status.')),
                );
              },
              child: const Text('Place order'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onOpenMenu: _openMenu),
      MenuScreen(initialQuery: _menuQuery, initialCategory: _menuCategory),
      const OrdersScreen(),
      const ProfileScreen(),
    ];

    return AnimatedBuilder(
      animation: store,
      builder: (context, _) => Scaffold(
        body: SafeArea(bottom: false, child: IndexedStack(index: _selectedIndex, children: pages)),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showCart,
          backgroundColor: AppTheme.orange,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.shopping_bag_outlined),
          label: Text('Cart (${store.itemCount})'),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.restaurant_menu_rounded), label: 'Menu'),
            NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long_rounded), label: 'My Orders'),
            NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
