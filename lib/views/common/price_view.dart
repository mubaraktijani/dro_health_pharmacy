import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

class PriceView extends StatelessWidget {
	final Color color;
	final double price;
	final double size, symbolSize;
	final FontWeight fontWeight;

	PriceView({
		this.color, this.price, this.size, 
		this.symbolSize, this.fontWeight
	});

	@override
	Widget build(BuildContext context) {
		var format = NumberFormat.currency(name: '');

		return Row(
			mainAxisSize: MainAxisSize.min,
			children: [
				'₦'.text
					.size(this.symbolSize ?? this.size)
					.color(this.color)
					.fontFamily('Roboto')
					.make(),

				'${format.format(this.price)}'.text
					.size(this.size)
					.color(this.color)
					.make()
			]
		);
	}
}