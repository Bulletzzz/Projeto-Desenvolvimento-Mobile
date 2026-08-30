import 'package:flutter/material.dart';
import 'package:balancete2000/apresentacao/widgets/cartao_gasto.dart';
import 'package:balancete2000/dominio/enums/categoria_gasto.dart';
import 'package:balancete2000/dominio/modelos/gasto.dart';
import 'package:balancete2000/dominio/servicos/resumo_categorias.dart';
import 'package:balancete2000/nucleo/utilitarios/formatador_moeda.dart';

class TelaHistorico extends StatelessWidget {
  const TelaHistorico({super.key, required this.gastos});

  final List<Gasto> gastos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico por categoria')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: CategoriaGasto.values.map((categoria) {
          final daCategoria = ResumoCategorias.filtrar(gastos, categoria);
          final subtotal = ResumoCategorias.total(daCategoria);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${categoria.rotulo} — ${FormatadorMoeda.formatar(subtotal)}',
                style: TextStyle(fontWeight: FontWeight.bold, color: categoria.cor),
              ),
              const SizedBox(height: 6),
              ...daCategoria.map(
                (gasto) => CartaoGasto(gasto: gasto, mostrarCategoria: false),
              ),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }
}
