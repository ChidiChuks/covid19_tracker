import 'package:covid19_tracker/model/covid19_dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  
   getDashboardData() async {

    List<Covid19Dashboard> _dashboardResult = [];
    var url = 'https://doh.saal.ai/api/live';

    var response = await http.get(url);

    if(response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body);
    }
  }
}