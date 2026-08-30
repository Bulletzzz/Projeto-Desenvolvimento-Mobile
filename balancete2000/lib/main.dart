import 'package:flutter/widgets.dart';
import 'package:xp_ui/xp_ui.dart';
import 'package:balancete2000/apresentacao/telas/principal/tela_principal.dart';
import 'package:balancete2000/nucleo/tema/tema_balancete.dart';

void main() => runApp(const AplicativoBalancete());

class AplicativoBalancete extends StatelessWidget {
  const AplicativoBalancete({super.key});

  @override
  Widget build(BuildContext context) {
    return XpApp(
      title: 'Balancete2000',
      theme: TemaBalancete.construir(),
      debugShowCheckedModeBanner: false,
      home: const TelaPrincipal(),
    );
  }
}