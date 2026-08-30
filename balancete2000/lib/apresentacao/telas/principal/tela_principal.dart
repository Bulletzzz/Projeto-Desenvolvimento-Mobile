import 'package:flutter/material.dart';
import 'package:balancete2000/dominio/enums/categoria_gasto.dart';
import 'package:balancete2000/nucleo/utilitarios/analisador_numero.dart';
import 'package:balancete2000/nucleo/utilitarios/formatador_moeda.dart';
import 'package:balancete2000/apresentacao/widgets/cartao_gasto.dart';
import 'package:balancete2000/apresentacao/telas/historico/tela_historico.dart';
import 'package:balancete2000/dados/repositorio_gastos.dart';
import 'package:balancete2000/dominio/modelos/gasto.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  late TextEditingController _descricao;
  late TextEditingController _valor;
  late RepositorioGastos _repositorio;
  late CategoriaGasto _categoria;

  @override
  void initState() {
    _descricao = TextEditingController();
    _valor = TextEditingController();
    _repositorio = RepositorioGastos();
    _categoria = CategoriaGasto.alimentacao;
    super.initState();
  }

  @override
  void dispose() {
    _descricao.dispose();
    _valor.dispose();
    super.dispose();
  }

  void _adicionar() {
    final descricao = _descricao.text.trim();
    final valor = AnalisadorNumero.analisar(_valor.text);
    if (descricao.isEmpty || valor == null || valor <= 0) return;

    setState(() {
      _repositorio.adicionar(
        descricao: descricao,
        valor: valor,
        categoria: _categoria,
      );
    });

    _descricao.clear();
    _valor.clear();
  }

  Future<void> _confirmarRemocao(Gasto gasto) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir lançamento'),
        content: Text(
          'Remover "${gasto.descricao}" no valor de '
          '${FormatadorMoeda.formatar(gasto.valor)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Balancete2000')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: const Color(0xFF0A57C2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TOTAL GERAL',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  Text(
                    FormatadorMoeda.formatar(_repositorio.total),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  Text(
                    _repositorio.quantidade == 1 ? '1 lançamento' : '${_repositorio.quantidade} lançamentos',
                    style: const TextStyle(fontSize: 11, color: Color(0xFFFFFFFF)),
                  ),
                ],
              ),
            ),
            TextField(
              controller: _descricao,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _valor,
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
            ),
            DropdownButton<CategoriaGasto>(
              value: _categoria,
              isExpanded: true,
              items: CategoriaGasto.values
                  .map((categoria) => DropdownMenuItem(
                        value: categoria,
                        child: Text(categoria.rotulo),
                      ))
                  .toList(),
              onChanged: (categoria) => setState(() => _categoria = categoria!),
            ),
            ElevatedButton(
              onPressed: _adicionar,
              child: const Text('Adicionar gasto'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _abrirHistorico,
              child: const Text('Ver por categoria'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
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