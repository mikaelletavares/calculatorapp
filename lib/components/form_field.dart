import 'package:flutter/material.dart';

class FormFieldComponent extends StatelessWidget {
  TextEditingController firstController = TextEditingController();
  String firstLabel;
  TextInputType firstKeyboardType;
  TextEditingController secondController = TextEditingController();
  String secondLabel;
  TextInputType secondKeybordType;

  FormFieldComponent({
    super.key,
    required this.firstController,
    required this.firstLabel,
    required this.firstKeyboardType,
    required this.secondController,
    required this.secondLabel,
    required this.secondKeybordType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              keyboardType: firstKeyboardType,
              decoration: InputDecoration(
                labelText: firstLabel,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
              textAlign: TextAlign.center,
              controller: firstController,
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: TextField(
              keyboardType: secondKeybordType,
              decoration: InputDecoration(
                labelText: secondLabel,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
              textAlign: TextAlign.center,
              controller: secondController,
            ),
          ),
        ],
      ),
    );
  }
}
