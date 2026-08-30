import 'package:flutter/material.dart';
import 'package:balancete2000/apresentacao/telas/historico/widgets/filtro_categorias.dart';
import 'package:balancete2000/apresentacao/telas/historico/widgets/grupo_categoria.dart';
import 'package:balancete2000/dominio/enums/categoria_gasto.dart';
import 'package:balancete2000/dominio/modelos/gasto.dart';
import 'package:balancete2000/dominio/servicos/resumo_categorias.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico por categoria')),
      body: Padding(
        padding: const EdgeInsets.all(12),
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