import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_shell/repository/car_dao.dart';
import 'package:flutter_shell/repository/history_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'task.db');
  return openDatabase(path, onCreate: (db, version) {
    (db.execute(CarDao.tableSql));
    (db.execute(HistDao.tablehistSql));
  }, version: 1);
}
