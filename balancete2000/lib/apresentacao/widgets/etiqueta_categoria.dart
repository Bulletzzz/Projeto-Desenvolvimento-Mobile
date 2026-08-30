import 'package:flutter/widgets.dart';
import 'package:balancete2000/dominio/enums/categoria_gasto.dart';

class EtiquetaCategoria extends StatelessWidget {
  const EtiquetaCategoria({super.key, required this.categoria});

  final CategoriaGasto categoria;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: categoria.corFundo,
        border: Border.all(color: categoria.cor),
        borderRadius: const BorderRadius.all(Radius.circular(2)),
      ),
      child: Text(
        categoria.rotulo,
        style: TextStyle(
          color: categoria.cor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}