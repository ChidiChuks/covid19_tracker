import 'package:covid19_tracker/model/covid19_dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:covid19_tracker/model/serializers.dart';

class Networking {
  
   Future<List<Covid19Dashboard>> getDashboardData() async {

    List<Covid19Dashboard> _dashboardResult = [];
    var url = 'https://doh.saal.ai/api/live';

    var response = await http.get(url);

    if(response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body);
      _dashboardResult.addAll(list.map(
        (e) => serializers.serializeWith(Covid19Dashboard.serializer, e)));
    } else{
      throw Exception('connection error');
    }

    return _dashboardResult;
  }
}