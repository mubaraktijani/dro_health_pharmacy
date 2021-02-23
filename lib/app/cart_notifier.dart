import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'database/cart_table.dart';
import 'models/product_model.dart';

class CartNotifier extends ChangeNotifier {
	CartTable _dbTable = CartTable();
	FlutterCart _cart = FlutterCart();

	double get cartTotalAmount => _cart.getTotalAmount();
	List<CartItem> get cartItems => _cart.cartItem;

	Future<void> initCart() async {
		await _dbTable.all.then((cartItems) {
			(cartItems ?? []).forEach((cartItem) async {
				_cart.addToCart(
					productId: cartItem.id, 
					unitPrice: num.tryParse('${cartItem.price}'), 
					quantity: cartItem.quantity,
					productDetailsObject: cartItem
				);
			});

			notifyListeners();
		});
	}

	Future<void> addToCart({ProductModel item, int quantity}) async {
		try{
			var id = await CartTable(
				title: item.title,
				price: item.price,
				image: item.image,
				itemId: item.id,
				quantity: quantity
			).save();

			_cart.addToCart(
				productId: id, 
				unitPrice: num.tryParse(item.price.toString()),
				quantity: quantity,
				productDetailsObject: item
			);

			notifyListeners();

			_showMessage(
				text: 'Item Added to Cart'
			);
		} catch(err) {
			_showMessage(
				text: 'Error adding to cart',
				error: true
			);

			throw(err.toString());
		}
	}

	Future<void> deleteItem(int id) async {
		_dbTable.find(id).then((data) async {
			await data.remove();
			var index = _cart.findItemIndexFromCart(id);
			_cart.deleteItemFromCart(index);

			notifyListeners();

			_showMessage(
				text: 'Item has been removed from cart.'
			);
		}).catchError((e) {
			_showMessage(
				text: 'Error removing item!',
				error: true
			);
			
			throw(e.toString());
		});
	}

	Future<void> updateCartItem(int id, int quantity) async {
		_dbTable.find(id).then((data) async {
			data.quantity = quantity;
			await data.save();

			_showMessage(text: 'Item Updated!');
		}).catchError((e) {
			_showMessage(
				text: 'Error Updating item!',
				error: true
			);
			
			throw(e.toString());
		});
	}

	dynamic _showMessage({String text, bool error: false}) => Fluttertoast.showToast(
		msg: text,
		toastLength: Toast.LENGTH_SHORT,
		gravity: ToastGravity.CENTER,
		backgroundColor: !error ? Colors.black38 : Colors.red.shade300,
		textColor: Colors.white,
		fontSize: 25
	);
}