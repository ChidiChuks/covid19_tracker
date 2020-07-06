import 'package:covid19_tracker/model/covid19_dashboard.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Covid19Dashboard> list = [];

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

    list = getData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView.builder(itemBuilder: (context, index){
        
        return ListTile(
          title: Text('${list.countries[index]}'),
        );
      }),
    );
  }

  getData() async {
    Networking network = Networking();
    List<Covid19Dashboard> result = await network.getDashboardData();
    setState(() {
      list = result;
    });
    // return result;
  }
}