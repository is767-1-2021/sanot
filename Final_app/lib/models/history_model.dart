import 'dart:convert';

class HistoryModel {
  late String docId;
  late List<HistoryItemModel> history;

  HistoryModel(Map<String, dynamic> json) {
    history = [];
    // print(json['history']);
    if (json['history'] != null) {
      history = [];
      json['history'].forEach((v) {
        history.add(HistoryItemModel(v));
      });
    }
  }
  Map<String, dynamic>? toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['docId'] = this.docId;
    data['history'] = this.history.map((i) => i.toJson()).toList();
    return data;
  }
}

class HistoryItemModel {
  String? sum;
  String? result;
  HistoryItemModel(Map<String, dynamic> json) {
    sum = json['sum'];
    result = json['result'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sum'] = this.sum;
    data['result'] = this.result;
    return data;
  }
}
