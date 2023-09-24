class Users {
  bool? status;
  String? message;
  List<Data>? usersList;

  Users({this.status, this.message, this.usersList});

  Users.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      usersList = <Data>[];
      json['data'].forEach((v) {
        usersList!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.usersList != null) {
      data['data'] = this.usersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? image;
  String? studentId;
  String? imageUrl;

  Data({this.id, this.image, this.studentId, this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    studentId = json['student_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['student_id'] = this.studentId;
    data['image_url'] = this.imageUrl;
    return data;
  }
}