import 'package:flutter/material.dart';
import 'package:flutter_calculator_app/models/history_model.dart';
import 'package:flutter_calculator_app/services/services.dart';

class CalculatorProvider extends ChangeNotifier {
  Services services = FirebaseServices();
  List<HistoryModel> history = [];

  Future<void> getHistoryFromFirebase() async {
    var data = await services.getHistoryList();
    if(data.isEmpty){
      print("Firebase not have data or lost to connect, please check");
    }
    history = data;
    notify();
  }

  Future<void> updateHistoryToFirebase(List<HistoryModel> model) async {
     await services.updatHistoryList(model);
  }



  void addToListHistory(HistoryItemModel data){
    // history.add(data);
    history.forEach((element) { 
      element.history.add(data);
    });
    notify();
  }

  void notify() {
    notifyListeners();
  }
}
