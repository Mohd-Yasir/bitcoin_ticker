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

const coinapiUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '63261DF2-101A-4616-841B-57C510A8839B';

class CoinData {
  Future getCoinData(String currency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String url = '$coinapiUrl/$crypto/$currency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);
        double price = decodeData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
