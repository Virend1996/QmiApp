class ItemGroupModel {
  Data? data;

  ItemGroupModel({this.data});

  ItemGroupModel.fromJson(Map<String, dynamic> json) {
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
  String? value;
  String? label;

  Responses({this.value, this.label});

  Responses.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['label'] = this.label;
    return data;
  }
}