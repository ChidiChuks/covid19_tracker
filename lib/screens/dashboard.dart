import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:covid19_tracker/model/countries.dart';
import 'package:covid19_tracker/model/covid19_dashboard.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:flutter/material.dart';

// import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Covid19Dashboard data;

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    // Networking network = Networking();
    // List<Covid19Dashboard> result = network.getDashboardData();

    // List<Covid19Dashboard> _list;

    // data = getData();



    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Dashboard'),
      ),
      body: data == null 
        ? Center(child: CircularProgressIndicator()) 
        : RefreshIndicator(
            onRefresh: getData,
            child: 

            CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildListDelegate([
                    buildSummaryCard(
                      text: 'Confirmed', 
                      color: Colors.black54, 
                      count: data.confirmed,
                    ),
                    buildSummaryCard(
                      text: 'Active', 
                      color: Colors.blue, 
                      count: data.active,
                    ),
                    buildSummaryCard(
                      text: 'Recovered', 
                      color: Colors.green, 
                      count: data.recovered,
                    ),
                    buildSummaryCard(
                      text: 'Deaths', 
                      color: Colors.red, 
                      count: data.deaths,
                    ),
                  ]), 
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.3,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var item = data.countries[index];
                      return buildExpansionTile(item, index);
                    },
                    childCount: data.countries.length,
                  ),
                ),
              ],
            ),
            
          //   ListView.builder(
          
          //   itemCount: data.countries.length,
          //   itemBuilder: (context, index){

          //     var item = data.countries[index];
          
          //   return buildExpansionTile(item, index);
          // }),
        ),
    );
  }

  Padding buildSummaryCard({int count, Color color, String text}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 10, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              text, 
              style: TextStyle(
                color: color, 
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${formatter.format(count)}',
              style: TextStyle(
                color: color, 
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ExpansionTile buildExpansionTile(Countries item, int index) {
    return ExpansionTile(
            leading: item.countryCode.length == 2 ? CountryPickerUtils.getDefaultFlagImage(
              Country(isoCode: item.countryCode)
            ) : Text(''),
            
            // Text('${data.countries[index].countryCode}'),
            title: Text('${item.country}'),
            trailing: Text('${formatter.format(item.confirmed)}'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildDetailText(color: Colors.orangeAccent, count: index + 1, text: 'Ranks'),
                        // Text('Rank: ${index + 1}', style: TextStyle(color: Colors.orangeAccent),),
                        // SizedBox(height: 10,),
                        buildDetailText(color: Colors.blue, count: item.active, text: 'Active'),
                        // Text('Confirmed: ${item.confirmed}'),
                        // SizedBox(height: 10,),
                        buildDetailText(color: Colors.green, count: item.recovered, text: 'Recovered'),
                        
                        buildDetailText(color: Colors.red, count: item.deaths, text: 'Deaths'),
                        // Text('Deaths: ${item.deaths}', style: TextStyle(color: Colors.red),),
                        // SizedBox(height: 10,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  Widget buildDetailText({int count, Color color, String text}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Text(
      '$text: ${formatter.format(count)}', 
      style: TextStyle(color: color),
    ),
  );

  Future<void> getData() async {
    Networking network = Networking();
    Covid19Dashboard result = await network.getDashboardData();
    setState(() {
      data = result;
    });
    // return result;
  }

  final formatter = NumberFormat.decimalPattern('en-US');

  
}