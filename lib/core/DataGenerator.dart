
import 'dart:math';

class RandomGen {

  static String string([int size = 1]) {
   String code = '';
   for (int i = 0; i < size; i++) {
     code += String.fromCharCode(Random().nextInt(25) + 65);
   }
   return code;
  }

  static String number([int size = 1]) {
    String code = '';
    for (int i = 0; i < size; i++) {
      code += String.fromCharCode(Random().nextInt(9) + 48);
    }
    return code;
  }
}
