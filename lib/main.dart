
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bdk_flutter/bdk_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Timer _timer;
  String _price = '';

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 30), (Timer t) => _fetchData());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _fetchData() async {
    var url = Uri.parse('https://api.coinbase.com/v2/prices/BTC-USD/spot');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    var price = jsonResponse['data']['amount'];
    setState(() {
      _price = price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin Price',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bitcoin Price'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Bitcoin Price'),
              subtitle: Text('\$$_price'),
            ),
            SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}


















