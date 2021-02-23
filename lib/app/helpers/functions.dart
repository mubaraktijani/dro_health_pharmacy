import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';

import '../../config/routes.dart';
import '../../config/constants.dart';
import '../../config/migration.dart';

Future<Database> getDatabase() async {
	String databasesPath = await getDatabasesPath();
	String dbPath = join(databasesPath, DB_NAME);

	Database database = await openDatabase(
		dbPath,
		version: DB_VERSION,
		onCreate: (Database db, int version) async {
			migration.forEach((script) async => await db.execute(script));  
		},
		onUpgrade: (Database db, int oldVersion, int newVersion) async {
			for (var i = oldVersion - 1; i < newVersion - 1; i++) {
				await db.execute(migrationOnUpgrade[i]);
			} 
		}
	);
	
	return database;
}

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
	return MaterialPageRoute(
		builder: (BuildContext context) {
			dynamic arg = settings.arguments;
			return routes[settings.name](arg);
		},
		maintainState: true,
		fullscreenDialog: false,
	);
}

Widget materialAppBuilder(BuildContext context, Widget widget) {
	Catcher.addDefaultErrorWidget(
		showStacktrace: true,
		title: "Custom error title",
		description: "Custom error description",
		maxWidthForSmallMode: 150
	);

	return widget;
}