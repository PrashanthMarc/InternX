class ScheduleModel {
  String location;
  List<Assigments> assigments;
  int weight;
  int sidId;
  String title;
  int day;

  ScheduleModel(
      {this.location,
      this.assigments,
      this.weight,
      this.sidId,
      this.title,
      this.day});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    if (json['assigments'] != null) {
      assigments = new List<Assigments>();
      json['assigments'].forEach((v) {
        assigments.add(new Assigments.fromJson(v));
      });
    }
    weight = json['weight'];
    sidId = json['sid_id'];
    title = json['title'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    if (this.assigments != null) {
      data['assigments'] = this.assigments.map((v) => v.toJson()).toList();
    }
    data['weight'] = this.weight;
    data['sid_id'] = this.sidId;
    data['title'] = this.title;
    data['day'] = this.day;
    return data;
  }
}

class Assigments {
  int no;
  String body;

  Assigments({this.no, this.body});

  Assigments.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['body'] = this.body;
    return data;
  }
}

// class ScheduleModel {
//   int day;
//   String location;
//   String title;
//   int weight;

//   ScheduleModel({this.day, this.location, this.title, this.weight});

//   // List<Image> imagesList = list.map((i) => Image.fromJson(i)).toList();

//   ScheduleModel.fromJson(Map<String, dynamic> json) {
//     day = json['day'];
//     location = json['location'];
//     title = json['title'];
//     weight = json['weight'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['day'] = this.day;
//     data['location'] = this.location;
//     data['title'] = this.title;
//     data['weight'] = this.weight;
//     return data;
//   }
// }
