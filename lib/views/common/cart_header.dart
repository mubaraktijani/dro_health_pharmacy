import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../app/cart_notifier.dart';

class CartHeader extends StatelessWidget {
	final CartNotifier cartNotifier;

	CartHeader(this.cartNotifier);

	@override
	Widget build(BuildContext context) => Row(
		children: [
			Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Icon(SimpleLineIcons.handbag)
						.iconColor(Colors.white)
						.iconSize(22)
						.pOnly(right: 5),
					'Bag'.text
						.color(Colors.white)
						.size(22)
						.fontWeight(FontWeight.w400)
						.lineHeight(2)
						.make()
				]
			).expand(),
			'${(cartNotifier.cartItems ?? []).length}'.text
				.size(18)
				.fontWeight(FontWeight.w400)
				.make()
				.box
				.color(Colors.white)
				.width(30)
				.height(30)
				.alignCenter
				.withRounded(value: 30)
				.make()
		]
	);
}