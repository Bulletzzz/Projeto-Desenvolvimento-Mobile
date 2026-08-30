import 'package:flutter/material.dart';
import 'package:balancete2000/dominio/enums/categoria_gasto.dart';
import 'package:balancete2000/dominio/modelos/gasto.dart';
import 'package:balancete2000/nucleo/utilitarios/analisador_numero.dart';
import 'package:balancete2000/nucleo/utilitarios/formatador_moeda.dart';
import 'package:balancete2000/apresentacao/widgets/cartao_gasto.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  late TextEditingController _descricao;
  late TextEditingController _valor;
  late List<Gasto> _gastos;
  late CategoriaGasto _categoria;
  late int _proximoIdentificador;

  double get _total => _gastos.fold(0, (soma, gasto) => soma + gasto.valor);

  @override
  void initState() {
    _descricao = TextEditingController();
    _valor = TextEditingController();
    _gastos = [];
    _categoria = CategoriaGasto.alimentacao;
    _proximoIdentificador = 1;
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
      _gastos.insert(
        0,
        Gasto(
          identificador: _proximoIdentificador++,
          descricao: descricao,
          valor: valor,
          categoria: _categoria,
          registradoEm: DateTime.now(),
        ),
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
      _gastos.removeWhere((item) => item.identificador == gasto.identificador);
    });
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
                    FormatadorMoeda.formatar(_total),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  Text(
                    _gastos.length == 1 ? '1 lançamento' : '${_gastos.length} lançamentos',
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
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _gastos.length,
                itemBuilder: (context, indice) {
                  final gasto = _gastos[indice];
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