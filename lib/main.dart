import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'app/cart_notifier.dart';
import 'config/index.dart';
import 'config/constants.dart';
import 'app/helpers/functions.dart';
import 'views/pages/products_page.dart';

void main() async {
	
	WidgetsFlutterBinding.ensureInitialized();

	await SystemChrome.setPreferredOrientations([
		DeviceOrientation.portraitUp,
	]);

	Catcher(
		MyApp(),
		// debugConfig: debugOptions,
		releaseConfig: releaseOptions
	);
}

class MyApp extends StatelessWidget {
	
	@override
	Widget build(BuildContext context) {
		const FlexScheme usedFlexScheme = FlexScheme.deepPurple;

		var lightTheme = FlexColorScheme.light(
			colors: FlexColor.schemes[usedFlexScheme].light,
			visualDensity: FlexColorScheme.comfortablePlatformDensity,
			fontFamily: 'ProximaNova',
		).toTheme;
		
		return MultiProvider(
			providers: [
				ChangeNotifierProvider.value(value: CartNotifier())
			],
			builder: (context, child) => MaterialApp(
				home: ProductsPage(),
				title: APP_NAME,
				theme: lightTheme.copyWith(
					accentColor: Color(0xFF0CB8B6),
					primaryColor: Color(0xFF9F5DE2),
					primaryColorDark: Color(0xFF7B4397),
					canvasColor: Color(0xFF909090),
					appBarTheme: AppBarTheme(
						brightness: Brightness.light,
						backgroundColor: Colors.transparent,
						elevation: 0,
						titleTextStyle: context.textTheme.headline4.copyWith(
							color: Vx.gray700
						),
						iconTheme: IconThemeData(
							color: Vx.gray700,
						)
					)
				),
				builder: materialAppBuilder,
				themeMode: ThemeMode.light,
				navigatorKey: Catcher.navigatorKey,
				onGenerateRoute: onGenerateRoute,
				debugShowCheckedModeBanner: false
			)
		);
	}
}
