import 'package:flutter/widgets.dart';
import 'package:balancete2000/apresentacao/telas/area_trabalho/widgets/barra_tarefas.dart';
import 'package:balancete2000/apresentacao/telas/area_trabalho/widgets/icone_area_trabalho.dart';

/// Area de trabalho windows xp
class TelaAreaTrabalho extends StatefulWidget {
  const TelaAreaTrabalho({super.key, required this.aoAbrirAplicativo});

  final VoidCallback aoAbrirAplicativo;

  @override
  State<TelaAreaTrabalho> createState() => _TelaAreaTrabalhoState();
}

class _TelaAreaTrabalhoState extends State<TelaAreaTrabalho> {
  String get _horario {
    final agora = DateTime.now();
    return '${agora.hour.toString().padLeft(2, '0')}:'
        '${agora.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/imagens/images.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconeAreaTrabalho(
                    rotulo: 'Balancete2000',
                    aoAbrir: widget.aoAbrirAplicativo,
                  ),
                ),
              ),
            ),
          ),
          BarraTarefas(
            horario: _horario,
            recuoInferior: MediaQuery.paddingOf(context).bottom,
          ),
        ],
      ),
    );
  }
}
