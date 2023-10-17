import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shell/repository/car_provider.dart';
import 'package:flutter_shell/repository/history_provider.dart';
import 'package:flutter_shell/repository/colors.dart';
import 'package:flutter_shell/screens/initial_screen.dart';

void main() {
  // É necessário estabelecer os providers (gerenciamento de estados) como
  // Widget "pai" do aplicativo.
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CarSpecs()),
    ChangeNotifierProvider(create: (context) => MaintenanceHistory()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Commander',
        theme: ThemeData(
          scaffoldBackgroundColor: CustomColors.whiteBack,
          primarySwatch: Colors.yellow,
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: CustomColors.whiteBack,
              titleTextStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'Futura',
                  decoration: TextDecoration.none)),
          bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: CustomColors.whiteBack,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30)))),
        ),
        home: const InitialScreen());
  }
}
