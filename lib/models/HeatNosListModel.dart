class HeatNosListModel {
  Data? data;

  HeatNosListModel({this.data});

  HeatNosListModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? httpStatusCode;
  String? status;
  int? totalRecords;
  List<Responses>? response;

  Data({this.httpStatusCode, this.status, this.totalRecords, this.response});

  Data.fromJson(Map<String, dynamic> json) {
    httpStatusCode = json['http_status_code'];
    status = json['status'];
    totalRecords = json['total_records'];
    if (json['response'] != null) {
      response = <Responses>[];
      json['response'].forEach((v) {
        response!.add(new Responses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['http_status_code'] = this.httpStatusCode;
    data['status'] = this.status;
    data['total_records'] = this.totalRecords;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Responses {
  String? name;
  String? itemCode;
  String? itemName;

  Responses({this.name, this.itemCode, this.itemName});

  Responses.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    return data;
  }
}