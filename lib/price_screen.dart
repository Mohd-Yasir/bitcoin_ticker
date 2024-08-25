import 'package:bitcoin_ticker/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';

//For Android
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        if (value != null) {
          updateCurrency(value);
        }
      },
    );
  }

//FOR IOS
  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        updateCurrency(currenciesList[selectedIndex]);
      },
      children: pickerItems,
    );
  }

  void updateCurrency(String newCurrency) {
    setState(() {
      selectedCurrency = newCurrency;
      getData();
    });
  }

  Map<String, String> coinValues = {};
  bool isLoading = false;
  void getData() async {
    isLoading = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isLoading = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData(); // Fetch data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: ReusableCard(
              currency: selectedCurrency, // Hardcoded for now, adjust as needed
              price: coinValues[cryptoList[0]].toString(),
              cardName: '1 BTC = ',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: ReusableCard(
              currency: selectedCurrency, // Hardcoded for now, adjust as needed
              price: coinValues[cryptoList[1]].toString(),
              cardName: '1 ETH = ',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 358.0),
            child: ReusableCard(
              currency: selectedCurrency, // Hardcoded for now, adjust as needed
              price: coinValues[cryptoList[2]].toString(),
              cardName: '1 LTC = ',
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: iosPicker(), // Use CupertinoPicker for iOS
          ),
        ],
      ),
    );
  }
}
