import '../views/pages/cart_page.dart';
import '../views/pages/products_page.dart';
import '../views/pages/product_details_page.dart';

Map<String, dynamic> routes = {
	CartPage.routeName: (_) => CartPage(),
	ProductsPage.routeName: (_) => ProductsPage(),
	ProductDetailPage.routeName: (obj) => ProductDetailPage(product: obj)
};