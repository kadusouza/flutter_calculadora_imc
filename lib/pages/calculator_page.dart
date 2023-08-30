import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculadora_imc/model/pessoa_model.dart';
import 'package:flutter_calculadora_imc/shared/entry_field.dart';
import 'package:flutter_calculadora_imc/shared/linear_gauge.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _controllerPeso = TextEditingController();
  final TextEditingController _controllerAltura = TextEditingController();
  // ignore: non_constant_identifier_names
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

  @override
  void initState() {
    super.initState();

    // Listen for changes in the text field
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
    // Clean up the controller when the widget is removed from the widget tree
    _controllerPeso.dispose();
    _controllerAltura.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Calculadora IMC')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            EntryField(
              controller: _controllerPeso,
              isDecimal: true,
              text: 'Peso em Kg',
            ),
            const SizedBox(
              height: 10,
            ),
            EntryField(
              controller: _controllerAltura,
              isDecimal: true,
              text: 'Altura em Metros',
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                double? peso = double.parse(_controllerPeso.text);
                double? altura = double.parse(_controllerAltura.text);

                setState(() {
                  IMC = Pessoa(peso: peso, altura: altura).calcularIMC();
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
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                    flex: 8,
                    child:
                        Text('IMC: ${IMC.toStringAsFixed(2)}  |   $imcStatus')),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            LinearGauge(
              value: IMC,
            ),
          ],
        ),
      ),
    );
  }
}
