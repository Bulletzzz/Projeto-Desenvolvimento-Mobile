import 'package:flutter/material.dart' show MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:xp_ui/xp_ui.dart';
import 'package:balancete2000/dominio/enums/categoria_gasto.dart';
import 'package:balancete2000/nucleo/utilitarios/formatador_moeda.dart';
import 'package:balancete2000/apresentacao/widgets/cartao_gasto.dart';
import 'package:balancete2000/apresentacao/telas/historico/tela_historico.dart';
import 'package:balancete2000/dados/repositorio_gastos.dart';
import 'package:balancete2000/dominio/modelos/gasto.dart';
import 'package:balancete2000/apresentacao/widgets/janela_balancete.dart';
import 'package:balancete2000/apresentacao/telas/principal/widgets/formulario_gasto.dart';
import 'package:balancete2000/nucleo/tema/paleta.dart';
import 'package:balancete2000/apresentacao/widgets/aviso_vazio.dart';
import 'package:balancete2000/apresentacao/telas/area_trabalho/tela_area_trabalho.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  late RepositorioGastos _repositorio;

  @override
  void initState() {
    _repositorio = RepositorioGastos();
    super.initState();
  }

  void _adicionar(String descricao, double valor, CategoriaGasto categoria) {
    setState(() {
      _repositorio.adicionar(descricao: descricao, valor: valor, categoria: categoria);
    });
  }

  Future<void> _confirmarRemocao(Gasto gasto) async {
    final confirmado = await showXpDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => XpAlertDialog(
        title: 'Excluir lançamento',
        alerType: AlertType.question,
        content: Text(
          'Remover "${gasto.descricao}" no valor de ${FormatadorMoeda.formatar(gasto.valor)}?',
          style: const TextStyle(fontSize: 12),
        ),
        actions: [
          Button(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
          Button(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );

    if (confirmado != true) return;
    setState(() {
      _repositorio.remover(gasto.identificador);
    });
  }

  void _abrirHistorico() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => TelaHistorico(gastos: _repositorio.gastos),
      ),
    );
  }

  Future<void> _confirmarSaida() async {
    final sair = await showXpDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => XpAlertDialog(
        title: 'Sair do Balancete2000',
        alerType: AlertType.warning,
        content: const Text(
          'Deseja realmente encerrar o programa?',
          style: TextStyle(fontSize: 12),
        ),
        actions: [
          Button(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sim'),
          ),
          Button(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Não'),
          ),
        ],
      ),
    );

    if (sair != true || !mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => TelaAreaTrabalho(
          aoAbrirAplicativo: () => Navigator.pop(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return JanelaBalancete(
      titulo: 'Balancete2000',
      rodape: 'Total: ${FormatadorMoeda.formatar(_repositorio.total)}',
      detalheRodape: '${_repositorio.quantidade} itens',
      aoFechar: _confirmarSaida,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: Paleta.azulTitulo,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TOTAL GERAL',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Paleta.branco,
                    ),
                  ),
                  Text(
                    FormatadorMoeda.formatar(_repositorio.total),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Paleta.branco,
                    ),
                  ),
                  Text(
                    _repositorio.quantidade == 1 ? '1 lançamento' : '${_repositorio.quantidade} lançamentos',
                    style: const TextStyle(fontSize: 11, color: Paleta.branco),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            FormularioGasto(aoConfirmar: _adicionar),
            const SizedBox(height: 8),
            Button(onPressed: _abrirHistorico, child: const Text('Ver por categoria')),
            const SizedBox(height: 12),
            Expanded(
              child: _repositorio.quantidade == 0
                  ? const AvisoVazio(
                      mensagem: 'Nenhum gasto lançado ainda',
                      detalhe: 'Preencha a descrição e o valor para começar.',
                    )
                  : ListView.builder(
                itemCount: _repositorio.quantidade,
                itemBuilder: (context, indice) {
                  final gasto = _repositorio.gastos[indice];
                  return CartaoGasto(
                    gasto: gasto,
                    aoRemover: () => _confirmarRemocao(gasto),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}