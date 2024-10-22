import 'package:flutter/material.dart';
import 'package:flutter_shell/repository/car_dao.dart';
import 'package:flutter_shell/repository/colors.dart';
import 'package:flutter_shell/repository/car_provider.dart';
import 'package:provider/provider.dart';

class FormVehicle extends StatefulWidget {
  const FormVehicle({required this.vehicleDataContext, super.key});

  final BuildContext vehicleDataContext;

  @override
  State<FormVehicle> createState() => _FormVehicleState();
}

class _FormVehicleState extends State<FormVehicle> {
  TextEditingController carNameController = TextEditingController();
  TextEditingController carBrandController = TextEditingController();
  TextEditingController carYearController = TextEditingController();
  TextEditingController carKmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool emptyValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  bool yearValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    try {
      int parsedYear = int.parse(value!);
      if (parsedYear >= 1900 && parsedYear <= DateTime.now().year) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return true;
    }
  }

  bool kmValidator(String? value, int olderValue) {
    if (value != null && value.isEmpty) {
      return true;
    }
    try {
      int parsedKm = int.parse(value!);
      if (parsedKm >= olderValue) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final carData = Provider.of<CarSpecs>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(title: const Text('Cadastrar Veículo')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth / 25, top: 45),
                child: const Text(
                  'Dados do Veículo',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontFamily: 'Futura'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 15, horizontal: screenWidth / 25),
                child: TextFormField(
                  cursorColor: CustomColors.purpleShell,
                  keyboardType: TextInputType.name,
                  controller: carBrandController,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: CustomColors.purpleShell)),
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    labelText: 'Marca do veículo',
                  ),
                  validator: (value) {
                    if (emptyValidator(value)) {
                      return 'Insira a marca do veículo';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 15, horizontal: screenWidth / 25),
                child: TextFormField(
                  cursorColor: CustomColors.purpleShell,
                  keyboardType: TextInputType.name,
                  controller: carNameController,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: CustomColors.purpleShell)),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      labelText: 'Modelo do veículo'),
                  validator: (value) {
                    if (emptyValidator(value)) {
                      return 'Insira o modelo do veículo';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 15, horizontal: screenWidth / 25),
                child: TextFormField(
                  cursorColor: CustomColors.purpleShell,
                  keyboardType: TextInputType.number,
                  controller: carYearController,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: CustomColors.purpleShell)),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      labelText: 'Ano do veículo'),
                  validator: (value) {
                    if (yearValidator(value)) {
                      return 'Insira um ano válido';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 15, horizontal: screenWidth / 25),
                child: TextFormField(
                  cursorColor: CustomColors.purpleShell,
                  keyboardType: TextInputType.number,
                  controller: carKmController,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: CustomColors.purpleShell)),
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    labelText: 'Quilometragem do Veículo',
                  ),
                  validator: (value) {
                    if (kmValidator(value, int.parse(carData.carKm))) {
                      return 'Insira um valor válido';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: screenHeight / 10,
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                CarDao().save(CarSpecs(
                    carKm: carKmController.text,
                    carName: carNameController.text,
                    carBrand: carBrandController.text,
                    carYear: carYearController.text));
                carData.loadDataFromDatabase();
                Navigator.pop(context);
              }
            },
            child: const Text('Salvar alterações')),
      ),
    );
  }
}
