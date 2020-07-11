import 'package:covid19_tracker/model/countries.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/core.dart';

class CountryScreen extends StatelessWidget {
  final Countries country;
  
  CountryScreen({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${country.country} info.'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0,),
              child: Image.network(
                "https://www.countryflags.io/${country.countryCode}/flat/64.png",
                // scale: 1.0,
                width: MediaQuery.of(context).size.width / 3, 
                fit: BoxFit.fill,
              ),
            ),

            SizedBox(height: 10),

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
                series: <ChartSeries<SalesData, String>>[
                  LineSeries<SalesData, String>(
                      dataSource: <SalesData>[
                        SalesData('Jan', 35),
                        SalesData('Feb', 28),
                        SalesData('Mar', 34),
                        SalesData('Apr', 32),
                        SalesData('May', 40)
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
            ),

            // buildDetailText(color: Colors.orangeAccent, count: index + 1, text: 'Ranks'),

            buildDetailText(color: Colors.orangeAccent, count: country.confirmed, text: 'Confirmed'),
                            
            buildDetailText(color: Colors.blue, count: country.active, text: 'Active'),
            
            buildDetailText(color: Colors.green, count: country.recovered, text: 'Recovered'),
            
            buildDetailText(color: Colors.red, count: country.deaths, text: 'Deaths'),
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

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}