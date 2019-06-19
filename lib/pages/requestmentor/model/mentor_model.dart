class MentorModel {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  MentorModel({this.count, this.next, this.previous, this.results});

  MentorModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int id;
  String body;
  bool isResolved;
  int uid;

  Results({this.id, this.body, this.isResolved, this.uid});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    isResolved = json['is_resolved'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['is_resolved'] = this.isResolved;
    data['uid'] = this.uid;
    return data;
  }
}
