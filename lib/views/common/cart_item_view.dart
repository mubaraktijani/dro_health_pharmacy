import 'package:dro_health_pharmacy/app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_cart/model/cart_model.dart';

import 'flutter_img.dart';
import 'price_view.dart';

class CartItemView extends StatefulWidget {

	final CartItem model;
	CartItemView({this.model});

	@override
	_CartItemViewState createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView> {
	bool showOptions = false;
	ProductModel details = ProductModel();

	@override
	Widget build(BuildContext context) {
		details = widget.model.productDetails;
		
		return Column(
			children: [
				GestureDetector(
					onTap: () => setState(() => showOptions = !showOptions),
					child: detailsView().pOnly(top:16)
				),
				IgnorePointer(
					ignoring: !showOptions,
					child: AnimatedOpacity(
						opacity: showOptions ? 1 : 0,
						duration: Duration(milliseconds: 300),
						child: options()
					)
				)
				
			]
		);
	}

	Widget detailsView() => Row(
		children: [
			FlutterIMG(
				'${details.image}',
				height: 40,
				width: 40,
				borderRadius: 40,
			),

			'x${this.widget.model.quantity}'.text
				.size(20)
				.color(Colors.white)
				.fontWeight(FontWeight.w400)
				.make()
				.px12(),

			Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					'${details.title}'.text
						.size(16)
						.color(Colors.white)
						.fontWeight(FontWeight.w400)
						.make(),
					'${details.title}'.text
						.size(10)
						.color(Colors.white)
						.make()
				]
			).expand(),

			PriceView(
				price: this.widget.model.quantity * details.price,
				color: Colors.white,
				fontWeight: FontWeight.bold,
				size: 16
			)
		]
	);

	Widget options() => Row(
		children: [
			InkWell(
				child: Icon(Ionicons.trash)
					.iconColor(Colors.white)
			),
			Expanded(child: SizedBox()),
			CustomNumberPicker(
				step: 1,
				shape: RoundedRectangleBorder(),
				maxValue: 30,
				minValue: 1,
				initialValue: this.widget.model.quantity,
				valueTextStyle: context.textTheme.bodyText1.copyWith(
					fontSize: 20,
					color: Colors.white
				),
				customAddButton: Icon(Ionicons.add).box
					.color(Colors.white)
					.withRounded(value: 100)
					.p4
					.make(),
				customMinusButton: Icon(Ionicons.md_remove).box
					.color(Colors.white)
					.withRounded(value: 100)
					.p4
					.make(),
				onValue: (val) {
					setState(
						() => this.widget.model.quantity = val
					);

				}
            ),
		]
	);
}