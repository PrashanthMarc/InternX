class ScheduleModel {
  int day;
  String location;
  String title;
  int weight;

  ScheduleModel({this.day, this.location, this.title, this.weight});

  // List<Image> imagesList = list.map((i) => Image.fromJson(i)).toList();

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    location = json['location'];
    title = json['title'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['location'] = this.location;
    data['title'] = this.title;
    data['weight'] = this.weight;
    return data;
  }
}
