import 'package:covid19_tracker/bloc/global_bloc.dart';
import 'package:covid19_tracker/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/core.dart';

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
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardScreen(),
    );
  }
}
