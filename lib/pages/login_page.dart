import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculadora_imc/pages/calculator_page.dart';
import 'package:flutter_calculadora_imc/shared/entry_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Listen for changes in the text field
    _controller.addListener(() {
      if (kDebugMode) {
        print("Text changed: ${_controller.text}");
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EntryField(
            controller: _controller,
            text: 'Usuário',
          ),
          const SizedBox(
            height: 10,
          ),
          EntryField(
            controller: _controller,
            text: 'Senha',
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CalculatorPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green, // Text color
              elevation: 5, // Elevation/Shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            child: const Text("Custom Button"),
          )
        ],
      ),
    ));
  }
}
