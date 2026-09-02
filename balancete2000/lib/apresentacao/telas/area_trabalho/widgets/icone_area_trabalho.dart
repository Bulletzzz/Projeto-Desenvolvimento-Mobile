import 'package:flutter/widgets.dart';
import 'package:balancete2000/apresentacao/widgets/mascote.dart';

/// Ícone de atalho para abrir aplicativo.
class IconeAreaTrabalho extends StatelessWidget {
  const IconeAreaTrabalho({super.key, required this.rotulo, required this.aoAbrir});

  final String rotulo;
  final VoidCallback aoAbrir;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: aoAbrir,
      child: SizedBox(
        width: 92,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LogoBalancete(altura: 56),
            const SizedBox(height: 4),
            Text(
              rotulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFFFFFFF),
                shadows: [Shadow(color: Color(0xFF0A246A), blurRadius: 3)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
