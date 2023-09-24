class TaskModel {
  bool? status;
  String? message;
  Data? singleData;
  List<Data>? data;

  TaskModel({this.status, this.message, this.data,this.singleData});

  TaskModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'] is List){
        data = <Data>[];
        json['data'].forEach((v) {
          data!.add(new Data.fromJson(v));
        });
      } else {

    singleData = json['data'] != null ? new Data.fromJson(json['data']) : null;
      }

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? studentId;
  String? createdAt;
  String? updatedAt;
  bool? isDone;

  Data(
      {this.id,
        this.title,
        this.studentId,
        this.createdAt,
        this.updatedAt,
        this.isDone});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    studentId = json['student_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    isDone = json['is_done'];
  }

  Data.obj() {
    id = 1;
    title = "Test";
    studentId = "";
    createdAt = "";
    updatedAt = "";
    isDone = false;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['student_id'] = this.studentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_done'] = this.isDone;
    return data;
  }
}
