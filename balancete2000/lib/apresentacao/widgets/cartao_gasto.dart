import 'package:flutter/widgets.dart';
import 'package:balancete2000/apresentacao/widgets/etiqueta_categoria.dart';
import 'package:balancete2000/dominio/modelos/gasto.dart';
import 'package:balancete2000/nucleo/utilitarios/formatador_moeda.dart';

class CartaoGasto extends StatelessWidget {
  const CartaoGasto({
    super.key,
    required this.gasto,
    this.aoRemover,
    this.mostrarCategoria = true,
  });

  final Gasto gasto;
  final VoidCallback? aoRemover;
  final bool mostrarCategoria;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border(
          left: BorderSide(color: gasto.categoria.cor, width: 4),
          top: const BorderSide(color: Color(0xFF7F9DB9)),
          right: const BorderSide(color: Color(0xFF7F9DB9)),
          bottom: const BorderSide(color: Color(0xFF7F9DB9)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gasto.descricao,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (mostrarCategoria) EtiquetaCategoria(categoria: gasto.categoria),
                    Text(
                      _dataFormatada(gasto.registradoEm),
                      style: const TextStyle(fontSize: 10, color: Color(0xFF5C5C5C)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              FormatadorMoeda.formatar(gasto.valor),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9B1E00),
              ),
            ),
          ),
          if (aoRemover != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: aoRemover,
              child: Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF9B1E00),
                  border: Border.all(color: const Color(0xFF686868)),
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                ),
                child: const Text(
                  'X',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _dataFormatada(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final hora = data.hour.toString().padLeft(2, '0');
    final minuto = data.minute.toString().padLeft(2, '0');
    return '$dia/$mes/${data.year} $hora:$minuto';
  }
}