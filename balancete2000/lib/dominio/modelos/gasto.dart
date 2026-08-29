import 'package:balancete2000/dominio/enums/categoria_gasto.dart';

class Gasto {
  const Gasto({
    required this.identificador,
    required this.descricao,
    required this.valor,
    required this.categoria,
    required this.registradoEm,
  });

  final int identificador;
  final String descricao;
  final double valor;
  final CategoriaGasto categoria;
  final DateTime registradoEm;
}