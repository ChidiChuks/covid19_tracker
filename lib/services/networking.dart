import 'package:covid19_tracker/model/covid19_dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:covid19_tracker/model/serializers.dart';

class Networking {
  
   Future<Covid19Dashboard> getDashboardData() async {

    Covid19Dashboard _dashboardResult;
    var url = 'https://doh.saal.ai/api/live';

    var response = await http.get(url);

    if(response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      _dashboardResult = serializers.deserializeWith(Covid19Dashboard.serializer, data);
    } else{
      throw Exception('connection error');
    }

    return _dashboardResult;
  }

  Future<List<Covid19Dashboard>> getDashboardHistoryData() async {

    List<Covid19Dashboard> _dashboardHistoryResult = [];

    var url = 'https://doh.saal.ai/api/live';
    // var url = 'https://ksanj.github.io/json/covid-19/history.json';

    var response = await http.get(url);

    if(response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body);
      _dashboardHistoryResult.addAll(
        list.map((item) => serializers.deserializeWith(
          Covid19Dashboard.serializer, list),
        ),
      ); 
    } else{
      throw Exception('connection error');
    }

    return _dashboardHistoryResult;
  }
}