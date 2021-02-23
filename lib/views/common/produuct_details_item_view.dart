import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProduuctDetailsItemView extends StatelessWidget {
	
	final IconData icon;
	final String title;
	final String value;

	ProduuctDetailsItemView({this.icon, this.title, this.value});

	@override
	Widget build(BuildContext context) => Row(
		children: [
			Icon(icon)
				.iconColor(context.primaryColor)
				.iconSize(20),
				
			Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					'$title'.toUpperCase().text
						.color(context.canvasColor)
						.size(13)
						.make(),

					'$value'.text
						.size(17)
						.make()
				]
			).pOnly(left: 10)
		]
	);
}