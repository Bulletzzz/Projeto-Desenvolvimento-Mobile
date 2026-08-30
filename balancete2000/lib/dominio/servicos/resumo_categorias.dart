import 'package:balancete2000/dominio/enums/categoria_gasto.dart';
import 'package:balancete2000/dominio/modelos/gasto.dart';

class ResumoCategoria {
  const ResumoCategoria({
    required this.categoria,
    required this.gastos,
    required this.subtotal,
    required this.participacao,
  });

  final CategoriaGasto categoria;
  final List<Gasto> gastos;
  final double subtotal;
  final double participacao;

  bool get vazio => gastos.isEmpty;
}

class ResumoCategorias {
  static double total(List<Gasto> gastos) {
    return gastos.fold(0, (soma, gasto) => soma + gasto.valor);
  }

  static List<Gasto> filtrar(List<Gasto> gastos, CategoriaGasto categoria) {
    return gastos.where((gasto) => gasto.categoria == categoria).toList();
  }

  static List<ResumoCategoria> calcular(List<Gasto> gastos) {
    final geral = total(gastos);
    return CategoriaGasto.values.map((categoria) {
      final daCategoria = filtrar(gastos, categoria);
      final subtotal = total(daCategoria);
      return ResumoCategoria(
        categoria: categoria,
        gastos: daCategoria,
        subtotal: subtotal,
        participacao: geral == 0 ? 0 : subtotal / geral,
      );
    }).toList();
  }
}