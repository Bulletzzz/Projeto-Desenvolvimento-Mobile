import 'package:flutter/material.dart';
import 'package:balancete2000/apresentacao/telas/principal/tela_principal.dart';

void main() => runApp(const AplicativoBalancete());

class AplicativoBalancete extends StatelessWidget {
  const AplicativoBalancete({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Balancete2000',
      home: TelaPrincipal(),
    );
  }
}