class ScheduleModel {
  String location;
  int weight;
  String title;
  List<Assigments> assigments;
  int day;

  ScheduleModel(
      {this.location, this.weight, this.title, this.assigments, this.day});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    weight = json['weight'];
    title = json['title'];
    if (json['assigments'] != null) {
      assigments = new List<Assigments>();
      json['assigments'].forEach((v) {
        assigments.add(new Assigments.fromJson(v));
      });
    }
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['weight'] = this.weight;
    data['title'] = this.title;
    if (this.assigments != null) {
      data['assigments'] = this.assigments.map((v) => v.toJson()).toList();
    }
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
