import 'package:flutter/material.dart';
import 'package:flutter_shell/repository/colors.dart';
import 'package:flutter_shell/components/sheet_content.dart';

class SheetCaller1 extends StatelessWidget {
  const SheetCaller1({
    super.key,
    required this.distToNew,
    required this.imageAvatar,
    required this.textAvatar,
    required this.ballonText,
    required this.historyList,
    required this.herotag,
    this.isDateBased = false,
    this.dateAdd = 0,
  });

  final String herotag;
  final int distToNew;
  final String imageAvatar;
  final String textAvatar;
  final String ballonText;
  final String historyList;
  final bool isDateBased;
  final int dateAdd;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return FloatingActionButton(
      heroTag: herotag,
      backgroundColor: CustomColors.whiteBack,
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: screenHeight / 1.6,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SheetHead(
                          imageAvatar: imageAvatar, textAvatar: textAvatar),
                      SheetContent(
                          forecast: true,
                          ballonText: ballonText,
                          ballonForecast: (historyList == '')
                              ? "Sem Dados"
                              : (isDateBased)
                                  ? dateAdder(
                                      historyList.split(', ')[3], dateAdd)
                                  : '${(int.parse(historyList.split(', ')[2]) + distToNew).toString()} km'),
                      (historyList != '')
                          ? const HistoryHead()
                          : const SizedBox(),
                      (historyList == '')
                          ? const SizedBox()
                          : History(
                              serviceName: historyList.split(', ')[0],
                              providerName: historyList.split(', ')[1],
                              distHistory: '${historyList.split(', ')[2]} km',
                              dateHistory: historyList.split(', ')[3]),
                      const SizedBox(height: 50)
                    ],
                  ),
                ),
              );
            });
      },
      child: Image.asset(imageAvatar, color: CustomColors.purpleShell),
    );
  }
}

class SheetCaller2 extends StatelessWidget {
  const SheetCaller2({
    super.key,
    required this.distToNew1,
    required this.distToNew2,
    required this.imageAvatar,
    required this.textAvatar,
    required this.ballonText1,
    required this.ballonText2,
    required this.historyList1,
    required this.historyList2,
    required this.herotag,
    this.isDateBased1 = false,
    this.isDateBased2 = false,
    this.dateAdd1 = 0,
    this.dateAdd2 = 0,
  });

  final String herotag;
  final int distToNew1;
  final int distToNew2;
  final String imageAvatar;
  final String textAvatar;
  final String ballonText1;
  final String ballonText2;
  final String historyList1;
  final String historyList2;
  final bool isDateBased1;
  final int dateAdd1;
  final bool isDateBased2;
  final int dateAdd2;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return FloatingActionButton(
      heroTag: herotag,
      backgroundColor: CustomColors.whiteBack,
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: screenHeight / 1.6,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SheetHead(
                          imageAvatar: imageAvatar, textAvatar: textAvatar),
                      SheetContent(
                          forecast: true,
                          ballonText: ballonText1,
                          ballonForecast: (historyList1 == '')
                              ? "Sem Dados"
                              : (isDateBased1)
                                  ? dateAdder(
                                      historyList1.split(', ')[3], dateAdd1)
                                  : '${(int.parse(historyList1.split(', ')[2]) + distToNew1).toString()} km'),
                      SheetContent(
                          forecast: true,
                          ballonText: ballonText2,
                          ballonForecast: (historyList2 == '')
                              ? "Sem Dados"
                              : (isDateBased2)
                                  ? dateAdder(
                                      historyList2.split(', ')[3], dateAdd2)
                                  : '${(int.parse(historyList2.split(', ')[2]) + distToNew2).toString()} km'),
                      (historyList1 != '' || historyList2 != '')
                          ? const HistoryHead()
                          : const SizedBox(),
                      (historyList1 == '')
                          ? const SizedBox()
                          : History(
                              serviceName: historyList1.split(', ')[0],
                              providerName: historyList1.split(', ')[1],
                              distHistory: '${historyList1.split(', ')[2]} km',
                              dateHistory: historyList1.split(', ')[3]),
                      (historyList2 == '')
                          ? const SizedBox()
                          : History(
                              serviceName: historyList2.split(', ')[0],
                              providerName: historyList2.split(', ')[1],
                              distHistory: '${historyList2.split(', ')[2]} km',
                              dateHistory: historyList2.split(', ')[3]),
                      const SizedBox(height: 50)
                    ],
                  ),
                ),
              );
            });
      },
      child: Image.asset(imageAvatar, color: CustomColors.purpleShell),
    );
  }
}

