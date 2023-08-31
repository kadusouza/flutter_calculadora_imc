import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculadora_imc/model/pessoa_model.dart';
import 'package:flutter_calculadora_imc/shared/entry_field.dart';
import 'package:flutter_calculadora_imc/shared/linear_gauge.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _controllerPeso = TextEditingController();
  final TextEditingController _controllerAltura = TextEditingController();
  Box<Pessoa>? imcBox;
  double IMC = 0.0;
  String imcStatus = "Baixo Peso";

  String getIMCStatus(double imcValue) {
    if (imcValue < 18.5) {
      return 'Baixo peso';
    } else if (imcValue >= 18.5 && imcValue <= 24.9) {
      return 'Adequado';
    } else if (imcValue >= 25 && imcValue <= 29.9) {
      return 'Sobrepeso';
    } else if (imcValue >= 30 && imcValue <= 34.9) {
      return 'Obesidade';
    } else {
      return 'Obesidade mórbida';
    }
  }

  Future<Box<Pessoa>> initBox() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    return await Hive.openBox<Pessoa>('imcBox');
  }

  @override
  void initState() {
    super.initState();

    _controllerPeso.addListener(() {
      if (kDebugMode) {
        print("Text changed: ${_controllerPeso.text}");
      }
    });

    _controllerAltura.addListener(() {
      if (kDebugMode) {
        print("Text changed: ${_controllerAltura.text}");
      }
    });
  }

  @override
  void dispose() {
    _controllerPeso.dispose();
    _controllerAltura.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Calculadora IMC')),
        body: FutureBuilder<Box<Pessoa>>(
          future: initBox(),
          builder: (BuildContext context, AsyncSnapshot<Box<Pessoa>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                imcBox = snapshot.data;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    EntryField(
                      controller: _controllerPeso,
                      isDecimal: true,
                      text: 'Peso em Kg',
                    ),
                    const SizedBox(height: 10),
                    EntryField(
                      controller: _controllerAltura,
                      isDecimal: true,
                      text: 'Altura em Metros',
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        double? peso = double.parse(_controllerPeso.text);
                        double? altura = double.parse(_controllerAltura.text);

                        Pessoa pessoa = Pessoa(peso: peso, altura: altura);
                        await imcBox?.add(pessoa);

                        setState(() {
                          IMC = pessoa.calcularIMC();
                          imcStatus = getIMCStatus(IMC);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green, // Text color
                        elevation: 5, // Elevation/Shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      child: const Text("Calcular"),
                    ),
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                            flex: 8,
                            child: Text(
                                'IMC: ${IMC.toStringAsFixed(2)}  |   $imcStatus')),
                        Expanded(child: Container()),
                      ],
                    ),
                    const SizedBox(height: 5),
                    LinearGauge(value: IMC),
                    ValueListenableBuilder(
                      valueListenable: imcBox!.listenable(),
                      builder: (context, Box<Pessoa> box, _) {
                        if (box.isEmpty) {
                          return Text('Nenhum dado de IMC armazenado.');
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount: box.length,
                            itemBuilder: (context, index) {
                              final pessoa = box.getAt(index)!;
                              return ListTile(
                                title: Text(
                                    'IMC: ${pessoa.calcularIMC().toStringAsFixed(2)}'),
                                subtitle: Text(
                                    'Status: ${getIMCStatus(pessoa.calcularIMC())}'),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
