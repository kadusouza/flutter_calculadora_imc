class Pessoa {
  double peso; // em kg
  double altura; // em metros

  Pessoa({this.peso = 0.0, this.altura = 0.0});

  // Método para calcular o Índice de Massa Corporal (IMC)
  double calcularIMC() {
    return peso / (altura * altura);
  }
}
