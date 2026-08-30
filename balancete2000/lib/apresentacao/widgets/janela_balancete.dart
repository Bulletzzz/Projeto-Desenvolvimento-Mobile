import 'package:flutter/widgets.dart';
import 'package:xp_ui/xp_ui.dart';
import 'package:balancete2000/apresentacao/widgets/mascote.dart';

class JanelaBalancete extends StatelessWidget {
  const JanelaBalancete({
    super.key,
    required this.titulo,
    required this.child,
    required this.rodape,
    this.detalheRodape,
    this.aoFechar,
  });

  final String titulo;
  final Widget child;
  final String rodape;
  final String? detalheRodape;
  final VoidCallback? aoFechar;

  @override
  Widget build(BuildContext context) {
    return XpWindow(
      titleBar: TitleBar(
        titulo,
        leading: const [
          Padding(
            padding: EdgeInsets.only(right: 4),
            child: LogoBalancete(altura: 18),
          ),
        ],
        trailing: [
          const TitleBarActionButton(icon: ActionButtonIcon.minimize),
          const TitleBarActionButton(icon: ActionButtonIcon.maximize),
          XpCloseButton(onPressed: aoFechar),
        ],
      ),
      statusBar: StatusBar(
        trailing: [
          if (detalheRodape != null) Text(detalheRodape!, style: const TextStyle(fontSize: 11)),
        ],
        child: Text(rodape, style: const TextStyle(fontSize: 11)),
      ),
      child: child,
    );
  }
}
