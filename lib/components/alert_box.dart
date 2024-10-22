import 'package:flutter/material.dart';
import 'package:flutter_shell/repository/colors.dart';

class AlertBox extends StatelessWidget {
  const AlertBox({super.key});

  @override
  Widget build(BuildContext context) {
    // Aqui os recursos são apenas front-end, um simple aviso que indica a
    // necessidade de cadastrar o veículo antes de qualquer coisa
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      icon: Image.asset(
        'assets/icons/alert_icon.png',
        height: 100,
      ),
      title: const Center(
        child: Text(
          'Veículo não registrado',
          style:
              TextStyle(color: CustomColors.darkPurple, fontFamily: 'Futura'),
        ),
      ),
      content: const Text(
        'Para registrar e agendar manutencão ou atualizar a quilometragem, '
        'é necessário cadastrar o veículo',
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    backgroundColor: CustomColors.whiteLess,
                    fixedSize: const Size(150, 40)),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Entendi',
                  style: TextStyle(color: CustomColors.darkPurple),
                )))
      ],
    );
  }
}
