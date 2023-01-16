import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:big_bucks_blog/Chart/chart.dart';
import 'package:big_bucks_blog/model/ChartData.dart';
import 'package:flutter/material.dart';

class CompanyStock extends StatefulWidget {
  final String api;
  final String title;
  const CompanyStock({super.key, required this.api, required this.title});

  @override
  State<CompanyStock> createState() => _CompanyStockState();
}

class _CompanyStockState extends State<CompanyStock> {
  List<ChartData> data = [];
  Future<List<ChartData>> getData(String api) async {
    final uri = Uri.parse("http://10.0.2.2:5000/${api}");
    var res = await http.get(uri);
    var data = json.decode(res.body);
    debugPrint(data.toString());
    List<ChartData> d = (json.decode(res.body) as List)
        .map((data) => ChartData.fromJson(data))
        .toList();
    return d;
  }

  @override
  void initState() {
    getData(widget.api).then((value) {
      setState(() {
        data = value;
      });
    }).catchError((onError) {
      print(onError);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: const Text(
          'Big Bucks Blog',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: OHLCchart(
        chartData: data,
        title: widget.title,
      ),
    );
  }
}
