import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductService {
	static Future<List<ProductModel>> getProducts(BuildContext context) async {
		try {
			// load product demo data from the assets folder
			String data = await DefaultAssetBundle.of(context)
				.loadString("assets/demo/products.json");

			List<dynamic> products = json.decode(data);

			return products.map(
				(product) => ProductModel.fromJson(product)
			).toList();
		} catch(err) {
			print(err);
			throw('An error occure loading products.');
		}
	}
}