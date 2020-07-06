import 'package:covid19_tracker/model/covid19_dashboard.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:flutter/material.dart';

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

    data = getData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView.builder(itemBuilder: (context, index){
        
        return ListTile(
          title: Text('${data.countries[index].country}'),
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