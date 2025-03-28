import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/terminal_provider.dart';

class ResponseViewer extends StatelessWidget {
  const ResponseViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
      ),
      child: Consumer<TerminalProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            controller: provider.scrollController, //use the scroll controller
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.statusMessages.length,
            itemBuilder: (context, index) {
              return Text(provider.statusMessages[index]);
            },
          );
        },
      ),
    );
  }
}
