import 'package:flutter/material.dart';
import 'package:flutter_calculator_app/provider/calculator_provider.dart';
import 'package:flutter_calculator_app/ui/my_app.dart';
import 'package:provider/provider.dart';

class MyAppLanch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalculatorProvider()),
      ],
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: MaterialApp(
          title: 'Expense App',
          home: MyApp(),
        ),
      ),
    );
  }
}
