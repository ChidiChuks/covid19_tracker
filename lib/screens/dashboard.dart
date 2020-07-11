import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:covid19_tracker/model/countries.dart';
import 'package:covid19_tracker/model/covid19_dashboard.dart';
import 'package:covid19_tracker/screens/country_screen.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:covid19_tracker/services/search_delegate.dart';
import 'package:covid19_tracker/widgets/my_header.dart';
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

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  Covid19Dashboard data;
  List<Covid19Dashboard> dataHistory;

  AnimationController _controller;
  Animation _curvedAnimation;

  @override
  void initState() {
    super.initState();

    dataHistory = [];

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 5000),);

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    getData();

    // _controller.forward();
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
        // appBarTheme: AppBarTheme(color: Colors.blue[900]),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: () {
              showSearch(
                context: context, 
                delegate: OurSearchDelegate(
                  countriesList: data.countries.toList(),
                ),
              );
            },
          ),
        ],
      ),
      body: data == null 
        ? Center(child: CircularProgressIndicator()) 
        : RefreshIndicator(
            onRefresh: getData,
            child: 

            CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(child: Text('Global Update on Covid-19', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15,),)),
                    ),
                  ]),
                ),
                SliverGrid(
                  delegate: SliverChildListDelegate([
                    buildSummaryCard(
                      text: 'Confirmed Cases', 
                      color: Colors.orangeAccent, 
                      // color: Colors.white, 
                      count: data.confirmed,
                      
                    ),
                    buildSummaryCard(
                      text: 'Active Cases', 
                      color: Colors.blue, 
                      // color: Colors.white, 
                      count: data.active,
                    ),
                    buildSummaryCard(
                      text: 'Recovered Cases', 
                      color: Colors.green, 
                      // color: Colors.white, 
                      count: data.recovered,
                    ),
                    buildSummaryCard(
                      text: 'Deaths', 
                      color: Colors.red, 
                      // color: Colors.white, 
                      count: data.deaths,
                    ),
                  ]), 
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.3,
                  ),
                ),
              
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Results\' date: ${data.date}', 
                              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
                            ),
                            SizedBox(height: 15.0),
                            // Text(
                            //   'Update per Country', 
                            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23,),
                            // ),
                            // SizedBox(height: 5.0),
                            Text(
                              'Click on any country of your choice to view more...', 
                              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 7.7),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
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

  Widget buildSummaryCard({int count, Color color, String text}) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0, 
        end: 1,
      ).animate(_curvedAnimation),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 10, 
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text, 
                style: TextStyle(
                  color: color, 
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                '${formatter.format(count)}',
                style: TextStyle(
                  color: color, 
                  // fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildExpansionTile(Countries item, int index) {
    return ListTile(
            leading: item.countryCode.length == 2 ? CountryPickerUtils.getDefaultFlagImage(
              Country(isoCode: item.countryCode)
            ) : Text(''),
            
            // Text('${data.countries[index].countryCode}'),
            title: Text('${item.country}'),
            trailing: Text('${formatter.format(item.confirmed)}'),

            onTap: () => Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => CountryScreen(country: item),
              ),
            ), 
            // children: <Widget>[
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 18.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: <Widget>[
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             buildDetailText(color: Colors.orangeAccent, count: index + 1, text: 'Ranks'),
            //             // Text('Rank: ${index + 1}', style: TextStyle(color: Colors.orangeAccent),),
            //             // SizedBox(height: 10,),
            //             buildDetailText(color: Colors.blue, count: item.active, text: 'Active'),
            //             // Text('Confirmed: ${item.confirmed}'),
            //             // SizedBox(height: 10,),
            //             buildDetailText(color: Colors.green, count: item.recovered, text: 'Recovered'),
                        
            //             buildDetailText(color: Colors.red, count: item.deaths, text: 'Deaths'),
            //             // Text('Deaths: ${item.deaths}', style: TextStyle(color: Colors.red),),
            //             // SizedBox(height: 10,),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ],
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
    List<Covid19Dashboard> resultHistory = await network.getDashboardHistoryData();
    setState(() {
      data = result;
      dataHistory = resultHistory;
      // print(dataHistory);
      if(data != null) {
        _controller.reset();
        _controller.forward();
      }
    });
    // return result;
    
  }

  final formatter = NumberFormat.decimalPattern('en-US');
  
}