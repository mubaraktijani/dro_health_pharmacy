import '../app/database/cart_table.dart';

List<String> migration = [
	CartTable().createTable
];

List<String> migrationOnUpgrade = [
];