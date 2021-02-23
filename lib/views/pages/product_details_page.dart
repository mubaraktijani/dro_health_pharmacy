import 'package:dro_health_pharmacy/views/common/price_view.dart';
import 'package:dro_health_pharmacy/views/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

import '../common/flutter_img.dart';
import '../../app/cart_notifier.dart';
import '../../app/models/product_model.dart';
import '../common/produuct_details_item_view.dart';

class ProductDetailPage extends StatefulWidget {
	static String routeName = '/product-detail';
	final ProductModel product;

	ProductDetailPage({this.product});

	@override
	_ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

	int quantity = 1;
	CartNotifier cartNotifier;

	@override
	Widget build(BuildContext context) {
		cartNotifier = context.watch<CartNotifier>();
		
		return Scaffold(
			appBar: AppBar(
				centerTitle: true,
				backgroundColor: Colors.transparent,
				elevation: 0,
				title: '${widget.product.title.toUpperCase()}'.text
					.color(Vx.gray700)
					.overflow(TextOverflow.ellipsis)
					.make(),
				actions: [
					cartBag()
				]
			),
			body: Column(
				children: [
					Expanded(
						child: ListView(
							children: [
								FlutterIMG(
									widget.product.image,
									fit: BoxFit.contain
								).h24(context).pOnly(bottom: 16),

								'${widget.product.title}'.text
									.textStyle(context.textTheme.headline6)
									.make(),

								'${widget.product.description}'.text
									.textStyle(context.textTheme.bodyText1)
									.make()
									.pOnly(bottom: 16),

								companyInfo()
									.pOnly(bottom: 20),

								priceAndQuantityRow()
									.pOnly(bottom: 30),

								productDetails()
							]
						).px16(),
					),

					addToCartButton()
						.wTwoThird(context)
						.py16()
				]
			)
		);
	}

	Widget cartBag() => VxBox(
		child: InkWell(
			onTap: () => Navigator.of(context).pushNamed(CartPage.routeName),
			child: Row(
				children: [
					Icon(SimpleLineIcons.handbag)
						.iconColor(Colors.white)
						.iconSize(18),

					'${(cartNotifier.cartItems ?? []).length}'.text
						.size(18)
						.lineHeight(2)
						.color(Colors.white)
						.textStyle(context.textTheme.bodyText2)
						.make()
						.pOnly(left: 5)
				]
			)
		)
	)
	.color(context.primaryColor)
	.margin(EdgeInsets.only(
		top: 8,
		bottom: 8,
		right: 10
	))
	.px12
	.withRounded()
	.make();

	Widget companyInfo() => Row(
		children: [
			FlutterIMG(
				'assets/img/company.jpg',
				height: 40,
				width: 40,
				borderRadius: 40,
			),
			Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					'SOLD BY'.text
						.color(context.canvasColor)
						.make(),
					'${widget.product.company}'.text
						.size(17)
						.color(context.primaryColor)
						.make()
				]
			).px12()
		]
	);

	Widget priceAndQuantityRow() => Row(
		children: [
			CustomNumberPicker(
				initialValue: quantity,
				customAddButton: Icon(Ionicons.add),
				customMinusButton: Icon(Ionicons.md_remove),
				maxValue: 30,
				minValue: 1,
				step: 1,
				onValue: (val) => setState(() => quantity = val)
            ),
			'PACKS'.text.
				color(context.canvasColor)
				.size(13)
				.make()
				.expand(),
			PriceView(
				price: quantity * widget.product.price,
				color: Colors.black,
				fontWeight: FontWeight.bold,
				size: 20
			)
		]
	);

	Widget productDetails() => Column(
		crossAxisAlignment: CrossAxisAlignment.start,
		children: [
			'PRODUCTS DETAILS'.text
				.textStyle(context.textTheme.headline6)
				.color(context.canvasColor)
				.make()
				.pOnly(bottom: 10),
			Row(
				children: [
					Expanded(
						child: ProduuctDetailsItemView(
							icon: Ionicons.briefcase_outline,
							title: 'Package Size',
							value: '${widget.product.size}'
						)
					),
					Expanded(
						child: ProduuctDetailsItemView(
							icon: Ionicons.md_qr_code_outline,
							title: 'Product ID',
							value: '${widget.product.key}'
						)
					)
				]
			).pOnly(bottom: 12),
			ProduuctDetailsItemView(
				icon: Ionicons.thermometer_outline,
				title: 'Constituents',
				value: '${widget.product.description}'
			).pOnly(bottom: 12),
			ProduuctDetailsItemView(
				icon: Ionicons.archive_outline,
				title: 'Despensed in',
				value: '${widget.product.dispensedIn}'
			)
		]
	);

	Widget addToCartButton() => RaisedButton(
		onPressed: () async {
			await cartNotifier.addToCart(
				item: widget.product,
				quantity: quantity
			);
		},
		shape: RoundedRectangleBorder(
			borderRadius: BorderRadius.circular(10),
		),
		color: context.primaryColor,
		child: Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
				Icon(SimpleLineIcons.handbag)
					.iconSize(18),
				'Add to bag'.text
					.size(15)
					.lineHeight(2)
					.make()
					.pOnly(left: 5)
			]
		).py2()
	);
}