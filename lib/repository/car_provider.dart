import 'package:flutter/material.dart';
import 'package:flutter_shell/repository/car_dao.dart';

class CarSpecs extends ChangeNotifier {
  CarSpecs(
      {this.carName = '',
      this.carBrand = '',
      this.carKm = '0',
      this.carYear = 'Registre as informações do veículo'});

  final carDao = CarDao();

  String carName;
  String carBrand;
  String carYear;
  String carKm;

  void loadDataFromDatabase() async {
    final List<CarSpecs> carList = await carDao.findAll();
    if (carList.isNotEmpty) {
      final car = carList.last;
      carName = car.carName;
      carBrand = car.carBrand;
      carYear = car.carYear;
      carKm = car.carKm;
      notifyListeners();
    }
  }
}
