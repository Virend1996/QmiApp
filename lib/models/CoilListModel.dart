class CoilListModel {
  Data? data;

  CoilListModel({this.data});

  CoilListModel.fromJson(Map<String, dynamic> json) {
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
  String? heatNo;
  double? tcWeight;
  double? coilWidth;
  double? coilLength;
  double? avlQty;

  Responses(
      {this.name,
        this.heatNo,
        this.tcWeight,
        this.coilWidth,
        this.coilLength,
        this.avlQty});

  Responses.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    heatNo = json['heat_no'];
    tcWeight = json['tc_weight'];
    coilWidth = json['coil_width'];
    coilLength = json['coil_length'];
    avlQty = json['avl_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['heat_no'] = this.heatNo;
    data['tc_weight'] = this.tcWeight;
    data['coil_width'] = this.coilWidth;
    data['coil_length'] = this.coilLength;
    data['avl_qty'] = this.avlQty;
    return data;
  }
}