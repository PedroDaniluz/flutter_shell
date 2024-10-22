import 'package:flutter/material.dart';
import 'package:flutter_shell/repository/colors.dart';

class FormMaintenance extends StatefulWidget {
  const FormMaintenance({required this.maintenanceContext, super.key});

  final BuildContext maintenanceContext;

  @override
  State<FormMaintenance> createState() => _FormMaintenanceState();
}

class _FormMaintenanceState extends State<FormMaintenance> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userZipCodeController = TextEditingController();
  TextEditingController carNameController = TextEditingController();
  TextEditingController carBrandController = TextEditingController();
  TextEditingController carYearController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(title: const Text('Agendar Manutenção')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth / 25, top: 45),
                child: const Text(
                  'Agendamento',
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
                  controller: userNameController,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: CustomColors.purpleShell)),
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    labelText: 'Nome completo',
                  ),
                  validator: (value) {
                    if (emptyValidator(value)) {
                      return 'Insira o seu nome';
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
                  controller: userZipCodeController,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: CustomColors.purpleShell)),
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    labelText: 'Código Postal (CEP)',
                  ),
                  validator: (value) {
                    if (emptyValidator(value)) {
                      return 'Insira o seu CEP';
                    }
                    return null;
                  },
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
                Navigator.pop(context);
              }
            },
            child: const Text('Solicitar Manutenção')),
      ),
    );
  }
}
