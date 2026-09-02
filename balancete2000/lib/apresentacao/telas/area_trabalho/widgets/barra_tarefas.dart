import 'package:flutter/widgets.dart';

/// Barra de tarefas com botão iniciar e relógio.
class BarraTarefas extends StatelessWidget {
  const BarraTarefas({super.key, required this.horario, this.recuoInferior = 0});

  final String horario;
  final double recuoInferior;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34 + recuoInferior, 
      padding: EdgeInsets.only(bottom: recuoInferior),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2A5BD7), Color(0xFF3F8CF3), Color(0xFF2A5BD7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.5, 1],
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5DA83E), Color(0xFF2F7A1B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: const Text(
              'iniciar',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            color: const Color(0xFF1275CE),
            child: Text(
              horario,
              style: const TextStyle(fontSize: 12, color: Color(0xFFFFFFFF)),
            ),
          ),
        ],
      ),
    );
  }
}