class SheetCaller3 extends StatelessWidget {
  const SheetCaller3({
    super.key,
    required this.distToNew1,
    required this.distToNew2,
    required this.distToNew3,
    required this.imageAvatar,
    required this.textAvatar,
    required this.ballonText1,
    required this.ballonText2,
    required this.ballonText3,
    required this.historyList1,
    required this.historyList2,
    required this.historyList3,
    required this.herotag,
    this.isDateBased1 = false,
    this.isDateBased2 = false,
    this.isDateBased3 = false,
    this.dateAdd1 = 0,
    this.dateAdd2 = 0,
    this.dateAdd3 = 0,
  });

  final String herotag;
  final int distToNew1;
  final int distToNew2;
  final int distToNew3;
  final String imageAvatar;
  final String textAvatar;
  final String ballonText1;
  final String ballonText2;
  final String ballonText3;
  final String historyList1;
  final String historyList2;
  final String historyList3;
  final bool isDateBased1;
  final int dateAdd1;
  final bool isDateBased2;
  final int dateAdd2;
  final bool isDateBased3;
  final int dateAdd3;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return FloatingActionButton(
      heroTag: herotag,
      backgroundColor: CustomColors.whiteBack,
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: screenHeight / 1.6,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SheetHead(
                          imageAvatar: imageAvatar, textAvatar: textAvatar),
                      SheetContent(
                          forecast: true,
                          ballonText: ballonText1,
                          ballonForecast: (historyList1 == '')
                              ? "Sem Dados"
                              : (isDateBased1)
                                  ? dateAdder(
                                      historyList1.split(', ')[3], dateAdd1)
                                  : '${(int.parse(historyList1.split(', ')[2]) + distToNew1).toString()} km'),
                      SheetContent(
                          forecast: true,
                          ballonText: ballonText2,
                          ballonForecast: (historyList2 == '')
                              ? "Sem Dados"
                              : (isDateBased2)
                                  ? dateAdder(
                                      historyList2.split(', ')[3], dateAdd2)
                                  : '${(int.parse(historyList2.split(', ')[2]) + distToNew2).toString()} km'),
                      SheetContent(
                          forecast: true,
                          ballonText: ballonText3,
                          ballonForecast: (historyList3 == '')
                              ? "Sem Dados"
                              : (isDateBased3)
                                  ? dateAdder(
                                      historyList3.split(', ')[3], dateAdd3)
                                  : '${(int.parse(historyList3.split(', ')[2]) + distToNew3).toString()} km'),
                      (historyList1 != '' ||
                              historyList2 != '' ||
                              historyList3 != '')
                          ? const HistoryHead()
                          : const SizedBox(),
                      (historyList1 == '')
                          ? const SizedBox()
                          : History(
                              serviceName: historyList1.split(', ')[0],
                              providerName: historyList1.split(', ')[1],
                              distHistory: '${historyList1.split(', ')[2]} km',
                              dateHistory: historyList1.split(', ')[3]),
                      (historyList2 == '')
                          ? const SizedBox()
                          : History(
                              serviceName: historyList2.split(', ')[0],
                              providerName: historyList2.split(', ')[1],
                              distHistory: '${historyList2.split(', ')[2]} km',
                              dateHistory: historyList2.split(', ')[3]),
                      (historyList3 == '')
                          ? const SizedBox()
                          : History(
                              serviceName: historyList3.split(', ')[0],
                              providerName: historyList3.split(', ')[1],
                              distHistory: '${historyList3.split(', ')[2]} km',
                              dateHistory: historyList3.split(', ')[3]),
                      const SizedBox(height: 50)
                    ],
                  ),
                ),
              );
            });
      },
      child: Image.asset(imageAvatar, color: CustomColors.purpleShell),
    );
  }
}

