import 'package:dro_health_pharmacy/views/common/price_view.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'flutter_img.dart';
import '../../app/models/product_model.dart';
import '../pages/product_details_page.dart';

class ProductItemView extends StatelessWidget {

	final ProductModel product;

	ProductItemView({this.product});
	
	@override
	Widget build(BuildContext context) => AnimatedContainer(
		duration: Duration(milliseconds: 1000),
		curve: Curves.easeIn,
		child: Card(
			child: InkWell(
				onTap: () => Navigator.of(context).pushNamed(
					ProductDetailPage.routeName,
					arguments: product
				),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						FlutterIMG(
							product.image,
							height: 180,
							fit: BoxFit.cover,
							width: double.infinity
						),
						'${product.title}'
							.text
							.size(15)
							.overflow(TextOverflow.ellipsis)
							.textStyle(context.textTheme.bodyText2)
							.make()
							.pLTRB(12,12,12,3),

						'${product.description}'
							.text
							.size(14)
							.textStyle(context.textTheme.bodyText1)
							.color(Vx.gray600)
							.make()
							.px12()
							.pOnly(bottom: 10),

						PriceView(
							price: product.price,
							color: Colors.white,
							fontWeight: FontWeight.bold,
							size: 16
						)
						.p2()
						.px16()
						.box
						.color(Colors.black.withOpacity(.5))
						.withRounded(value: 5)
						.make()
						.box
						.alignment(Alignment.centerRight)
						.px16
						.make()
							
					]
				),
			)
		)
		.h(280)
	);
}