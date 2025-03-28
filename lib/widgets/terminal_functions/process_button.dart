import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/terminal_provider.dart';
import '../../services/plutus_smart.dart';
import '../../utils/logger.dart';
import 'custom_button_terminal.dart';

class ProcessButton extends StatelessWidget {
  const ProcessButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TerminalProvider>(
      builder: (context, provider, child) {
        return CustomButtonTerminal(
          onPressed: () async {
            if (provider.selectedTransaction == 'PRINT') {
              await _handlePrint(provider);
            } else {
              await _handleTransaction(provider);
            }
          },
          buttonText: 'PROCESS',
          buttonColor: Colors.blue,
          textColor: Colors.white,
          animationDuration: const Duration(milliseconds: 250),
        );
      },
    );
  }
}

Future<void> _handlePrint(TerminalProvider provider) async {
  try {
    provider.addStatusMessage("INITIATING PRINT JOB.");
    Logger.info('INITIATING PRINT JOB.');

    // Get the print data from the provider
    final printData = provider.printData;
    final printDataJson = jsonEncode(printData);

    // Call the print job method
    final result = await PlutusSmart.startPrintJob(printDataJson);

    // Log the result
    provider.addStatusMessage("PRINT JOB RESULT: $result");
    Logger.info('PRINT JOB RESULT: $result');
  } catch (e) {
    provider.addStatusMessage("PRINT JOB ERROR: $e");
    Logger.error('PRINT JOB ERROR: $e');
  }
}

Future<void> _handleTransaction(TerminalProvider provider) async {
  try {
    provider.addStatusMessage("INITIATING TRANSACTION.");
    Logger.info('INITIATING TRANSACTION.');

    final transactionData = {
      "Detail": {
        "BillingRefNo":
            provider
                .payload["Detail"]["BillingRefNo"], // Keep the original value if needed
        "PaymentAmount":
            provider
                .paymentAmount, // Use the dynamically updated payment amount
        "TransactionType":
            provider
                .payload["Detail"]["TransactionType"], // Keep the original type if needed
      },
      "Header": provider.payload["Header"], // Use the original header
    };

    final transactionDataJson = jsonEncode(transactionData);
    Logger.info('TRANSACTION DATA: $transactionDataJson');
    // Call the transaction method
    final result = await PlutusSmart.startTransaction(transactionDataJson);
    Logger.info('TRANSACTION RESULT: $result');
    // Log the result
    provider.addStatusMessage("TRANSACTION RESULT: $result");
    Logger.info('TRANSACTION RESULT: $result');
  } catch (e) {
    provider.addStatusMessage("TRANSACTION ERROR: $e");
    Logger.error('TRANSACTION ERROR: $e');
  }
}
