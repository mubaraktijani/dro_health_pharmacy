import 'package:dro_health_pharmacy/app/database/cart_table.dart';
import 'package:dro_health_pharmacy/views/common/cart_header.dart';
import 'package:dro_health_pharmacy/views/common/price_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../app/cart_notifier.dart';
import '../common/cart_item_view.dart';

class CartPage extends StatefulWidget {
	static String routeName = '/cart';

	@override
	_CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

	CartNotifier cartNotifier;

	@override
	Widget build(BuildContext context) {
		cartNotifier = context.watch<CartNotifier>();

		return Scaffold(
			body: SafeArea(
				child: ClipRRect(
					borderRadius: BorderRadius.only(
						topLeft: Radius.circular(16),
						topRight: Radius.circular(16)
					),
					child: Container(
						color: context.primaryColor,
						child: Column(
							children: [
								VxBox()
									.width(40)
									.height(3)
									.withRounded()
									.color(Colors.white)
									.make().pOnly(top: 5, bottom: 2),

								CartHeader(cartNotifier)
									.px16()
									.pOnly(bottom: 16),

								'Tap on an item for add, remove, delete options.'.text
									.make()
									.box
									.color(Colors.white)
									.withRounded()
									.p8
									.make(),

								ListView(
									children: (cartNotifier.cartItems ?? []).map(
										(item) => CartItemView(
											model: item
										)
									).toList()
								).px16().expand(),

								Row(
									children: [
										'Total'.text
											.color(Colors.white)
											.size(20)
											.fontWeight(FontWeight.bold)
											.make()
											.expand(),

										PriceView(
											price: cartNotifier.cartTotalAmount,
											color: Colors.white,
											fontWeight: FontWeight.bold,
											size: 20
										)
									]
								).px16().pOnly(bottom: 16),

								RaisedButton(
									onPressed: (){},
									shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.circular(10),
									),
									color: Colors.white,
									child: 'Checkout'.text
										.size(15)
										.lineHeight(2)
										.make()
										.py2()
								).px16().pOnly(bottom: 16).wTwoThird(context)
							]
						)
					)
				)
			)
		);
	}
}