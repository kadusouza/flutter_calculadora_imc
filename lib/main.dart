import 'package:flutter/material.dart';
import 'package:flutter_calculadora_imc/calculadora_imc_app.dart';
import 'package:flutter_calculadora_imc/model/pessoa_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PessoaAdapter());
  runApp(const CalculadoraIMCApp());
}
