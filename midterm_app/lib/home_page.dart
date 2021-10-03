import 'package:flutter/material.dart';
import 'package:midterm_app/second_page.dart';
import 'package:midterm_app/third_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid View'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(2, (index) {
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Thirdpage()));
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text('Tap at $index'),
              // ));
            },
            child: Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                  child: Text(
                'Page ${index + 1}',
                style: Theme.of(context).textTheme.headline5,
              )),
            ),
          );
        }),
      ),
    );
  }
}
