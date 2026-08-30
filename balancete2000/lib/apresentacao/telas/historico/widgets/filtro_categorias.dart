import 'package:flutter/widgets.dart';
import 'package:balancete2000/dominio/enums/categoria_gasto.dart';

class FiltroCategorias extends StatelessWidget {
  const FiltroCategorias({
    super.key,
    required this.selecionada,
    required this.aoSelecionar,
  });

  final CategoriaGasto? selecionada;
  final void Function(CategoriaGasto? categoria) aoSelecionar;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        _Aba(
          rotulo: 'Todas',
          cor: const Color(0xFF0A57C2),
          ativa: selecionada == null,
          aoTocar: () => aoSelecionar(null),
        ),
        ...CategoriaGasto.values.map(
          (categoria) => _Aba(
            rotulo: categoria.rotulo,
            cor: categoria.cor,
            ativa: selecionada == categoria,
            aoTocar: () => aoSelecionar(categoria),
          ),
        ),
      ],
    );
  }
}

class _Aba extends StatelessWidget {
  const _Aba({
    required this.rotulo,
    required this.cor,
    required this.ativa,
    required this.aoTocar,
  });

  final String rotulo;
  final Color cor;
  final bool ativa;
  final VoidCallback aoTocar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: aoTocar,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: ativa ? cor : const Color(0xFFFFFFFF),
          border: Border.all(color: cor),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
        child: Text(
          rotulo,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: ativa ? const Color(0xFFFFFFFF) : cor,
          ),
        ),
      ),
    );
  }
}