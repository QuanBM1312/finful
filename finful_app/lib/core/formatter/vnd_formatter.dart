import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class VNDFormatter extends TextInputFormatter {
  final bool isBillions; // true = tỷ, false = triệu

  VNDFormatter({this.isBillions = false});

  final NumberFormat _formatter = NumberFormat('#,###.##', 'vi_VN');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String text = newValue.text.replaceAll(',', '').replaceAll('.', '');

    if (text.isEmpty) {
      return newValue.copyWith(text: '', selection: const TextSelection.collapsed(offset: 0));
    }

    // Parse số
    double? value = double.tryParse(text);
    if (value == null) return oldValue;

    // Format lại đúng chuẩn VN
    String formatted = _formatter.format(value);

    // Nếu là tỷ thì chia 1 tỷ, còn triệu thì chia 1 triệu
    final displayValue = isBillions ? value / 1000000000 : value / 1000000;
    final displayText = _formatter.format(displayValue);

    return TextEditingValue(
      text: displayText,
      selection: TextSelection.collapsed(offset: displayText.length),
    );
  }
}