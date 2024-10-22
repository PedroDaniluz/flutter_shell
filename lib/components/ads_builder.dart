import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsBuilder extends StatelessWidget {
  const AdsBuilder({super.key, required this.image, required this.link});

  final String link;
  final String image;

  @override
  Widget build(BuildContext context) {
    // O AdsBuilder, torna a imagem clicável e a encaixa no tamanho do carrossel
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          image,
          fit: BoxFit.fill,
        ),
      ),
      onTap: () {
        launchUrl(Uri.parse(link));
      },
    );
  }
}
