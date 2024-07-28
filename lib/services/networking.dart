import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  String key = '20CA5852-E7B1-4352-A2C8-4C1E760DABF6';

  Future<int> getData(String cryptoCurrency, String currency) async {
    var url = Uri.http(
      'rest.coinapi.io',
      'v1/exchangerate/$cryptoCurrency/$currency/',
      {
        'apikey': key,
      },
    );

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var rate = data['rate'].round();

      return rate;
    } else {
      print('Failed to load exchange rate data: ${response.statusCode}');
      return 0;
    }
  }
}