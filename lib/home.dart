import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List currency = [];

  getrates() async {
    http.Response response = await http.get(
        Uri.https('api.apilayer.com', 'fixer/latest?symbols&base'),
        headers: {"apikey": "ctaZt6osvepea38TDvqA5mHEFZ2IIvEH"});
    var jsonData = jsonDecode(response.body);
    // print(jsonData);
    Map<dynamic, dynamic> data = jsonData;
    var rates = data['rates'];

    final List currency = [];
    currency.add(rates.keys);
    print(currency);
    // List currencies = [];
    // currencies.add(data['rates']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SizedBox(
            width: 100,
            child:
                ElevatedButton(onPressed: getrates, child: const Text('GET'))),
      ),
      body: SingleChildScrollView(
        child: Container(
            color: Colors.amber,
            padding: const EdgeInsets.all(20),
            child: Text(currency.toString())),
      ),
    );
  }
}
