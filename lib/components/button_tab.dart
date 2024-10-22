import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shell/repository/car_provider.dart';
import 'package:flutter_shell/repository/history_provider.dart';
import 'package:flutter_shell/repository/colors.dart';
import 'package:flutter_shell/components/sheet_builder.dart';

// Agora as coisas ficam mais confusas, mas espero conseguir explicar

class ButtonTab extends StatefulWidget {
  const ButtonTab({super.key});

  @override
  State<ButtonTab> createState() => _ButtonTabState();
}

class _ButtonTabState extends State<ButtonTab> {
  @override
  void initState() {
    // Como na InitialScreen(), o loadDataFromDatabase, busca os dados guardados
    super.initState();
    final histData = Provider.of<MaintenanceHistory>(context, listen: false);
    histData.loadDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final carData = Provider.of<CarSpecs>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth / 17),
                child: Text(
                  'Condição do Veículo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: screenWidth / 18,
                      color: CustomColors.purpleShell,
                      fontFamily: 'Futura',
                      decoration: TextDecoration.none),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: 15, left: screenWidth / 18, right: screenWidth / 18),
          child: Container(
            height: 2.5,
            color: CustomColors.purpleShell,
          ),
        ),

        // Optamos por fazer uma linha com várias colunas de botões
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                // Esse primeiro botão é o mais complexo, ele mostra as manutenções vencidas
                FloatingActionButton(
                  heroTag: 'scratchs',
                  backgroundColor: CustomColors.whiteBack,
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: screenHeight / 1.6,
                            // OutdatedBuilder() constroi no bottomSheet a informação
                            // que a manutenção está vencida, caso esteja. Recebe
                            // todas as informações de manutenção e a KM do veículo
                            child: OutdatedBuilder(
                                currentKm: int.parse(carData.carKm),
                                alignmentData: context
                                    .watch<MaintenanceHistory>()
                                    .alignment,
                                balancingData: context
                                    .watch<MaintenanceHistory>()
                                    .balancing,
                                camberData:
                                    context.watch<MaintenanceHistory>().camber,
                                batteryData:
                                    context.watch<MaintenanceHistory>().battery,
                                breaksData:
                                    context.watch<MaintenanceHistory>().breaks,
                                fronttiresData: context
                                    .watch<MaintenanceHistory>()
                                    .fronttires,
                                backtiresData: context
                                    .watch<MaintenanceHistory>()
                                    .backtires,
                                filterairData: context
                                    .watch<MaintenanceHistory>()
                                    .filterair,
                                filterfuelData: context
                                    .watch<MaintenanceHistory>()
                                    .filterfuel,
                                filteroilData: context
                                    .watch<MaintenanceHistory>()
                                    .filteroil,
                                oilbreakData: context
                                    .watch<MaintenanceHistory>()
                                    .oilBreak,
                                oilengineData: context
                                    .watch<MaintenanceHistory>()
                                    .oilEngine,
                                sparkplugData: context
                                    .watch<MaintenanceHistory>()
                                    .sparkplug),
                          );
                        });
                  },
                  child: Image.asset('assets/icons/scratchs.png',
                      color: CustomColors.purpleShell),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 15),
                  child: Text(
                    'Riscos',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                ),

                // Vou explicar os SheetCaller no próximo
                SheetCaller2(
                    herotag: 'tires',
                    distToNew1: 45000,
                    distToNew2: 45000,
                    imageAvatar: 'assets/icons/tires.png',
                    textAvatar: 'Pneus',
                    ballonText1: 'Próxima troca (dianteiros)',
                    ballonText2: 'Próxima troca (traseiros)',
                    historyList1:
                        context.watch<MaintenanceHistory>().fronttires,
                    historyList2:
                        context.watch<MaintenanceHistory>().backtires),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'Pneus',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                )
              ],
            ),
            Column(
              children: [
                // Basicamente, ele constroi o conteudo do BottomSheet, utilizando
                // as informações de manutenção e a distância para a próxima mantenção.
                // Esse context.watch() é uma função do provider, para atualizar
                // apenas quando a variável for modificada. Importante ressaltar
                // que guardamos as informações de manutenção em Strings
                SheetCaller3(
                    herotag: 'aligment',
                    distToNew1: 10000,
                    distToNew2: 10000,
                    distToNew3: 10000,
                    imageAvatar: 'assets/icons/alignment.png',
                    textAvatar: 'Alinhamento',
                    ballonText1: 'Próximo alinhamento',
                    ballonText2: 'Próximo balanceamento',
                    ballonText3: 'Próxima cambagem',
                    historyList1: context.watch<MaintenanceHistory>().alignment,
                    historyList2: context.watch<MaintenanceHistory>().balancing,
                    historyList3: context.watch<MaintenanceHistory>().camber),
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 15),
                  child: Text(
                    'Alinhamento',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                SheetCaller2(
                    herotag: 'oil',
                    distToNew1: 10000,
                    distToNew2: 10000,
                    imageAvatar: 'assets/icons/oil.png',
                    textAvatar: 'Óleos',
                    ballonText1: 'Próxima troca (óleo de motor)',
                    ballonText2: 'Próxima troca (óleo de freio)',
                    historyList1: context.watch<MaintenanceHistory>().oilEngine,
                    historyList2: context.watch<MaintenanceHistory>().oilBreak),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'Óleos',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                )
              ],
            ),
            Column(
              children: [
                // No caso da bateria por exemplo, usamos a data como parâmetro para
                // sua troca, portanto, isDateBased = true, e dateAdd = 2 ANOS
                SheetCaller1(
                  distToNew: 0,
                  herotag: '',
                  imageAvatar: 'assets/icons/battery.png',
                  textAvatar: 'Bateria',
                  ballonText: 'Próxima Troca',
                  historyList: context.watch<MaintenanceHistory>().battery,
                  isDateBased: true,
                  dateAdd: 2,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 15),
                  child: Text(
                    'Bateria',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                SheetCaller1(
                    herotag: 'sparkplug',
                    distToNew: 40000,
                    imageAvatar: 'assets/icons/sparkplug.png',
                    textAvatar: 'Velas',
                    ballonText: 'Próxima Troca',
                    historyList: context.watch<MaintenanceHistory>().sparkplug),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'Velas',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                )
              ],
            ),
            Column(
              children: [
                SheetCaller3(
                    herotag: 'filter',
                    distToNew1: 10000,
                    distToNew2: 10000,
                    distToNew3: 10000,
                    imageAvatar: 'assets/icons/filter.png',
                    textAvatar: 'Filtros',
                    ballonText1: 'Próxima troca (óleo)',
                    ballonText2: 'Próxima troca (combustível)',
                    ballonText3: 'Próxima troca (ar)',
                    historyList1: context.watch<MaintenanceHistory>().filteroil,
                    historyList2:
                        context.watch<MaintenanceHistory>().filterfuel,
                    historyList3:
                        context.watch<MaintenanceHistory>().filterair),
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 15),
                  child: Text(
                    'Filtros',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                SheetCaller1(
                    herotag: 'break',
                    distToNew: 35000,
                    imageAvatar: 'assets/icons/break.png',
                    textAvatar: 'Freios',
                    ballonText: 'Próxima Troca',
                    historyList: context.watch<MaintenanceHistory>().breaks),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'Freios',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
