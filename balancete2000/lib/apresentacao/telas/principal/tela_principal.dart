import 'package:flutter/material.dart';
import 'package:balancete2000/dominio/enums/categoria_gasto.dart';
import 'package:balancete2000/dominio/modelos/gasto.dart';
import 'package:balancete2000/nucleo/utilitarios/analisador_numero.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Balancete2000')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
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
                  return ListTile(
                    title: Text(gasto.descricao),
                    subtitle: Text(gasto.categoria.rotulo),
                    trailing: Text(gasto.valor.toStringAsFixed(2)),
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