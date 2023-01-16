import 'package:big_bucks_blog/model/ChartData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OHLCchart extends StatelessWidget {
  final List<ChartData> chartData;
  final String title;
  const OHLCchart({super.key, required this.chartData, required this.title});

  @override
  Widget build(BuildContext context) {
    late TrackballBehavior _trackBallBehaviour = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    return Column(
      children: [
        Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          child: SfCartesianChart(
            trackballBehavior: _trackBallBehaviour,
            axes: <ChartAxis>[
              NumericAxis(
                name: 'Y-Axis',
                opposedPosition: true,
                interval: 2000000000,
                visibleMaximum: 10000000000,
              )
            ],
            primaryXAxis: DateTimeAxis(),
            // primaryYAxis: NumericAxis(
            //     visibleMinimum: 10, visibleMaximum: 1900, interval: 200),
            series: <ChartSeries<ChartData, DateTime>>[
              CandleSeries<ChartData, DateTime>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.date,
                  openValueMapper: (ChartData data, _) => data.open,
                  closeValueMapper: (ChartData data, _) => data.close,
                  highValueMapper: (ChartData data, _) => data.high,
                  lowValueMapper: (ChartData data, _) => data.low),
              ColumnSeries<ChartData, DateTime>(
                  dataSource: chartData,
                  yAxisName: 'Y-Axis',
                  xValueMapper: (ChartData data, _) => data.date,
                  yValueMapper: (ChartData data, _) => data.volume)
            ],
          ),
        ),
      ],
    );
  }
}
