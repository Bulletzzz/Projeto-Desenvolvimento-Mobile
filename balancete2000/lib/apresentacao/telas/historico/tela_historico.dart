import 'package:flutter/widgets.dart';
import 'package:balancete2000/apresentacao/telas/historico/widgets/filtro_categorias.dart';
import 'package:balancete2000/apresentacao/telas/historico/widgets/grupo_categoria.dart';
import 'package:balancete2000/dominio/enums/categoria_gasto.dart';
import 'package:balancete2000/dominio/modelos/gasto.dart';
import 'package:balancete2000/dominio/servicos/resumo_categorias.dart';
import 'package:balancete2000/apresentacao/widgets/janela_balancete.dart';
import 'package:balancete2000/nucleo/utilitarios/formatador_moeda.dart';

class TelaHistorico extends StatefulWidget {
  const TelaHistorico({super.key, required this.gastos});

  final List<Gasto> gastos;

  @override
  State<TelaHistorico> createState() => _TelaHistoricoState();
}

class _TelaHistoricoState extends State<TelaHistorico> {
  CategoriaGasto? _filtro;

  List<ResumoCategoria> get _resumos {
    final todos = ResumoCategorias.calcular(widget.gastos);
    if (_filtro == null) return todos;
    return todos.where((resumo) => resumo.categoria == _filtro).toList();
  }

  @override
  Widget build(BuildContext context) {
    final totalExibido = _resumos.fold<double>(0, (soma, resumo) => soma + resumo.subtotal);
    return JanelaBalancete(
      titulo: 'Histórico',
      rodape: FormatadorMoeda.formatar(totalExibido),
      detalheRodape: _filtro?.rotulo ?? 'Todas',
      aoFechar: () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FiltroCategorias(
              selecionada: _filtro,
              aoSelecionar: (categoria) => setState(() => _filtro = categoria),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(right: 14),
                children: _resumos
                    .map((resumo) => GrupoCategoria(resumo: resumo))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}