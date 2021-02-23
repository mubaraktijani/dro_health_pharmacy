import 'package:sqflite/sqflite.dart';

import '../helpers/orm.dart';
import '../helpers/functions.dart';

class CartTable extends ORM<CartTable> {

	final int id, itemId;
	final double price;
	final String title, image;

	int quantity;

	CartTable({
		this.id, this.itemId, this.image, this.title, this.quantity, this.price
	});
	
	@override
	Future<Database> get db => getDatabase();

	@override
	String get tableName => 'tbl_cart';

	@override
	String get createTable => '''
		CREATE TABLE $tableName (
			id INTEGER PRIMARY KEY AUTOINCREMENT,
			item_id INTEGER NOT NULL,
			quantity INTEGER DEFAULT 1,
			title TEXT NOT NULL,
			image TEXT NOT NULL,
			price TEXT NOT NULL
		)
	''';

	@override
	CartTable fromDB(Map<String, dynamic> data) => CartTable(
		id: data['id'],
		itemId: data['item_id'],
		title: data['title'],
		image: data['image'],
		quantity: data['quantity'] ?? 1,
		price: double.tryParse(data['price'])
	);

	@override
	Map<String, dynamic> get toJson => {
		'id': id,
		'item_id': itemId,
		'title': title,
		'image': image,
		'quantity': quantity,
		'price': price.toString()
	};
}