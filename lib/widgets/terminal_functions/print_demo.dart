import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/terminal_provider.dart';

class PrintDemo extends StatelessWidget {
  const PrintDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TerminalProvider>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.50,
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
      ),
      child: SingleChildScrollView(
        child: TextFormField(
          controller: provider.jsonController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: const TextStyle(
            fontFamily: 'Courier',
            fontSize: 14,
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(5),
          ),
          onChanged: (value) {
            provider.updatePrintData(value);
          },
        ),
      ),
    );
  }
}
