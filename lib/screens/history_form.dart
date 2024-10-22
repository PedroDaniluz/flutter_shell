import 'package:flutter/material.dart';
import 'package:flutter_shell/repository/car_provider.dart';
import 'package:flutter_shell/repository/history_dao.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shell/repository/history_provider.dart';
import 'package:flutter_shell/repository/colors.dart';
import 'package:intl/intl.dart';

class FormHistory extends StatefulWidget {
  const FormHistory({required this.histContext, super.key});

  final BuildContext histContext;

  @override
  State<FormHistory> createState() => _FormHistoryState();
}

class _FormHistoryState extends State<FormHistory> {
  TextEditingController maintenanceDateController = TextEditingController();
  TextEditingController maintenanceDistController = TextEditingController();
  TextEditingController maintenanceProviderController = TextEditingController();
  final maintenanceNameController = ValueNotifier('');
  final List dropOptions = [
    'Alinhamento',
    'Balanceamento',
    'Cambagem',
    'Pneus Dianteiros',
    'Pneus Traseiros',
    'Bateria',
    'Filtro de Ar',
    'Filtro de Óleo',
    'Filtro de Combustível',
    'Freio',
    'Óleo de Motor',
    'Óleo de Freio',
    'Vela'
  ];

  final _formKey = GlobalKey<FormState>();

  bool emptyValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  bool kmValidator(String? value, int olderValue) {
    if (value != null && value.isEmpty) {
      return true;
    }
    try {
      int parsedKm = int.parse(value!);
      if (parsedKm <= olderValue) {
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
    final histData = Provider.of<MaintenanceHistory>(context);
    final carData = Provider.of<CarSpecs>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Registrar Manutenção'),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenWidth / 25, top: 45),
                  child: const Text(
                    'Registro de Manutenção',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontFamily: 'Futura'),
                  ),
                ),
                Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15, horizontal: screenWidth / 25),
                      child: ValueListenableBuilder(
                        valueListenable: maintenanceNameController,
                        builder: (BuildContext context, String value, _) {
                          bool isValueValid = dropOptions.contains(value);
                          return DropdownButtonFormField(
                            validator: (value) {
                              if (!isValueValid) {
                                return 'Escolha uma opcao';
                              }
                              return null;
                            },
                            hint: const Text(
                              'Selecione',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            value: (value.isEmpty) ? null : value,
                            onChanged: (escolha) => maintenanceNameController
                                .value = escolha.toString(),
                            items: dropOptions
                                .map((opcao) => DropdownMenuItem(
                                    value: opcao, child: Text(opcao)))
                                .toList(),
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CustomColors.purpleShell)),
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                              labelText: 'Peça da manutenção',
                            ),
                          );
                        },
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 15, horizontal: screenWidth / 25),
                  child: TextFormField(
                    validator: (value) {
                      if (emptyValidator(value)) {
                        return 'Insira o nome da empresa responsável';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    cursorColor: CustomColors.purpleShell,
                    controller: maintenanceProviderController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: CustomColors.purpleShell)),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      labelText: 'Provedor',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 15, horizontal: screenWidth / 25),
                  child: TextFormField(
                    validator: (value) {
                      if (kmValidator(value, int.parse(carData.carKm))) {
                        return 'Insira a quilometragem do veículo quando a manutenção foi realizada';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: maintenanceDistController,
                    cursorColor: CustomColors.purpleShell,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: CustomColors.purpleShell)),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      labelText: 'Quilometragem',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 15, horizontal: screenWidth / 25),
                  child: TextFormField(
                    validator: (value) {
                      if (emptyValidator(value)) {
                        return 'Insira a data da manutenção';
                      }

                      final dateFormat = DateFormat('dd/MM/yy');
                      final carDateFormat = DateFormat('y');
                      final parsedCarDate =
                          carDateFormat.parseStrict(carData.carYear);

                      try {
                        final parsedDate = dateFormat.parseStrict(value!);
                        final currentDate = DateTime.now();
                        if (parsedDate.isAfter(currentDate)) {
                          return 'A data deve ser anterior ou igual à data atual';
                        }
                        if (parsedDate.isBefore(parsedCarDate)) {
                          return 'A data deve ser posterior ao ano do veículo';
                        }
                        return null;
                      } catch (e) {
                        return 'Data Inválida. Use dd/mm/aaaa';
                      }
                    },
                    controller: maintenanceDateController,
                    cursorColor: CustomColors.purpleShell,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: CustomColors.purpleShell)),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      labelText: 'Data da manutenção',
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight / 10,
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: ElevatedButton(
              onPressed: () {
                final List<String> listAdd = [
                  maintenanceNameController.value,
                  maintenanceProviderController.text,
                  maintenanceDistController.text,
                  maintenanceDateController.text
                ];
                if (_formKey.currentState!.validate()) {
                  histData.addHistory(
                      maintenanceNameController.value, listAdd.join(', '));
                  HistDao().save(MaintenanceHistory(
                    alignment: histData.alignment,
                    balancing: histData.balancing,
                    camber: histData.camber,
                    battery: histData.battery,
                    breaks: histData.breaks,
                    fronttires: histData.fronttires,
                    backtires: histData.backtires,
                    filteroil: histData.filteroil,
                    filterfuel: histData.filterfuel,
                    filterair: histData.filterair,
                    oilEngine: histData.oilEngine,
                    oilBreak: histData.oilBreak,
                    sparkplug: histData.sparkplug,
                  ));
                  histData.loadDataFromDatabase();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Salvando')));
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvar'))),
    );
  }
}
