import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_calculator_app/models/history_model.dart';

abstract class Services {
  Future<List<HistoryModel>> getHistoryList();
  Future<void> updatHistoryList(List<HistoryModel> model);
}

class FirebaseServices extends Services {
  @override
  Future<List<HistoryModel>> getHistoryList() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('calculator_history').get();
    // print("############   ${snapshot.docs.length}");
    List<HistoryModel> historyList = [];
    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.forEach((DocumentSnapshot element) {
        var model = HistoryModel(Map<String, dynamic>());
        model =  HistoryModel(element.data() as Map<String, dynamic>);
        model.docId = element.id;
        print(model.docId);
        historyList.add(model);
      });
    }

    return historyList;
  }

  @override
  Future<void> updatHistoryList(List<HistoryModel> model) async {
    // TODO: implement updatHistoryList
    var data = await FirebaseFirestore.instance.collection('calculator_history');
    model.forEach((element) { 
      data.doc(element.docId).update({'history': element.history.map((i) => i.toJson()).toList()});
      // var data = jsonEncode(element.history);
      // element.history.
      print(element.history.map((i) => i.toJson()).toList());
    });
  }
}