class OutdatedBuilder extends StatelessWidget {
  const OutdatedBuilder(
      {super.key,
      required this.currentKm,
      required this.alignmentData,
      required this.balancingData,
      required this.camberData,
      required this.batteryData,
      required this.breaksData,
      required this.fronttiresData,
      required this.backtiresData,
      required this.filterairData,
      required this.filterfuelData,
      required this.filteroilData,
      required this.oilbreakData,
      required this.oilengineData,
      required this.sparkplugData});

  final int currentKm;
  final String alignmentData;
  final String balancingData;
  final String camberData;
  final String batteryData;
  final String breaksData;
  final String fronttiresData;
  final String backtiresData;
  final String filterairData;
  final String filteroilData;
  final String filterfuelData;
  final String oilbreakData;
  final String oilengineData;
  final String sparkplugData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SheetHead(
              imageAvatar: 'assets/icons/scratchs.png', textAvatar: 'Riscos'),
          (alignmentData == '' &&
                  balancingData == '' &&
                  camberData == '' &&
                  breaksData == '' &&
                  fronttiresData == '' &&
                  backtiresData == '' &&
                  batteryData == '' &&
                  filteroilData == '' &&
                  filterfuelData == '' &&
                  filterairData == '' &&
                  oilengineData == '' &&
                  oilbreakData == '' &&
                  sparkplugData == '')
              ? const SheetContent(
                  forecast: false, ballonText: 'Sem Dados', ballonForecast: '')
              : const SizedBox.shrink(),
          (alignmentData != '')
              ? OutdatedParts(
                  histData: alignmentData,
                  currentKm: currentKm,
                  distToNew: 10000,
                )
              : const SizedBox.shrink(),
          (balancingData != '')
              ? OutdatedParts(
                  histData: balancingData,
                  currentKm: currentKm,
                  distToNew: 10000,
                )
              : const SizedBox.shrink(),
          (camberData != '')
              ? OutdatedParts(
                  histData: camberData,
                  currentKm: currentKm,
                  distToNew: 10000,
                )
              : const SizedBox.shrink(),
          (breaksData != '')
              ? OutdatedParts(
                  histData: breaksData,
                  currentKm: currentKm,
                  distToNew: 35000,
                )
              : const SizedBox.shrink(),
          (batteryData != '')
              ? OutdatedParts(
                  histData: batteryData,
                  isDateBased: true,
                  yearsToNew: 2,
                )
              : const SizedBox.shrink(),
          (fronttiresData != '')
              ? OutdatedParts(
                  histData: fronttiresData,
                  currentKm: currentKm,
                  distToNew: 45000,
                )
              : const SizedBox.shrink(),
          (backtiresData != '')
              ? OutdatedParts(
                  histData: backtiresData,
                  currentKm: currentKm,
                  distToNew: 45000,
                )
              : const SizedBox.shrink(),
          (filterairData != '')
              ? OutdatedParts(
                  histData: filterairData,
                  currentKm: currentKm,
                  distToNew: 10000,
                )
              : const SizedBox.shrink(),
          (filterfuelData != '')
              ? OutdatedParts(
                  histData: filterfuelData,
                  currentKm: currentKm,
                  distToNew: 10000,
                )
              : const SizedBox.shrink(),
          (filteroilData != '')
              ? OutdatedParts(
                  histData: filteroilData,
                  currentKm: currentKm,
                  distToNew: 10000,
                )
              : const SizedBox.shrink(),
          (oilengineData != '')
              ? OutdatedParts(
                  histData: oilengineData,
                  currentKm: currentKm,
                  distToNew: 10000,
                )
              : const SizedBox.shrink(),
          (oilbreakData != '')
              ? OutdatedParts(
                  histData: oilbreakData,
                  currentKm: currentKm,
                  distToNew: 10000,
                )
              : const SizedBox.shrink(),
          (sparkplugData.isNotEmpty)
              ? OutdatedParts(
                  histData: sparkplugData,
                  currentKm: currentKm,
                  distToNew: 40000,
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}

dateAdder(String dateString, int yearAdder) {
  List<String> dateParts = dateString.split('/');

  String day = dateParts[0];
  String month = dateParts[1];
  int year = int.parse(dateParts[2]) + yearAdder;

  String newDateString = '$day/$month/$year';
  return newDateString;
}
