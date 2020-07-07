import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:covid19_tracker/model/covid19_dashboard.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:flutter/material.dart';

// import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';

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
        : ListView.builder(
        
          itemCount: data.countries.length,
          itemBuilder: (context, index){
        
          return ExpansionTile(
            leading: data.countries[index].countryCode.length == 2 ? CountryPickerUtils.getDefaultFlagImage(
              Country(isoCode: data.countries[index].countryCode)
            ) : Text(''),
            
            // Text('${data.countries[index].countryCode}'),
            title: Text('${data.countries[index].country}'),
            trailing: Text('${data.countries[index].confirmed}'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Rank: ${index + 1}', style: TextStyle(color: Colors.orangeAccent),),
                        SizedBox(height: 10,),
                        Text('Confirmed: ${data.countries[index].confirmed}'),
                        SizedBox(height: 10,),
                        Text('Recovered: ${data.countries[index].recovered}', style: TextStyle(color: Colors.green),),
                        SizedBox(height: 10,),
                        Text('Deaths: ${data.countries[index].deaths}', style: TextStyle(color: Colors.red),),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
    );
  }

  getData() async {
    Networking network = Networking();
    Covid19Dashboard result = await network.getDashboardData();
    setState(() {
      data = result;
    });
    // return result;
  }
}