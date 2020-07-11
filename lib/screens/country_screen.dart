import 'package:covid19_tracker/model/countries.dart';
import 'package:covid19_tracker/model/covid19_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/core.dart';

class CountryScreen extends StatefulWidget {
  final Countries country;

  CountryScreen({Key key, this.country}) : super(key: key);

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  final List<Covid19Dashboard> historyData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.country.country} info.'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0,),
              child: Image.network(
                "https://www.countryflags.io/${widget.country.countryCode}/flat/64.png",
                // scale: 1.0,
                width: MediaQuery.of(context).size.width / 3, 
                fit: BoxFit.fill,
              ),
            ),

            SizedBox(height: 10),
            
            // buildDetailText(color: Colors.orangeAccent, count: index + 1, text: 'Ranks'),

            buildDetailText(color: Colors.orangeAccent, count: widget.country.confirmed, text: 'Confirmed'),
                            
            buildDetailText(color: Colors.blue, count: widget.country.active, text: 'Active'),
            
            buildDetailText(color: Colors.green, count: widget.country.recovered, text: 'Recovered'),
            
            buildDetailText(color: Colors.red, count: widget.country.deaths, text: 'Deaths'),

            Container(
              width: MediaQuery.of(context).size.width - 10,
              height: (MediaQuery.of(context).size.width * 0.70) - 10,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Half yearly analysis'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<ChartItem, String>>[
                  LineSeries<ChartItem, String>(
                      dataSource: <ChartItem>[
                        ChartItem('Jan', 35),
                        ChartItem('Feb', 28),
                        ChartItem('Mar', 34),
                        ChartItem('Apr', 32),
                        ChartItem('May', 40)
                      ],
                      xValueMapper: (ChartItem sales, _) => sales.date,
                      yValueMapper: (ChartItem sales, _) => sales.count,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildDetailText({int count, Color color, String text}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: ListTile(
      title: Text('$text', style: TextStyle(color: color, fontWeight: FontWeight.bold),),
      subtitle: Text('${formatter.format(count)}'),
    ),
  );

  final formatter = NumberFormat.decimalPattern('en-US');
}

class ChartItem {
  ChartItem(this.date, this.count);

  final String date;
  final int count;
}