import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoaderView extends StatelessWidget {
	@override
	Widget build(BuildContext context) => Container(
		width: double.infinity,
		child: SpinKitChasingDots(
			color: context.primaryColor,
			size: 100
		)
	);
}

class AppErrorView extends StatelessWidget {

	final Object error;
	final Function() voidCallback;

	AppErrorView({this.error, this.voidCallback});

	@override
	Widget build(BuildContext context) => Container(
		width: double.infinity,
		child: Column(
			mainAxisSize: MainAxisSize.max,
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.center,
			children: [
				Icon(Ionicons.md_information_circle_outline)
					.iconSize(80)
					.iconColor(Vx.gray700)
					.pOnly(bottom: 30),

				'Oops! An error occurred while\n processing your request'
					.text
					.size(22)
					.align(TextAlign.center)
					.textStyle(context.textTheme.headline3)
					.lineHeight(1.3)
					.make()
					.pOnly(bottom: 30),

				'${this.error}'
					.text
					.align(TextAlign.center)
					.textStyle(context.textTheme.bodyText1)
					.make()
					.pOnly(bottom: 20),

				OutlineButton.icon(
					onPressed: this.voidCallback,
					icon: Icon(SimpleLineIcons.reload)
						.iconSize(12),
					label: 'Reload'
						.text
						.align(TextAlign.center)
						.textStyle(context.textTheme.button)
						.make()
				)
			]
		)
	);
}