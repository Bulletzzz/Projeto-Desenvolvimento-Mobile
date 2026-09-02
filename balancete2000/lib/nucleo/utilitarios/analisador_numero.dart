/// Analisa e converte texto em números
class AnalisadorNumero {
  static final RegExp _caracteresValidos = RegExp(r'[^0-9.,\-]');
  static final RegExp _numero = RegExp(r'-?\d+(?:\.\d+)?');

  static double? analisar(String texto) {
    final limpo = texto.replaceAll(_caracteresValidos, '');
    if (limpo.isEmpty) return null;

    final normalizado = _normalizarSeparadores(limpo);
    final encontrado = _numero.firstMatch(normalizado)?.group(0);
    if (encontrado == null) return null;

    return double.tryParse(encontrado);
  }

  static String _normalizarSeparadores(String texto) {
    final temVirgula = texto.contains(',');
    final temPonto = texto.contains('.');

    if (temVirgula && temPonto) {
      return texto.replaceAll('.', '').replaceAll(',', '.');
    }
    if (temVirgula) {
      return texto.replaceAll(',', '.');
    }
    return texto;
  }
}