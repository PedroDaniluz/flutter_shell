import 'package:flutter_shell/repository/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_shell/repository/history_provider.dart';

class HistDao {
  static const String tablehistSql = 'CREATE TABLE $_tablename('
      '$_alignment TEXT, '
      '$_balancing TEXT, '
      '$_camber TEXT, '
      '$_battery TEXT, '
      '$_breaks TEXT, '
      '$_fronttires TEXT, '
      '$_backtires TEXT, '
      '$_filterair TEXT, '
      '$_filterfuel TEXT, '
      '$_filteroil TEXT, '
      '$_oilbreak TEXT, '
      '$_oilengine TEXT, '
      '$_sparkplug TEXT)';

  static const String _tablename = 'histTable';
  static const String _alignment = 'alignment';
  static const String _balancing = 'balancing';
  static const String _camber = 'camber';
  static const String _battery = 'battery';
  static const String _breaks = 'breaks';
  static const String _fronttires = 'fronttires';
  static const String _backtires = 'backtires';
  static const String _filterair = 'filterair';
  static const String _filterfuel = 'filterfuel';
  static const String _filteroil = 'filteroil';
  static const String _oilbreak = 'oilbreak';
  static const String _oilengine = 'oilengine';
  static const String _sparkplug = 'sparkplug';

  Map<String, dynamic> toMap(MaintenanceHistory histy) {
    final Map<String, dynamic> histMap = {};
    histMap[_alignment] = histy.alignment;
    histMap[_balancing] = histy.balancing;
    histMap[_camber] = histy.camber;
    histMap[_battery] = histy.battery;
    histMap[_breaks] = histy.breaks;
    histMap[_fronttires] = histy.fronttires;
    histMap[_backtires] = histy.backtires;
    histMap[_filterair] = histy.filterair;
    histMap[_filterfuel] = histy.filterfuel;
    histMap[_filteroil] = histy.filteroil;
    histMap[_oilbreak] = histy.oilBreak;
    histMap[_oilengine] = histy.oilEngine;
    histMap[_sparkplug] = histy.sparkplug;
    return histMap;
  }

  List<MaintenanceHistory> toList(List<Map<String, dynamic>> history) {
    final List<MaintenanceHistory> hists = [];
    for (Map<String, dynamic> line in history) {
      final MaintenanceHistory histUn = MaintenanceHistory(
          alignment: line[_alignment],
          balancing: line[_balancing],
          camber: line[_camber],
          battery: line[_battery],
          breaks: line[_breaks],
          fronttires: line[_fronttires],
          backtires: line[_backtires],
          filterair: line[_filterair],
          filterfuel: line[_filterfuel],
          filteroil: line[_filteroil],
          oilBreak: line[_oilbreak],
          oilEngine: line[_oilengine],
          sparkplug: line[_sparkplug]);
      hists.add(histUn);
    }
    return hists;
  }

  save(MaintenanceHistory hist) async {
    final Database historyDatabase = await getDatabase();
    Map<String, dynamic> histMap = toMap(hist);
    return await historyDatabase.insert(
      _tablename,
      histMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<MaintenanceHistory>> findAll() async {
    final Database historyDatabase = await getDatabase();
    final List<Map<String, dynamic>> result =
        await historyDatabase.query(_tablename);
    return toList(result);
  }
}
