class FeedModel {
  List<Feeds> feeds;
  List<UserDetails> userDetails;

  FeedModel({this.feeds, this.userDetails});

  FeedModel.fromJson(Map<String, dynamic> json) {
    if (json['feeds'] != null) {
      feeds = new List<Feeds>();
      json['feeds'].forEach((v) {
        feeds.add(new Feeds.fromJson(v));
      });
    }
    if (json['user_details'] != null) {
      userDetails = new List<UserDetails>();
      json['user_details'].forEach((v) {
        userDetails.add(new UserDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feeds != null) {
      data['feeds'] = this.feeds.map((v) => v.toJson()).toList();
    }
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feeds {
  String user;
  int id;
  String info;
  String iamge;
  String body;

  Feeds({this.user, this.id, this.info, this.iamge, this.body});

  Feeds.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    id = json['id'];
    info = json['info'];
    iamge = json['iamge'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['id'] = this.id;
    data['info'] = this.info;
    data['iamge'] = this.iamge;
    data['body'] = this.body;
    return data;
  }
}

class UserDetails {
  int userId;

  UserDetails({this.userId});

  UserDetails.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    return data;
  }
}
