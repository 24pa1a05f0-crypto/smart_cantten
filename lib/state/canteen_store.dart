import 'package:flutter/foundation.dart';
import '../models/menu_item.dart';

class CartLine {
  CartLine(this.item, this.quantity);
  final MenuItem item;
  int quantity;
  double get total => item.price * quantity;
}

class CanteenOrder {
  CanteenOrder({required this.id, required this.lines, required this.total, required this.pickupSlot, required this.createdAt, this.status = 'Confirmed'});
  final String id;
  final List<CartLine> lines;
  final double total;
  final String pickupSlot;
  final DateTime createdAt;
  String status;
}

class CanteenStore extends ChangeNotifier {
  CanteenStore._();
  static final CanteenStore instance = CanteenStore._();

  String? userName;
  String? email;
  final List<CartLine> cart = [];
  final List<CanteenOrder> orders = [];
  bool get isSignedIn => email != null;
  int get itemCount => cart.fold(0, (sum, line) => sum + line.quantity);
  double get cartTotal => cart.fold(0, (sum, line) => sum + line.total);

  void signIn(String name, String userEmail) {
    userName = name.trim().isEmpty ? userEmail.split('@').first : name.trim();
    email = userEmail.trim();
    notifyListeners();
  }

  void signOut() { userName = null; email = null; notifyListeners(); }

  void add(MenuItem item) {
    if (!item.isAvailable) return;
    final index = cart.indexWhere((line) => line.item.id == item.id);
    if (index >= 0) { cart[index].quantity++; } else { cart.add(CartLine(item, 1)); }
    notifyListeners();
  }

  void changeQuantity(MenuItem item, int delta) {
    final index = cart.indexWhere((line) => line.item.id == item.id);
    if (index < 0) return;
    cart[index].quantity += delta;
    if (cart[index].quantity <= 0) cart.removeAt(index);
    notifyListeners();
  }

  void placeOrder(String pickupSlot) {
    if (cart.isEmpty) return;
    final lines = cart.map((line) => CartLine(line.item, line.quantity)).toList();
    orders.insert(0, CanteenOrder(
      id: 'SC${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      lines: lines, total: cartTotal, pickupSlot: pickupSlot, createdAt: DateTime.now()));
    cart.clear();
    notifyListeners();
  }
}
