import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:bitcoin_ticker_flutter/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;



class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String current_currency = 'USD';
  Map<String, String> exchangeRate = {};
  void updateExchangeRate(currency)async{
    NetworkHelper networkHelper = NetworkHelper();
    for (String cripto in cryptoList){
    int rate = await networkHelper.getData(cripto, current_currency);
    exchangeRate[cripto] = (rate != 0)? rate.toString(): '?';
    }
    setState(() {
      
    });
  }
  @override
  void initState() {
    updateExchangeRate(current_currency);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (String crypto in cryptoList)
                Card(

                  margin: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 $crypto = ${exchangeRate[crypto]} $current_currency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: (Platform.isIOS)
                ? CupertinoPicker(
                    children: [
                      for (String currency in currenciesList) Text(currency)
                    ],
                    itemExtent: 32.0,
                    onSelectedItemChanged: (value) { 
                        current_currency = currenciesList[value];
                        updateExchangeRate(current_currency);
                    },
                  )
                : DropdownButton(
                    value: current_currency,
                    items: [
                      for (String currency in currenciesList)
                        DropdownMenuItem(child: Text(currency), value: currency)
                    ],
                    onChanged: (value) {
                     
                        current_currency = value!;
                        updateExchangeRate(current_currency);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
