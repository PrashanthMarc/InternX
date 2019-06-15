class FeedModel {
  List<Feeds> feeds;
  List<AppData> appData;
  List<UserDetails> userDetails;

  FeedModel({this.feeds, this.appData, this.userDetails});

  FeedModel.fromJson(Map<String, dynamic> json) {
    if (json['feeds'] != null) {
      feeds = new List<Feeds>();
      json['feeds'].forEach((v) {
        feeds.add(new Feeds.fromJson(v));
      });
    }
    if (json['app_data'] != null) {
      appData = new List<AppData>();
      json['app_data'].forEach((v) {
        appData.add(new AppData.fromJson(v));
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
    if (this.appData != null) {
      data['app_data'] = this.appData.map((v) => v.toJson()).toList();
    }
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feeds {
  int id;
  String user;
  String info;
  String body;
  String userPic;
  String iamge;

  Feeds({this.id, this.user, this.info, this.body, this.userPic, this.iamge});

  Feeds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    info = json['info'];
    body = json['body'];
    userPic = json['user_pic'];
    iamge = json['iamge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['info'] = this.info;
    data['body'] = this.body;
    data['user_pic'] = this.userPic;
    data['iamge'] = this.iamge;
    return data;
  }
}

class AppData {
  String changeLog;
  String versionNumber;
  String downloadUrl;

  AppData({this.changeLog, this.versionNumber, this.downloadUrl});

  AppData.fromJson(Map<String, dynamic> json) {
    changeLog = json['change_log'];
    versionNumber = json['version_number'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['change_log'] = this.changeLog;
    data['version_number'] = this.versionNumber;
    data['download_url'] = this.downloadUrl;
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
