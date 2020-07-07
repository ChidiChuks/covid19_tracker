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
      body: ListView.builder(
        
        itemCount: data.countries.length,
        itemBuilder: (context, index){
        
        return ListTile(
          leading: CountryPickerUtils.getDefaultFlagImage(Country(isoCode: data.countries[index].countryCode)),
          
          // Text('${data.countries[index].countryCode}'),
          title: Text('${data.countries[index].country}'),
          trailing: Text('${data.countries[index].confirmed}'),
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