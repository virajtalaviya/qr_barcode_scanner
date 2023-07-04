import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class BarcodeValidator {
  static int getCheckSumDataEAN13(String value) {
    final int sum1 = 3 *
        (int.parse(value[11]) +
            int.parse(value[9]) +
            int.parse(value[7]) +
            int.parse(value[5]) +
            int.parse(value[3]) +
            int.parse(value[1]));
    final int sum2 = int.parse(value[10]) +
        int.parse(value[8]) +
        int.parse(value[6]) +
        int.parse(value[4]) +
        int.parse(value[2]) +
        int.parse(value[0]);
    final int checkSumValue = sum1 + sum2;
    final int checkSumDigit = (10 - checkSumValue) % 10;
    return checkSumDigit;
  }

  static int getCheckSumDataUPCA(String value) {
    final int sum1 = 3 *
        (int.parse(value[0]) +
            int.parse(value[2]) +
            int.parse(value[4]) +
            int.parse(value[6]) +
            int.parse(value[8]) +
            int.parse(value[10]));
    final int sum2 =
        int.parse(value[9]) + int.parse(value[7]) + int.parse(value[5]) + int.parse(value[3]) + int.parse(value[1]);
    final int checkSumValue = sum1 + sum2;
    return (10 - checkSumValue % 10) % 10;
  }

  static int getCheckSumData(String value) {
    // ignore: dead_code
    for (int i = 0; i < value.length; i++) {
      final int sum1 = int.parse(value[1]) + int.parse(value[3]) + int.parse(value[5]);
      final int sum2 = 3 * (int.parse(value[0]) + int.parse(value[2]) + int.parse(value[4]) + int.parse(value[6]));
      final int checkSumValue = sum1 + sum2;
      final int checkSumDigit = (10 - checkSumValue) % 10;
      return checkSumDigit;
    }
    return 0;
  }

  static List<String> code128ACharacterSets = [];

  /// Represents the supported symbol character of code128B
  static List<String> code128BCharacterSets = [];

  /// Represents the supported symbol character of code128C
  static List<String> code128CCharacterSets = [];

  /// code128
  static const String _fnc1 = '\u00f1';

  /// Represents the FNC2 special character
  static const String _fnc2 = '\u00f2';

  /// Represents the FNC3 special character
  static const String _fnc3 = '\u00f3';

  /// Represents the FNC4 special character
  static const String _fnc4 = '\u00f4';

  ///Code93
  static const String _character = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. *\$/+%";

  /// codabar
  static final Map<String, String> _codeBarMap = <String, String>{
    '0': '101010011',
    '1': '101011001',
    '2': '101001011',
    '3': '110010101',
    '4': '101101001',
    '5': '110101001',
    '6': '100101011',
    '7': '100101101',
    '8': '100110101',
    '9': '110100101',
    '-': '101001101',
    '\$': '101100101',
    ':': '1101011011',
    '/': '1101101011',
    '.': '1101101101',
    '+': '101100110011',
    'A': '1011001001',
    'B': '1001001011',
    'C': '1010010011',
    'D': '1010011001'
  };

  static String validateBarcodeText(Symbology symbology, String value) {
    if (symbology is Codabar) {
      for (int i = 0; i < value.length; i++) {
        if (!_codeBarMap.containsKey(value[i]) ||
            value[i] == 'A' ||
            value[i] == 'B' ||
            value[i] == 'C' ||
            value[i] == 'D') {
          return "The provided input cannot be encoded : ${value[i]}";
        }
      }
      return "";
    } else if (symbology is Code39Extended) {
      for (int i = 0; i < value.length; i++) {
        if (value[i].codeUnitAt(0) > 127) {
          return "The provided input cannot be encoded : ${value[i]}";
        }
      }
      return "";
    } else if (symbology is Code93) {
      for (int i = 0; i < value.length; i++) {
        if (!_character.contains(value[i])) {
          return "The provided input cannot be encoded : ${value[i]}";
        }
      }
      return "";
    } else if (symbology is Code128) {
      for (int i = 0; i < value.length; i++) {
        final int currentCharacter = value[i].codeUnitAt(0);
        if (currentCharacter == _fnc1.codeUnitAt(0) ||
            currentCharacter == _fnc2.codeUnitAt(0) ||
            currentCharacter == _fnc3.codeUnitAt(0) ||
            currentCharacter == _fnc4.codeUnitAt(0)) {
          return "";
        } else if (currentCharacter < 127) {
          return "";
        }
      }
      return "The provided input cannot be encoded.";
    } else if (symbology is Code128A) {
      code128ACharacterSets = <String>[];
      code128ACharacterSets.add(' ');
      code128ACharacterSets.add('!');
      code128ACharacterSets.add('"');
      code128ACharacterSets.add('#');
      code128ACharacterSets.add('\$');
      code128ACharacterSets.add('%');
      code128ACharacterSets.add('&');
      // ignore: avoid_escaping_inner_quotes
      code128ACharacterSets.add('\'');
      code128ACharacterSets.add('(');
      code128ACharacterSets.add(')');
      code128ACharacterSets.add('*');
      code128ACharacterSets.add('+');
      code128ACharacterSets.add(',');
      code128ACharacterSets.add('-');
      code128ACharacterSets.add('.');
      code128ACharacterSets.add('/');
      code128ACharacterSets.add('0');
      code128ACharacterSets.add('1');
      code128ACharacterSets.add('2');
      code128ACharacterSets.add('3');
      code128ACharacterSets.add('4');
      code128ACharacterSets.add('5');
      code128ACharacterSets.add('6');
      code128ACharacterSets.add('7');
      code128ACharacterSets.add('8');
      code128ACharacterSets.add('9');
      code128ACharacterSets.add(':');
      code128ACharacterSets.add(';');
      code128ACharacterSets.add('<');
      code128ACharacterSets.add('=');
      code128ACharacterSets.add('>');
      code128ACharacterSets.add('?');
      code128ACharacterSets.add('@');
      code128ACharacterSets.add('A');
      code128ACharacterSets.add('B');
      code128ACharacterSets.add('C');
      code128ACharacterSets.add('D');
      code128ACharacterSets.add('E');
      code128ACharacterSets.add('F');
      code128ACharacterSets.add('G');
      code128ACharacterSets.add('H');
      code128ACharacterSets.add('I');
      code128ACharacterSets.add('J');
      code128ACharacterSets.add('K');
      code128ACharacterSets.add('L');
      code128ACharacterSets.add('M');
      code128ACharacterSets.add('N');
      code128ACharacterSets.add('O');
      code128ACharacterSets.add('P');
      code128ACharacterSets.add('Q');
      code128ACharacterSets.add('R');
      code128ACharacterSets.add('S');
      code128ACharacterSets.add('T');
      code128ACharacterSets.add('U');
      code128ACharacterSets.add('V');
      code128ACharacterSets.add('W');
      code128ACharacterSets.add('X');
      code128ACharacterSets.add('Y');
      code128ACharacterSets.add('Z');
      code128ACharacterSets.add('[');
      code128ACharacterSets.add('\\');
      code128ACharacterSets.add(']');
      code128ACharacterSets.add('^');
      code128ACharacterSets.add('_');
      code128ACharacterSets.add('0');
      code128ACharacterSets.add('\u0001');
      code128ACharacterSets.add('\u0002');
      code128ACharacterSets.add('\u0003');
      code128ACharacterSets.add('\u0004');
      code128ACharacterSets.add('\u0005');
      code128ACharacterSets.add('\u0006');
      code128ACharacterSets.add('a');
      code128ACharacterSets.add('\b');
      code128ACharacterSets.add('\t');
      code128ACharacterSets.add('\n');
      code128ACharacterSets.add('\v');
      code128ACharacterSets.add('\f');
      code128ACharacterSets.add('\r');
      code128ACharacterSets.add('\u000e');
      code128ACharacterSets.add('\u000f');
      code128ACharacterSets.add('\u0010');
      code128ACharacterSets.add('\u0011');
      code128ACharacterSets.add('\u0012');
      code128ACharacterSets.add('\u0013');
      code128ACharacterSets.add('\u0014');
      code128ACharacterSets.add('\u0015');
      code128ACharacterSets.add('\u0016');
      code128ACharacterSets.add('\u0017');
      code128ACharacterSets.add('\u0018');
      code128ACharacterSets.add('\u0019');
      code128ACharacterSets.add('\u001a');
      code128ACharacterSets.add('\u001b');
      code128ACharacterSets.add('\u001c');
      code128ACharacterSets.add('\u001d');
      code128ACharacterSets.add('\u001e');
      code128ACharacterSets.add('\u001f');
      code128ACharacterSets.add('ù');
      code128ACharacterSets.add('ø');
      code128ACharacterSets.add('û');
      code128ACharacterSets.add('ö');
      code128ACharacterSets.add('õ');
      code128ACharacterSets.add('ú');
      code128ACharacterSets.add('÷');
      code128ACharacterSets.add('ü');
      code128ACharacterSets.add('ý');
      code128ACharacterSets.add('þ');
      code128ACharacterSets.add('ÿ');
      for (int i = 0; i < value.length; i++) {
        if (!code128ACharacterSets.contains(value[i])) {
          throw ArgumentError('The provided input cannot be encoded : ${value[i]}');
        }
      }
      return "";
    } else if (symbology is Code128B) {
      code128BCharacterSets = <String>[];
      code128BCharacterSets.add(' ');
      code128BCharacterSets.add('!');
      code128BCharacterSets.add('"');
      code128BCharacterSets.add('#');
      code128BCharacterSets.add('\$');
      code128BCharacterSets.add('%');
      code128BCharacterSets.add('&');
      // ignore: avoid_escaping_inner_quotes
      code128BCharacterSets.add('\'');
      code128BCharacterSets.add('(');
      code128BCharacterSets.add(')');
      code128BCharacterSets.add('*');
      code128BCharacterSets.add('+');
      code128BCharacterSets.add(',');
      code128BCharacterSets.add('-');
      code128BCharacterSets.add('.');
      code128BCharacterSets.add('/');
      code128BCharacterSets.add('0');
      code128BCharacterSets.add('1');
      code128BCharacterSets.add('2');
      code128BCharacterSets.add('3');
      code128BCharacterSets.add('4');
      code128BCharacterSets.add('5');
      code128BCharacterSets.add('6');
      code128BCharacterSets.add('7');
      code128BCharacterSets.add('8');
      code128BCharacterSets.add('9');
      code128BCharacterSets.add(':');
      code128BCharacterSets.add(';');
      code128BCharacterSets.add('<');
      code128BCharacterSets.add('=');
      code128BCharacterSets.add('>');
      code128BCharacterSets.add('?');
      code128BCharacterSets.add('@');
      code128BCharacterSets.add('A');
      code128BCharacterSets.add('B');
      code128BCharacterSets.add('C');
      code128BCharacterSets.add('D');
      code128BCharacterSets.add('E');
      code128BCharacterSets.add('F');
      code128BCharacterSets.add('G');
      code128BCharacterSets.add('H');
      code128BCharacterSets.add('I');
      code128BCharacterSets.add('J');
      code128BCharacterSets.add('K');
      code128BCharacterSets.add('L');
      code128BCharacterSets.add('M');
      code128BCharacterSets.add('N');
      code128BCharacterSets.add('O');
      code128BCharacterSets.add('P');
      code128BCharacterSets.add('Q');
      code128BCharacterSets.add('R');
      code128BCharacterSets.add('S');
      code128BCharacterSets.add('T');
      code128BCharacterSets.add('U');
      code128BCharacterSets.add('V');
      code128BCharacterSets.add('W');
      code128BCharacterSets.add('X');
      code128BCharacterSets.add('Y');
      code128BCharacterSets.add('Z');
      code128BCharacterSets.add('[');
      code128BCharacterSets.add('\\');
      code128BCharacterSets.add(']');
      code128BCharacterSets.add('^');
      code128BCharacterSets.add('_');
      code128BCharacterSets.add('`');
      code128BCharacterSets.add('a');
      code128BCharacterSets.add('b');
      code128BCharacterSets.add('c');
      code128BCharacterSets.add('d');
      code128BCharacterSets.add('e');
      code128BCharacterSets.add('f');
      code128BCharacterSets.add('g');
      code128BCharacterSets.add('h');
      code128BCharacterSets.add('i');
      code128BCharacterSets.add('j');
      code128BCharacterSets.add('k');
      code128BCharacterSets.add('l');
      code128BCharacterSets.add('m');
      code128BCharacterSets.add('n');
      code128BCharacterSets.add('o');
      code128BCharacterSets.add('p');
      code128BCharacterSets.add('q');
      code128BCharacterSets.add('r');
      code128BCharacterSets.add('s');
      code128BCharacterSets.add('t');
      code128BCharacterSets.add('u');
      code128BCharacterSets.add('v');
      code128BCharacterSets.add('w');
      code128BCharacterSets.add('x');
      code128BCharacterSets.add('y');
      code128BCharacterSets.add('z');
      code128BCharacterSets.add('{');
      code128BCharacterSets.add('|');
      code128BCharacterSets.add('}');
      code128BCharacterSets.add('~');
      code128BCharacterSets.add('\u007f');
      code128BCharacterSets.add('ù');
      code128BCharacterSets.add('ø');
      code128BCharacterSets.add('û');
      code128BCharacterSets.add('ö');
      code128BCharacterSets.add('ú');
      code128BCharacterSets.add('ô');
      code128BCharacterSets.add('÷');
      code128BCharacterSets.add('ü');
      code128BCharacterSets.add('ý');
      code128BCharacterSets.add('þ');
      code128BCharacterSets.add('ÿ');
      for (int i = 0; i < value.length; i++) {
        if (!code128BCharacterSets.contains(value[i])) {
          return "The provided input cannot be encoded : ${value[i]}";
        }
      }
      return "";
    } else if (symbology is Code128C) {
      code128CCharacterSets = <String>[];
      code128CCharacterSets.add('0');
      code128CCharacterSets.add('1');
      code128CCharacterSets.add('2');
      code128CCharacterSets.add('3');
      code128CCharacterSets.add('4');
      code128CCharacterSets.add('5');
      code128CCharacterSets.add('6');
      code128CCharacterSets.add('7');
      code128CCharacterSets.add('8');
      code128CCharacterSets.add('9');
      code128CCharacterSets.add('õ');
      code128CCharacterSets.add('ô');
      code128CCharacterSets.add('÷');
      code128CCharacterSets.add('ü');
      code128CCharacterSets.add('ý');
      code128CCharacterSets.add('þ');
      code128CCharacterSets.add('ÿ');

      for (int i = 0; i < value.length; i++) {
        if (!code128CCharacterSets.contains(value[i])) {
          return "The provided input cannot be encoded : ${value[i]}";
        }
      }
      return "";
    } else if (symbology is EAN8) {
      if ((RegExp(r'^(?=.*?[0-9]).{8}$').hasMatch(value))) {
        if (int.parse(value[7]) == getCheckSumData(value)) {
          return "";
        } else {
          return "Invalid check digit at the trailing end. "
              "Provide the valid check digit or remove it. "
              "Since, it has been calculated automatically.";
          // throw ArgumentError('Invalid check digit at the trailing end. '
          //     'Provide the valid check digit or remove it. '
          //     'Since, it has been calculated automatically.');
        }
      } else if (RegExp(r'^(?=.*?[0-9]).{7}$').hasMatch(value)) {
        return "";
      } else {
        return "EAN8 supports only numeric characters. "
            "The provided value should have 7 digits (without check digit) "
            "or with 8 digits.";
        // throw ArgumentError('EAN8 supports only numeric characters.'
        //     ' The provided value should have 7 digits (without check digit)'
        //     ' or with 8 digits.');
      }
    } else if (symbology is UPCA) {
      if (value.contains(RegExp(r'^(?=.*?[0-9]).{11}$'))) {
        return "";
      } else if (value.contains(RegExp(r'^(?=.*?[0-9]).{12}$'))) {
        if (int.parse(value[11]) == getCheckSumDataUPCA(value)) {
          return "";
        } else {
          return "Invalid check digit at the trailing end. Provide the valid check digit or remove it. Since, it has been calculated automatically.";
          // throw ArgumentError('Invalid check digit at the trailing end.'
          //     ' Provide the valid check digit or remove it.'
          //     ' Since, it has been calculated automatically.');
        }
      } else {
        return "UPCA supports only numeric characters. The provided value should have 11 digits (without check digit) or with 12 digits.";
        // throw ArgumentError('UPCA supports only numeric characters. '
        //     'The provided value should have 11 digits (without check digit) '
        //     'or with 12 digits.');
      }
    } else if (symbology is UPCE) {
      if (value.contains(RegExp(r'^(?=.*?[0-9]).{6}$'))) {
        return "";
      }
      return "UPCE supports only numeric characters. The provided value should have 6 digits.";
      // throw ArgumentError('UPCE supports only numeric characters. '
      //     'The provided value should have 6 digits.');
    } else if (symbology is EAN13) {
      if (value.contains(RegExp(r'^(?=.*?[0-9]).{13}$'))) {
        if (int.parse(value[12]) == getCheckSumDataEAN13(value)) {
          return "";
        } else {
          return "Invalid check digit at the trailing end. Provide the valid check digit or remove it. Since, it has been calculated automatically.";
          // throw ArgumentError('Invalid check digit at the trailing end. '
          //     'Provide the valid check digit or remove it. '
          //     'Since, it has been calculated automatically.');
        }
      } else if (value.contains(RegExp(r'^(?=.*?[0-9]).{12}$'))) {
        return "";
      } else {
        return "EAN13 supports only numeric characters. The provided value should have 12 digits (without check digit) or with 13 digits.";
        // throw ArgumentError('EAN13 supports only numeric characters. '
        //     'The provided value should have 12 digits (without check digit) or'
        //     ' with 13 digits.');
      }
    }
    return "";
  }
}
