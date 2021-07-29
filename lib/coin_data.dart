import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const apiurl = 'https://rest.coinapi.io/v1/exchangerate';
const apikey = '44915677-8E8B-48A2-8D87-B58A17F59DFE';

class CoinData {
  Future getCoinData(String selectedItem) async {
    Map<String, String> criptoprice = {};
    for (String i in cryptoList) {
      String requesturl = '$apiurl/$i/$selectedItem?apikey=$apikey';
      http.Response response = await http.get(Uri.parse(requesturl));
      if (response.statusCode == 200) {
        var temp_coin_value = jsonDecode(response.body);
        var coinvalue = (temp_coin_value['rate']);
        criptoprice[i] = coinvalue.toStringAsFixed(0);
      } else {
        throw 'Problem with the get request';
      }
    }
    return criptoprice;
  }
}
