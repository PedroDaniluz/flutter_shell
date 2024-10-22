import 'package:flutter/material.dart';
import 'package:flutter_shell/components/ads_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AdsCarousel extends StatelessWidget {
  const AdsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Na lista de widgets 'ads' temos a chamada dos contrutures de anúncio,
    // basta inserir uma imagem 16/9 e o link do anúncio
    List<Widget> ads = [
      const AdsBuilder(
        image: 'assets/images/ad_shell.png',
        link: 'https://www.shell.com.br/motoristas/sobre-os-postos-shell.html',
      ),
      const AdsBuilder(
        image: 'assets/images/ad_porto_habitos.png',
        link:
            'https://blog.portoseguro.com.br/12-habitos-ao-dirigir-que-aumentam-o-consumo-de-combustivel',
      ),
      const AdsBuilder(
        image: 'assets/images/ad_porto_tempo.png',
        link:
            'https://blog.portoseguro.com.br/de-quanto-em-quanto-tempo-deve-se-fazer-a-revisao-do-carro',
      ),
      const AdsBuilder(
        image: 'assets/images/ad_shell_vp.png',
        link:
            'https://www.shell.com.br/motoristas/combustiveis/shell-v-power.html',
      ),
    ];

    // Aqui há o retorno da função, o contrutor do carrossel
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: CarouselSlider(
          items: ads,
          options: CarouselOptions(
            aspectRatio: 17 / 9,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
