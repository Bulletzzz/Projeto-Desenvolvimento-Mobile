class FormatadorMoeda {
  static String formatar(double valor) {
    final partes = valor.abs().toStringAsFixed(2).split('.');
    final inteiro = _agruparMilhares(partes.first);
    final sinal = valor < 0 ? '-' : '';
    return '${sinal}R\$ $inteiro,${partes.last}';
  }

  static String _agruparMilhares(String digitos) {
    final buffer = StringBuffer();
    for (var indice = 0; indice < digitos.length; indice++) {
      final restantes = digitos.length - indice;
      buffer.write(digitos[indice]);
      if (restantes > 1 && restantes % 3 == 1) buffer.write('.');
    }
    return buffer.toString();
  }
}