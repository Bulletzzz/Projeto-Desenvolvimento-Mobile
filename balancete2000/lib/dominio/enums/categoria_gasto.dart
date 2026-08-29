import 'package:flutter/widgets.dart';

enum CategoriaGasto {
  alimentacao('Alimentação', Color(0xFF2E8B2E), Color(0xFFDFF0D8)),
  transporte('Transporte', Color(0xFF1B5FA8), Color(0xFFD6E4F7)),
  lazer('Lazer', Color(0xFF9B3FA0), Color(0xFFEEDCF0)),
  outros('Outros', Color(0xFF8A6D0B), Color(0xFFF6EDCB));

  const CategoriaGasto(this.rotulo, this.cor, this.corFundo);

  final String rotulo;
  final Color cor;
  final Color corFundo;
}