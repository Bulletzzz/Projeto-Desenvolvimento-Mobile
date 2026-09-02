import 'package:balancete2000/dominio/enums/categoria_gasto.dart';
import 'package:balancete2000/dominio/modelos/gasto.dart';
import 'package:balancete2000/dominio/servicos/resumo_categorias.dart';

/// CRUD
class RepositorioGastos {
  final List<Gasto> _gastos = <Gasto>[];
  int _proximoIdentificador = 1;

  List<Gasto> get gastos => List<Gasto>.unmodifiable(_gastos);

  int get quantidade => _gastos.length;

  double get total => ResumoCategorias.total(_gastos);

  Gasto adicionar({
    required String descricao,
    required double valor,
    required CategoriaGasto categoria,
  }) {
    final gasto = Gasto(
      identificador: _proximoIdentificador++,
      descricao: descricao,
      valor: valor,
      categoria: categoria,
      registradoEm: DateTime.now(),
    );
    _gastos.insert(0, gasto);
    return gasto;
  }

  void remover(int identificador) {
    _gastos.removeWhere((gasto) => gasto.identificador == identificador);
  }

  List<Gasto> porCategoria(CategoriaGasto categoria) {
    return ResumoCategorias.filtrar(_gastos, categoria);
  }

  List<ResumoCategoria> resumo() => ResumoCategorias.calcular(_gastos);
}