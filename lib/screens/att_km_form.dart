import 'package:flutter/material.dart';
import 'package:flutter_shell/repository/car_dao.dart';
import 'package:flutter_shell/repository/colors.dart';
import 'package:flutter_shell/repository/car_provider.dart';
import 'package:provider/provider.dart';

class FormKmAtt extends StatefulWidget {
  const FormKmAtt({required this.kmDataContext, super.key});

  final BuildContext kmDataContext;

  @override
  State<FormKmAtt> createState() => _FormKmAttState();
}

class _FormKmAttState extends State<FormKmAtt> {
  TextEditingController carKmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(title: const Text('Atualizar Quilometragem')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth / 25, top: 45),
                child: const Text(
                  'Quilometragem Atual',
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
              const SizedBox(
                height: 100,
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
                    carName: carData.carName,
                    carBrand: carData.carBrand,
                    carYear: carData.carYear));
                carData.loadDataFromDatabase();
                Navigator.pop(context);
              }
            },
            child: const Text('Salvar alterações')),
      ),
    );
  }
}
