import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selecteditems = 'AUD';

  DropdownButton androidlist() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String i in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(i),
        value: i,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selecteditems,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selecteditems = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iosList() {
    List<Text> pickedItems;
    for (String i in currenciesList) {
      Text temp_Item = Text(i);
      pickedItems.add(temp_Item);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (value) {},
      children: pickedItems,
    );
  }

  String value = '?';
  String crptocardvalue = '';
  String lightcoinvalue = '?';
  String etccoinvalue = '?';

  bool isWaiting = false;
  Map<String, String> coinvalues = {};

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selecteditems);
      setState(() {
        isWaiting = false;
        coinvalues = data;
      });
    } catch (e) {
      throw (e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Column makecard() {
    List<CryptoCard> criptocards = [];
    for (String i in cryptoList) {
      criptocards.add(
        CryptoCard(
          crptocardvalue: i,
          value: isWaiting ? '?' : coinvalues[i],
          selecteditems: selecteditems,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: criptocards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makecard(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: androidlist(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.crptocardvalue,
    @required this.value,
    @required this.selecteditems,
  }) : super(key: key);

  final String crptocardvalue;
  final String value;
  final String selecteditems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crptocardvalue = $value $selecteditems',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
