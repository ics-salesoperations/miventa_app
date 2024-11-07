import 'dart:io';

class Environment {
  static String apiURL = Platform.isAndroid
      ? 'http://10.0.2.2:8000/apiboc'
      : 'http://10.0.2.2:8000/apiboc';

      // ? 'https://gpsboc.tigo.com.hn/apiboc'
      // : 'https://gpsboc.tigo.com.hn/apiboc';
}
