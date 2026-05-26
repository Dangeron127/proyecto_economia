import 'package:flutter/material.dart';

class FormularioGastos extends StatelessWidget {
  final TextEditingController conceptController;
  final TextEditingController amountController;
  final String hintTexto;
  final Color activeColor;

  const FormularioGastos({
    super.key,
    required this.conceptController,
    required this.amountController,
    required this.hintTexto,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: conceptController,
          decoration: InputDecoration(
            labelText: 'Concepto',
            hintText: hintTexto,
            prefixIcon: const Icon(Icons.edit_note),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: activeColor, width: 2),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Monto a Registrar',
            prefixIcon: const Icon(Icons.calculate_outlined),
            prefixText: '\$ ',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: activeColor, width: 2),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ],
    );
  }
}