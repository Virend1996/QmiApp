class RawMaterialListModel {
  Data? data;

  RawMaterialListModel({this.data});

  RawMaterialListModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  String? coilNo;
  String? heatNo;

  Responses({this.name, this.date, this.coilNo, this.heatNo});

  Responses.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    coilNo = json['coil_no'];
    heatNo = json['heat_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    data['coil_no'] = this.coilNo;
    data['heat_no'] = this.heatNo;
    return data;
  }
}
