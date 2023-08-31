import 'package:hive/hive.dart';

part 'pessoa_model.g.dart'; // Indica que o código gerado deve ser colocado neste arquivo

@HiveType(typeId: 0) // Define um tipo único de ID para este tipo de objeto
class Pessoa {
  @HiveField(0) // Cada campo é marcado com um índice único
  final double peso;

  @HiveField(1)
  final double altura;

  Pessoa({required this.peso, required this.altura});

  double calcularIMC() {
    return peso / (altura * altura);
  }
}
