import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EntryField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool isDecimal;
  const EntryField({
    super.key,
    required this.text,
    required this.controller,
    this.isDecimal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        Expanded(
          flex: 3,
          child: TextField(
            controller: controller,
            keyboardType: isDecimal
                ? const TextInputType.numberWithOptions(decimal: true)
                : null,
            inputFormatters: isDecimal
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                  ]
                : [],
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: text,
            ),
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
