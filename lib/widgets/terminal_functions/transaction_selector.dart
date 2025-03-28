import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/terminal_provider.dart';
import 'amount_input.dart';

class TransactionSelector extends StatelessWidget {
  const TransactionSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TerminalProvider>(context);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(color: Colors.black),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Text(
                'TYPE: ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: provider.selectedTransaction,
                    items:
                        <String>[
                          'SALE',
                          'REFUND',
                          'VOID',
                          'SETTLE',
                          'UPI',
                          'SALE+TIP',
                          'PRINT',
                          'SCAN',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      provider.setSelectedTransaction(newValue!);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Text(
                'AMT:',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: AmountInput(
                controller: provider.amountController,
                focusNode: provider.amountFocusNode,
                onChanged: (value) {
                  provider.setPaymentAmount(int.tryParse(value) ?? 0);
                },
                isEnabled: !provider.isChecked,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
