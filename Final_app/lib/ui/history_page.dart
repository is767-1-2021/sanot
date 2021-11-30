import 'package:flutter/material.dart';
import 'package:flutter_calculator_app/provider/calculator_provider.dart';
import 'package:flutter_calculator_app/services/services.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Services services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    CalculatorProvider calculatorProvider =
        Provider.of<CalculatorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Color(0xFF06121F),
      ),
      body: Container(
        color: Color(0xFF06121F),
        child: ListView.builder(
          // shrinkWrap: true,
            itemCount: calculatorProvider.history.length,
            itemBuilder: (context, int index) {
              var item = calculatorProvider.history[index];
              return Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: item.history.length,
                  itemBuilder: (context, int indexItem){
                    var history = item.history[indexItem];
                    return Container(
                  child: ListTile(
                    title: Text(
                      history.sum!,textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      history.result!,textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                );
                  }),
              );
            }),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var data = await services.getHistoryList();
    // print(data[0].sum);
  }
}

