class ProductModel {
	final int id;
	final double price;
	final String key, title, image, size;
	final String company, dispensedIn, description;

	ProductModel({
		this.price, this.id, this.key, this.title, this.image, 
		this.size, this.company, this.dispensedIn, this.description
	});

	factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
		price: double.tryParse(json['price']),
		id: json['product_id'],
		key: json['key'],
		title: json['title'],
		image: json['image'],
		size: json['pack_size'],
		company: json['company'],
		dispensedIn: json['dispensed_in'],
		description: json['description'],
	);
}