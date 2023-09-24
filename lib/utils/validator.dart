import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class Validator {
  static String? valueExists(dynamic value) {
    if (value == null || value.isEmpty) {
      return ''.tr();
    } else {
      return null;
    }
  }

  static String? passwordCorrect(dynamic value) {
    var emptyResult = valueExists(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      var pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[#?!@$%^&*-]).{8,}$';
      var regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return 'Your password must be at least 8 symbols with number, big and small letter and special character (!@#\$%^&*).'
            .tr();
      } else {
        return null;
      }
    } else {
      return emptyResult;
    }
  }

  static String? validateEmail(dynamic value) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regExp = RegExp(pattern);
    var emptyResult = valueExists(value);
    if (emptyResult != null) {
      return emptyResult;
    } else if (!regExp.hasMatch(value)) {
      return 'Not a valid email address. Should be your@email.com'.tr();
    } else {
      return null;
    }
  }
}

class Validator2 {
  static String? validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return ''.tr();
    } else {
      return null;
    }
  }

  static String? validateDropDefaultData(value) {
    if (value == null) {
      return ''.tr();
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return ''.tr();
    } else {
      return null;
    }
  }

  static String? validateName(String value) {
    if (value.length < 3) {
      return ''.tr();
    } else {
      return null;
    }
  }

  static String? validateText(String value) {
    if (value.isEmpty) {
      return '🚩 Text is too short.'.tr();
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String value) {
    if (value.length != 7) {
      return '🚩 Phone number is not valid.'.tr();
    } else {
      return null;
    }
  }

  static String? validateMasterCardNumber(String value) {
    if (value.length != 16) {
      return '🚩 MasterCard Number is not valid.'.tr();
    } else {
      return null;
    }
  }

  static String? validatCVV(String value) {
    if (value.length != 4) {
      return '🚩 CVV is not valid.'.tr();
    } else {
      return null;
    }
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

// class CardUtils {
//
//   static CardType getCardTypeFrmNumber(String input) {
//     CardType cardType;
//     if (input.startsWith(RegExp(
//         r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
//       cardType = CardType.Master;
//     } else if (input.startsWith(RegExp(r'[4]'))) {
//       cardType = CardType.Visa;
//     } else if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
//       cardType = CardType.Apple;
//     } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
//       cardType = CardType.AmericanExpress;
//     } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
//       cardType = CardType.Discover;
//     } else if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
//       cardType = CardType.DinersClub;
//     } else if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
//       cardType = CardType.Jcb;
//     } else if (input.length <= 8) {
//       cardType = CardType.Others;
//     } else {
//       cardType = CardType.Invalid;
//     }
//     return cardType;
//   }
//
//   // static Widget? getCardIcon(CardType? cardType) {
//   //   String img = "";
//   //   Icon? icon;
//   //   switch (cardType) {
//   //     case CardType.Master:
//   //       img = IconAssets.master;
//   //       break;
//   //     case CardType.Visa:
//   //       img = IconAssets.visa;
//   //       break;
//   //     case CardType.Apple:
//   //       img = IconAssets.applePay;
//   //       break;
//   //     case CardType.card:
//   //       img = IconAssets.card;
//   //       break;
//   //
//   //     case CardType.google:
//   //       img = IconAssets.google;
//   //       break;
//   //     case CardType.Jcb:
//   //       img = IconAssets.master;
//   //       break;
//   //     case CardType.Others:
//   //       icon = const Icon(
//   //         Icons.credit_card,
//   //         size: 24.0,
//   //         color: Color(0xFFB8B5C3),
//   //       );
//   //       break;
//   //     default:
//   //       icon = const Icon(
//   //         Icons.warning,
//   //         size: 24.0,
//   //         color: Color(0xFFB8B5C3),
//   //       );
//   //       break;
//   //   }
//   //   Widget? widget;
//   //   if (img.isNotEmpty) {
//   //     widget =   Container(
//   //       height: 25.h,
//   //       width: 20.w,
//   //       child: CustomSvgAssets(
//   //
//   //         path: img,
//   //       ),
//   //     );
//   //   } else {
//   //     widget = icon;
//   //   }
//   //   return widget;
//   // }
//
//
//   static String getCleanedNumber(String text) {
//     RegExp regExp = RegExp(r"[^0-9]");
//     return text.replaceAll(regExp, '');
//   }
//
//   /// With the card number with Luhn Algorithm
//   /// https://en.wikipedia.org/wiki/Luhn_algorithm
//   static String? validateCardNum(String? input) {
//     if (input == null || input.isEmpty) {
//       return "Please fill this field".tr();
//     }
//     // input = getCleanedNumber(input);
//     // if (input.length < 8) {
//     //   return "Card is invalid";
//     // }
//     int sum = 0;
//     int length = input.length;
//     for (var i = 0; i < length; i++) {
//       // get digits in reverse order
//       int digit = int.parse(input[length - i - 1]);
// // every 2nd number multiply with 2
//       if (i % 2 == 1) {
//         digit *= 2;
//       }
//       sum += digit > 9 ? (digit - 9) : digit;
//     }
//     if (sum % 10 == 0) {
//       return null;
//     }
//     return "Card is invalid".tr();
//   }
//
//
//   static String? validateCVV(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Please fill this field".tr();
//     }
//     if (value.length < 3 || value.length > 4) {
//       return "🚩 CVV is not valid.".tr();
//     }
//     return null;
//   }
//   static String? validateDate(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Please fill this field".tr();
//     }
//     int year;
//     int month;
//     if (value.contains(RegExp(r'(/)'))) {
//       var split = value.split(RegExp(r'(/)'));
//
//       month = int.parse(split[0]);
//       year = int.parse(split[1]);
//     } else {
//
//       month = int.parse(value.substring(0, (value.length)));
//       year = -1; // Lets use an invalid year intentionally
//     }
//     if ((month < 1) || (month > 12)) {
//       // A valid month is between 1 (January) and 12 (December)
//       return 'Expiry month is invalid'.tr();
//     }
//     var fourDigitsYear = convertYearTo4Digits(year);
//     if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
//       // We are assuming a valid should be between 1 and 2099.
//       // Note that, it's valid doesn't mean that it has not expired.
//       return 'Expiry year is invalid'.tr();
//     }
//     if (!hasDateExpired(month, year)) {
//       return "Card has expired".tr();
//     }
//     return null;
//   }
//
//
//   /// Convert the two-digit year to four-digit year if necessary
//   static int convertYearTo4Digits(int year) {
//     if (year < 100 && year >= 0) {
//       var now = DateTime.now();
//       String currentYear = now.year.toString();
//       String prefix = currentYear.substring(0, currentYear.length - 2);
//       year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
//     }
//     return year;
//   }
//   static bool hasDateExpired(int month, int year) {
//     return isNotExpired(year, month);
//   }
//   static bool isNotExpired(int year, int month) {
//     // It has not expired if both the year and date has not passed
//     return !hasYearPassed(year) && !hasMonthPassed(year, month);
//   }
//   static List<int> getExpiryDate(String value) {
//     var split = value.split(RegExp(r'(/)'));
//     return [int.parse(split[0]), int.parse(split[1])];
//   }
//   static bool hasMonthPassed(int year, int month) {
//     var now = DateTime.now();
//     // The month has passed if:
//     // 1. The year is in the past. In that case, we just assume that the month
//     // has passed
//     // 2. Card's month (plus another month) is more than current month.
//     return hasYearPassed(year) ||
//         convertYearTo4Digits(year) == now.year && (month < now.month + 1);
//   }
//   static bool hasYearPassed(int year) {
//     int fourDigitsYear = convertYearTo4Digits(year);
//     var now = DateTime.now();
//     // The year has passed if the year we are currently is more than card's
//     // year
//     return fourDigitsYear < now.year;
//   }
//
// }
