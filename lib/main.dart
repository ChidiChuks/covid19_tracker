import 'package:covid19_tracker/bloc/global_bloc.dart';
import 'package:covid19_tracker/constant.dart';
// import 'package:covid19_tracker/screens/dashboard.dart';
// import 'package:covid19_tracker/widgets/my_header.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/core.dart';

import 'info_screen.dart';

void main() {
  SyncfusionLicense.registerLicense('NT8mJyc2IWhia31hfWN9Z2doYmF8YGJ8ampqanNiYmlmamlmanMDHmgwOzo3OjYxNiE2DDA7JjgkJj4yEyoyOzw8fTA8Pg==');
  runApp(
    
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalBloc>(create: (_) => GlobalBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue[900],
       scaffoldBackgroundColor: kBackgroundColor,
       fontFamily: "Poppins",
       textTheme: TextTheme(body1: TextStyle(color: kBodyTextColor)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: DashboardScreen(),
      home: InfoScreen(),
    );
  }
}

