import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  late List<_ChartData> _chartData;

  @override
  void initState() {
    _chartData = <_ChartData>[
      _ChartData('Jan', 35),
      _ChartData('Feb', 28),
      _ChartData('Mar', 34),
      _ChartData('Apr', 32),
      _ChartData('May', 40)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <ChartSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                dataSource: _chartData,
                onCreateRenderer: (ChartSeries<_ChartData, String> series) {
                  return _CustomColumnSeriesRenderer();
                },
                xValueMapper: (_ChartData data, _) => data.year,
                yValueMapper: (_ChartData data, _) => data.sales,
              )
            ]));
  }
}

class _CustomColumnSeriesRenderer extends ColumnSeriesRenderer {
  _CustomColumnSeriesRenderer();

  @override
  ChartSegment createSegment() {
    return _ColumnCustomPainter();
  }
}

class _ColumnCustomPainter extends ColumnSegment {
  @override
  int get currentSegmentIndex => super.currentSegmentIndex!;

  @override
  void onPaint(Canvas canvas) {
    // List to hold the number of column data point's gradient
    final List<LinearGradient> gradientList = <LinearGradient>[
      const LinearGradient(
          colors: <Color>[Colors.cyan, Colors.greenAccent],
          stops: <double>[0.2, 0.9]),
      const LinearGradient(
          colors: <Color>[Colors.pink, Colors.purpleAccent],
          stops: <double>[0.2, 0.9]),
      const LinearGradient(
          colors: <Color>[Colors.deepPurple, Colors.blue],
          stops: <double>[0.2, 0.9]),
      const LinearGradient(
          colors: <Color>[Colors.deepOrange, Colors.amber],
          stops: <double>[0.2, 0.9]),
      const LinearGradient(
          colors: <Color>[Colors.blue, Colors.cyanAccent],
          stops: <double>[0.2, 0.9])
    ];
    // Set the gradient to the fillPaint using createShader method of the gradient.
    fillPaint!.shader =
        gradientList[currentSegmentIndex].createShader(segmentRect.outerRect);
    super.onPaint(canvas);
  }
}

class _ChartData {
  _ChartData(this.year, this.sales);

  final String year;
  final double sales;
}
