import 'package:big_bucks_blog/Chart/chart.dart';
import 'package:big_bucks_blog/screens/companies.dart';
import 'package:http/http.dart' as http;
import 'package:big_bucks_blog/model/ChartData.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChartData> data = [];
  String dropdownvalue = 'NSE';
  var items = [
    'NSE',
    'BSE',
  ];

  int pageIndex = 1;

  Future<List<ChartData>> getData(String api) async {
    print(api);
    final uri = Uri.parse("http://10.0.2.2:5000/${api}");
    var res = await http.get(uri);
    var data = json.decode(res.body);
    debugPrint(data.toString());
    List<ChartData> chart = [];
    List<ChartData> d = (json.decode(res.body) as List)
        .map((data) => ChartData.fromJson(data))
        .toList();
    print(chart);
    return d;
  }

  @override
  void initState() {
    getData("bse").then((value) {
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
          backgroundColor: Color.fromARGB(250, 239, 82, 29),
          title: const Text(
            'Big Bucks Blog',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: (pageIndex == 1)
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          DropdownButton(
                            value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                                getData(newValue.toLowerCase())
                                    .then((value) => data = value);
                              });
                            },
                            elevation: 5,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: OHLCchart(
                            chartData: data,
                            title: dropdownvalue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : const Company(),
        bottomNavigationBar: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Color.fromARGB(250, 239, 82, 29),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                icon: pageIndex == 1
                    ? const Icon(
                        Icons.home_filled,
                        color: Colors.white,
                        size: 35,
                      )
                    : const Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                icon: pageIndex == 2
                    ? const Icon(
                        Icons.work_rounded,
                        color: Colors.white,
                        size: 35,
                      )
                    : const Icon(
                        Icons.work_outline_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
              ),
            ],
          ),
        ));
  }
}
