class Utils {
  static String validation(String name, String phoneNumber) {
    String result = '';
    String patternt = '^(?:[+0]9)?[0-9]{11}\$';
    RegExp regExp = RegExp(patternt);
    if (name.isEmpty || phoneNumber.isEmpty) {
      result = 'فیلد ها را پر کنید.';
    } else if (!regExp.hasMatch(phoneNumber)) {
      result = 'شماره تلفن صحیح نمی باشد.';
    }
    return result;
  }
}
