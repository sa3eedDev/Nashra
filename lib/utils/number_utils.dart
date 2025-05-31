class NumberUtils {
  // Convert Arabic/Hindi numerals to English numerals
  static String convertToEnglishNumbers(String input) {
    if (input.isEmpty) return input;
    
    const Map<String, String> arabicDigits = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };
    
    String result = input;
    arabicDigits.forEach((key, value) {
      result = result.replaceAll(key, value);
    });
    
    return result;
  }
  
  // Convert English numerals to Arabic/Hindi numerals
  static String convertToArabicNumbers(String input) {
    if (input.isEmpty) return input;
    
    const Map<String, String> englishDigits = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };
    
    String result = input;
    englishDigits.forEach((key, value) {
      result = result.replaceAll(key, value);
    });
    
    return result;
  }
} 