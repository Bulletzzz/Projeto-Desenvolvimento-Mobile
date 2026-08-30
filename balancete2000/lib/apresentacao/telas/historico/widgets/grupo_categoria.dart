import 'package:flutter/widgets.dart';
import 'package:balancete2000/apresentacao/widgets/cartao_gasto.dart';
import 'package:balancete2000/dominio/servicos/resumo_categorias.dart';
import 'package:balancete2000/nucleo/utilitarios/formatador_moeda.dart';

class GrupoCategoria extends StatelessWidget {
  const GrupoCategoria({super.key, required this.resumo});

  final ResumoCategoria resumo;

  @override
  Widget build(BuildContext context) {
    final categoria = resumo.categoria;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: categoria.corFundo,
              border: Border.all(color: categoria.cor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categoria.rotulo,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: categoria.cor,
                        ),
                      ),
                      Text(
                        resumo.gastos.length == 1
                            ? '1 item'
                            : '${resumo.gastos.length} itens',
                        style: const TextStyle(fontSize: 10, color: Color(0xFF5C5C5C)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    FormatadorMoeda.formatar(resumo.subtotal),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: categoria.cor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${(resumo.participacao * 100).toStringAsFixed(1)}% do total',
            style: const TextStyle(fontSize: 11, color: Color(0xFF5C5C5C)),
          ),
          const SizedBox(height: 6),
          if (resumo.vazio)
            const Text(
              'Sem lançamentos nesta categoria.',
              style: TextStyle(fontSize: 11, color: Color(0xFF5C5C5C)),
            )
          else
            ...resumo.gastos.map(
              (gasto) => CartaoGasto(gasto: gasto, mostrarCategoria: false),
            ),
        ],
      ),
    );
  }
}