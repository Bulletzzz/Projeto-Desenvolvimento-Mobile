import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xp_ui/xp_ui.dart';
import 'package:balancete2000/dominio/enums/categoria_gasto.dart';
import 'package:balancete2000/nucleo/tema/paleta.dart';
import 'package:balancete2000/nucleo/utilitarios/analisador_numero.dart';

class FormularioGasto extends StatefulWidget {
  const FormularioGasto({super.key, required this.aoConfirmar});

  final void Function(String descricao, double valor, CategoriaGasto categoria) aoConfirmar;

  @override
  State<FormularioGasto> createState() => _FormularioGastoState();
}

class _FormularioGastoState extends State<FormularioGasto> {
  late TextEditingController _descricao;
  late TextEditingController _valor;
  late CategoriaGasto _categoria;
  String? _erro;

  @override
  void initState() {
    _descricao = TextEditingController();
    _valor = TextEditingController();
    _categoria = CategoriaGasto.alimentacao;
    super.initState();
  }

  @override
  void dispose() {
    _descricao.dispose();
    _valor.dispose();
    super.dispose();
  }

  void _confirmar() {
    final descricao = _descricao.text.trim();
    if (descricao.isEmpty) {
      setState(() => _erro = 'Informe uma descrição para o gasto.');
      return;
    }

    final valor = AnalisadorNumero.analisar(_valor.text);
    if (valor == null || valor <= 0) {
      setState(() => _erro = 'Informe um valor numérico maior que zero.');
      return;
    }

    widget.aoConfirmar(descricao, valor, _categoria);
    _descricao.clear();
    _valor.clear();
    setState(() => _erro = null);
  }

  @override
  Widget build(BuildContext context) {
    return Group(
      label: const Text('Novo lançamento'),
      children: [
        Textbox(controller: _descricao, labelText: 'Descrição'),
        const SizedBox(height: 8),
        Textbox(
          controller: _valor,
          labelText: 'Valor (R\$)',
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
        ),
        const SizedBox(height: 8),
        RadioOptions<CategoriaGasto>(
          selected: _categoria,
          wrap: true,
          direction: Axis.horizontal,
          options: CategoriaGasto.values
              .map((categoria) => RadioOption<CategoriaGasto>(
                    value: categoria,
                    label: categoria.rotulo,
                  ))
              .toList(),
          onChanged: (categoria) {
            if (categoria != null) setState(() => _categoria = categoria);
          },
        ),
        if (_erro != null) ...[
          const SizedBox(height: 8),
          Text(_erro!, style: const TextStyle(fontSize: 11, color: Paleta.vermelho)),
        ],
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Button(onPressed: _confirmar, child: const Text('Adicionar gasto')),
          ],
        ),
      ],
    );
  }
}
