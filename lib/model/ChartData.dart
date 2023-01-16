class ChartData {
  final DateTime? date;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
  final num? adjClose;
  final num? volume;

  ChartData(
      {this.date,
      this.open,
      this.close,
      this.low,
      this.high,
      this.adjClose,
      this.volume});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
        date: DateTime.parse(json['Date']),
        open: num.parse((json['Open'] != null) ? json['Open'] : '0.0'),
        close: num.parse((json['Close'] != null) ? json['Close'] : '0.0'),
        high: num.parse((json['High'] != null) ? json['High'] : '0.0'),
        low: num.parse((json['Low'] != null) ? json['Low'] : '0.0'),
        volume: num.parse((json['Volume'] != null) ? json['Volume'] : '0'));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['Open'] = this.open;
    data['Close'] = this.close;
    data['High'] = this.high;
    data['Low'] = this.low;
    data['Adj Close'] = this.adjClose;
    data['Volume'] = this.volume;
    return data;
  }
}
