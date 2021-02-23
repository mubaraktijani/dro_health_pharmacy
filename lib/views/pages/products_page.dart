import 'package:dro_health_pharmacy/views/common/cart_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:futuristic/futuristic.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../app/cart_notifier.dart';
import '../common/page_loader_view.dart';
import '../common/product_item_view.dart';
import '../../app/models/product_model.dart';
import '../../app/services/product_service.dart';
import 'cart_page.dart';

class ProductsPage extends StatefulWidget {
	static String routeName = '/products';
	
	@override
	_ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

	int productCount = 0;
	CartNotifier cartNotifier;

	@override
	Widget build(BuildContext context) {
		cartNotifier = context.watch<CartNotifier>();
		
		return Scaffold(
			appBar: _appBar(),
			body: Futuristic<List<ProductModel>>(
				autoStart: true,
				futureBuilder: () async {
					await Future.delayed(Duration(seconds: 3));
					await cartNotifier.initCart();
					return ProductService.getProducts(context);
				},
				busyBuilder: (_) => AppLoaderView(),
				errorBuilder: (_, e, c) => AppErrorView(
					error: e, 
					voidCallback: c
				),
				dataBuilder: (_, data) {
					return _mainBody(data);
				}
			),
			bottomNavigationBar: ClipRRect(
				borderRadius: BorderRadius.only(
					topLeft: Radius.circular(16),
					topRight: Radius.circular(16)
				),
				child: InkWell(
					onTap: () => Navigator.of(context)
						.pushNamed(CartPage.routeName),
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: [
							VxBox()
								.width(40)
								.height(3)
								.withRounded()
								.color(Colors.white)
								.make().pOnly(top: 5),
							CartHeader(cartNotifier)
								.px16()
								.pOnly(bottom: 6)
						]
					)
					.box.color(context.primaryColor).make()
				)
			)
		);
	}

	Widget _appBar() => AppBar(
		centerTitle: true,
		backgroundColor: Colors.transparent,
		elevation: 0,
		leading: Icon(CupertinoIcons.chevron_left),
		title: '$productCount Item${(productCount > 1) ? '(s)' : ''}'.text
			.color(Colors.black)
			.make()
	);

	Widget _mainBody(List<ProductModel> products) => ListView(
		children: [
			StaggeredGridView.countBuilder(
				itemCount: products.length,
				shrinkWrap: true,
				padding: EdgeInsets.zero,
				crossAxisCount: 4,
				mainAxisSpacing: 10,
				crossAxisSpacing: 10,
				physics: NeverScrollableScrollPhysics(),
				staggeredTileBuilder: (_) => StaggeredTile.fit(2),
				itemBuilder: (_, index) {
					ProductModel product = products[index];
					return ProductItemView(
						product: product
					);
				}
			)
		]
	);
}