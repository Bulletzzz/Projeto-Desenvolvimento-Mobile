import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// SVG do mascote
class Mascote extends StatelessWidget {
  const Mascote({super.key, this.altura = 72});

  final double altura;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/imagens/MrBalancete.svg',
      height: altura,
      fit: BoxFit.contain,
    );
  }
}

/// SVG do logo
class LogoBalancete extends StatelessWidget {
  const LogoBalancete({super.key, this.altura = 20});

  final double altura;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/imagens/Balancete2000.svg',
      height: altura,
      fit: BoxFit.contain,
    );
  }
}