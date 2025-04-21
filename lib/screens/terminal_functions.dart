import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/terminal_provider.dart';
import '../services/plutus_smart.dart';
import '../utils/logger.dart';
import '../widgets/terminal_functions/print_demo.dart';
import '../widgets/terminal_functions/process_button.dart';
import '../widgets/terminal_functions/response_viewer.dart';
import '../widgets/terminal_functions/title_widget.dart';
import '../widgets/terminal_functions/transaction_selector.dart';

class TerminalFunctions extends StatelessWidget {
  const TerminalFunctions({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bindService(context.read<TerminalProvider>());
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.05,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    TitleWidget(),
                    TransactionSelector(),
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    const ProcessButton(),
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    Provider.of<TerminalProvider>(context).printerEnabled
                        ? ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height / 1.50,
                          ),
                          child: PrintDemo(),
                        )
                        : ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height / 1.50,
                          ),
                          child: ResponseViewer(),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _bindService(TerminalProvider provider) async {
    if (provider.isBindingInitiated) {
      return; // Prevent redundant calls
    }

    provider.setBindingInitiated(true); // Set the flag

    provider.addStatusMessage("BINDING STARTED.");
    Logger.info('BINDING STARTED.');
    provider.setBindingStatus("Binding...");

    try {
      final result = await PlutusSmart.bindToService();
      Logger.info('Binding result: $result'); // Log the result

      if (result == "SUCCESS" || result == "BINDING SUCCESS.") {
        // Handle both cases
        provider.setBindingStatus("BINDING SUCCESS.");
        provider.setIsBound(true);
        provider.addStatusMessage("BINDING SUCCESS.");
        Logger.success("BINDING SUCCESS.");
      } else if (result == "FAILED") {
        provider.setBindingStatus("BINDING FAILED.");
        provider.setIsBound(false);
        provider.addStatusMessage("BINDING FAILED.");
        Logger.error("BINDING FAILED. ${result.toString()}");
      } else {
        provider.setBindingStatus("BINDING UNKNOWN RESULT.");
        provider.setIsBound(false);
        provider.addStatusMessage("BINDING UNKNOWN RESULT.");
        Logger.error("BINDING UNKNOWN RESULT. ${result.toString()}");
      }
    } catch (e) {
      provider.setBindingStatus("BINDING EXCEPTION.");
      provider.setIsBound(false);
      provider.addStatusMessage("BINDING EXCEPTION.");
      Logger.error("BINDING EXCEPTION. ${e.toString()}");
    }
  }
}
