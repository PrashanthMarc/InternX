class FeedModel {
  List<UserDetails> userDetails;
  List<Feeds> feeds;

  FeedModel({this.userDetails, this.feeds});

  FeedModel.fromJson(Map<String, dynamic> json) {
    if (json['user_details'] != null) {
      userDetails = new List<UserDetails>();
      json['user_details'].forEach((v) {
        userDetails.add(new UserDetails.fromJson(v));
      });
    }
    if (json['feeds'] != null) {
      feeds = new List<Feeds>();
      json['feeds'].forEach((v) {
        feeds.add(new Feeds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails.map((v) => v.toJson()).toList();
    }
    if (this.feeds != null) {
      data['feeds'] = this.feeds.map((v) => v.toJson()).toList();
    }
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

class Feeds {
  String info;
  String user;
  String body;
  String iamge;
  int id;
  String userPic;

  Feeds({this.info, this.user, this.body, this.iamge, this.id, this.userPic});

  Feeds.fromJson(Map<String, dynamic> json) {
    info = json['info'];
    user = json['user'];
    body = json['body'];
    iamge = json['iamge'];
    id = json['id'];
    userPic = json['user_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['info'] = this.info;
    data['user'] = this.user;
    data['body'] = this.body;
    data['iamge'] = this.iamge;
    data['id'] = this.id;
    data['user_pic'] = this.userPic;
    return data;
  }
}
