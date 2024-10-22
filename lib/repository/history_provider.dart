import 'package:flutter/material.dart';
import 'package:flutter_shell/repository/history_dao.dart';

class MaintenanceHistory extends ChangeNotifier {
  MaintenanceHistory({
    this.alignment = '',
    this.balancing = '',
    this.camber = '',
    this.battery = '',
    this.breaks = '',
    this.fronttires = '',
    this.backtires = '',
    this.filterair = '',
    this.filteroil = '',
    this.filterfuel = '',
    this.oilBreak = '',
    this.oilEngine = '',
    this.sparkplug = '',
  });

  String alignment;
  String balancing;
  String camber;
  String battery;
  String breaks;
  String fronttires;
  String backtires;
  String filterair;
  String filteroil;
  String filterfuel;
  String oilBreak;
  String oilEngine;
  String sparkplug;

  void addHistory(String name, String data) {
    switch (name) {
      case 'Alinhamento':
        alignment = '';
        alignment = data;
      case 'Balanceamento':
        balancing = '';
        balancing = data;
      case 'Cambagem':
        camber = '';
        camber = data;
      case 'Bateria':
        battery = '';
        battery = data;
      case 'Freio':
        breaks = '';
        breaks = data;
      case 'Pneus Dianteiros':
        fronttires = '';
        fronttires = data;
      case 'Pneus Traseiros':
        backtires = '';
        backtires = data;
      case 'Filtro de Ar':
        filterair = '';
        filterair = data;
      case 'Filtro de Óleo':
        filteroil = '';
        filteroil = data;
      case 'Filtro de Combustível':
        filterfuel = '';
        filterfuel = data;
      case 'Óleo de Freio':
        oilBreak = '';
        oilBreak = data;
      case 'Óleo de Motor':
        oilEngine = '';
        oilEngine = data;
      case 'Vela':
        sparkplug = '';
        sparkplug = data;
    }
    notifyListeners();
  }

  final histDao = HistDao();

  void loadDataFromDatabase() async {
    final List<MaintenanceHistory> history = await histDao.findAll();
    if (history.isNotEmpty) {
      final hist = history.last;
      alignment = hist.alignment;
      balancing = hist.balancing;
      camber = hist.camber;
      battery = hist.battery;
      breaks = hist.breaks;
      fronttires = hist.fronttires;
      backtires = hist.backtires;
      filterair = hist.filterair;
      filterfuel = hist.filterfuel;
      filteroil = hist.filteroil;
      oilBreak = hist.oilBreak;
      oilEngine = hist.oilEngine;
      sparkplug = hist.sparkplug;
      notifyListeners();
    }
  }
}
