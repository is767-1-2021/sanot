import 'dart:async';

import 'package:flutter_calculator_app/models/history_model.dart';
import 'package:flutter_calculator_app/services/services.dart';

class CalculatorController {
  Services services = FirebaseServices();
  List<HistoryModel> data = [];

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;


  Future<List<HistoryModel>> favoriteList() async {
    onSyncController.add(true);
    data = await services.getHistoryList();
    onSyncController.add(false);
    return data;
  }

   Future<void> updatefavoriteList( List<HistoryModel> model) async {
    // onSyncController.add(true);
    // await services.updateFavoriteList(model);
    // onSyncController.add(false);
  }
}
