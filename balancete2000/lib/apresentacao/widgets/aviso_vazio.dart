import 'package:flutter/widgets.dart';
import 'package:balancete2000/apresentacao/widgets/mascote.dart';
import 'package:balancete2000/nucleo/tema/paleta.dart';

class AvisoVazio extends StatelessWidget {
  const AvisoVazio({super.key, required this.mensagem, this.detalhe});

  final String mensagem;
  final String? detalhe;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Mascote(altura: 88),
          const SizedBox(height: 8),
          Text(
            mensagem,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Paleta.texto,
            ),
          ),
          if (detalhe != null) ...[
            const SizedBox(height: 4),
            Text(
              detalhe!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: Paleta.textoFraco),
            ),
          ],
        ],
      ),
    );
  }
}