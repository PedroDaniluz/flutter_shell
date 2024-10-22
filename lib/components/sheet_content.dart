import 'package:flutter/material.dart';
import 'package:flutter_shell/repository/colors.dart';
import 'package:intl/intl.dart';

// SheetHead constroi o topo do BottomSheet, com a imagem e o texto escolhido
class SheetHead extends StatelessWidget {
  const SheetHead(
      {required this.imageAvatar, required this.textAvatar, super.key});

  final String imageAvatar;
  final String textAvatar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 4),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            child: CircleAvatar(
              backgroundColor: CustomColors.whiteLess,
              backgroundImage: AssetImage(imageAvatar),
              radius: 35,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 22),
          child: Text(textAvatar,
              style: const TextStyle(
                  fontSize: 20, color: CustomColors.purpleShell)),
        ),
      ],
    );
  }
}

// SheetContent, mostra os primeiros balões, que em geral mostram a próxima manutenção
class SheetContent extends StatelessWidget {
  const SheetContent(
      {required this.forecast,
      required this.ballonText,
      required this.ballonForecast,
      super.key});

  final String ballonText;
  final String ballonForecast;
  final bool forecast;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                height: 65,
                width: screenWidth / 1.1,
                decoration: BoxDecoration(
                    color: CustomColors.whiteLess,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ballonText,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: CustomColors.purpleShell),
                      ),
                      (forecast
                          ? Text(
                              ballonForecast,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: CustomColors.purpleShell),
                            )
                          : const SizedBox())
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// HistoryHead constroi somente o cabeçalho do histórico, com o texo e o ícone
class HistoryHead extends StatelessWidget {
  const HistoryHead({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Última Manutenção',
              style: TextStyle(fontSize: 20, color: CustomColors.purpleShell)),
          Icon(
            Icons.history,
            color: CustomColors.purpleShell,
          )
        ],
      ),
    );
  }
}

// History constrói o balão do histórico, que contém o tipo de serviço, o provedor,
// a data e a quilometragem na data da manutenção.
class History extends StatelessWidget {
  const History(
      {required this.serviceName,
      required this.providerName,
      required this.distHistory,
      required this.dateHistory,
      super.key});

  final String serviceName;
  final String providerName;
  final String distHistory;
  final String dateHistory;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 8,
        child: Container(
          height: 65,
          width: screenWidth / 1.1,
          decoration: BoxDecoration(
              color: CustomColors.whiteLess,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: CustomColors.purpleShell),
                    ),
                    Text(
                      providerName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: CustomColors.purpleShell),
                    ),
                    Text(
                      distHistory,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: CustomColors.purpleShell),
                    )
                  ],
                ),
                Text(
                  dateHistory,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: CustomColors.purpleShell),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// OutdatedParts é especial para o botão Riscos, aqui há comparadores para verificar
// se a manutenção está vencida, com base na quilometragem atual ou data atual e na validade da
// manutenção em KM ou Tempo
class OutdatedParts extends StatelessWidget {
  const OutdatedParts({
    super.key,
    required this.histData,
    this.currentKm = 0,
    this.isDateBased = false,
    this.distToNew = 0,
    this.yearsToNew = 0,
  });

  final String histData;
  final int currentKm;
  final int distToNew;
  final int yearsToNew;
  final bool isDateBased;

  bool isOutdatedKM() {
    if ((int.parse(histData.split(', ')[2]) + distToNew) <= currentKm) {
      return true;
    } else {
      return false;
    }
  }

  bool isOutdated() {
    final dateFormat = DateFormat('dd/MM/yy');
    final currentDate = DateTime.now();
    final parsedMaintenanceDate =
        dateFormat.parseStrict(histData.split(', ')[3]);
    final limitDate =
        parsedMaintenanceDate.add(Duration(days: yearsToNew * 365));
    if (limitDate.isBefore(currentDate)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isDateBased) // Se for baseado em data:
        ? (isOutdated()) // Se estiver vencido na data:
            ? SheetContent(
                forecast: false,
                ballonText: '"${histData.split(', ')[0]}" Vencido',
                ballonForecast: '',
              )
            : const SizedBox.shrink() // Senão:
        : (isOutdatedKM()) // Senão, Se estiver vencido no Km:
            ? SheetContent(
                forecast: false,
                ballonText: '"${histData.split(', ')[0]}" Vencido',
                ballonForecast: '',
              )
            : const SizedBox.shrink(); // Senão:
  }
}
