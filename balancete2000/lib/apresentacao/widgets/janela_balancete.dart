import 'package:flutter/widgets.dart';
import 'package:xp_ui/xp_ui.dart';
import 'package:balancete2000/apresentacao/widgets/mascote.dart';
import 'package:balancete2000/nucleo/tema/paleta.dart';

/// Janela base 
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
    final recuos = MediaQuery.paddingOf(context);
    final largura = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Container(height: recuos.top, color: Paleta.azulTitulo),
        Expanded(child: _janela(recuos, largura)),
        Container(height: recuos.bottom, color: Paleta.fundoJanela),
      ],
    );
  }

  Widget _janela(EdgeInsets recuos, double largura) {
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
          if (detalheRodape != null)
            _TextoRodape(texto: detalheRodape!, largura: largura * 0.3),
        ],
        child: _TextoRodape(texto: rodape, largura: largura * 0.45),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: recuos.left, right: recuos.right),
        child: child,
      ),
    );
  }
}

class _TextoRodape extends StatelessWidget {
  const _TextoRodape({required this.texto, required this.largura});

  final String texto;
  final double largura;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: largura,
      child: Text(
        texto,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}