import 'package:flutter/material.dart';
import 'package:flutter_shell/repository/car_provider.dart';
import 'package:flutter_shell/repository/colors.dart';
import 'package:flutter_shell/components/button_tab.dart';
import 'package:flutter_shell/components/ads_carousel.dart';
import 'package:flutter_shell/components/navbar.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  // Chamamos a função loadDataFromDatabase em initState para inicializar o app
  // com todos os dados salvos no database chamado nesse provider.
  void initState() {
    super.initState();
    final carData = Provider.of<CarSpecs>(context, listen: false);
    carData.loadDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // NavBar é a barra de navegação lateral, onde mudamos as telas.
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Início'),
        backgroundColor: CustomColors.yellowShell,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/topbarShell.png'),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Text(
                    // Aqui encontram-se as informações iniciais do veículo,
                    // atualizadas em tempo real pelo provider
                    '${context.watch<CarSpecs>().carBrand} ${context.watch<CarSpecs>().carName}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: screenWidth / 14,
                        color: CustomColors.purpleShell,
                        fontFamily: 'Futura',
                        decoration: TextDecoration.none),
                  ),
                ),
                Text(
                  context.watch<CarSpecs>().carYear,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: screenWidth / 30,
                      color: CustomColors.purpleShell,
                      fontFamily: 'Futura',
                      decoration: TextDecoration.none),
                ),
              ],
            ),

            // AdsCarousel contém os anúncios que ficam passando em carrossel
            const AdsCarousel(),

            // ButtonTab contém os botões que exibem os registros de manutenção
            const ButtonTab(),

            // Esses SizedBox() que aparecem ao longo do código servem para
            // ocupar um espaço, permitindo que o scroll vá mais longe
            SizedBox(
              height: screenHeight / 20,
            ),
          ],
        ),
      ),
    );
  }
}
