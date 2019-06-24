class FeedModel {
  String count;
  List<AppData> appData;
  String page;
  List<Feeds> feeds;
  List<UserDetails> userDetails;
  String totalPages;

  FeedModel(
      {this.count,
      this.appData,
      this.page,
      this.feeds,
      this.userDetails,
      this.totalPages});

  FeedModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['app_data'] != null) {
      appData = new List<AppData>();
      json['app_data'].forEach((v) {
        appData.add(new AppData.fromJson(v));
      });
    }
    page = json['page'];
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
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.appData != null) {
      data['app_data'] = this.appData.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    if (this.feeds != null) {
      data['feeds'] = this.feeds.map((v) => v.toJson()).toList();
    }
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    return data;
  }
}

class AppData {
  String versionNumber;
  String changeLog;
  String downloadUrl;

  AppData({this.versionNumber, this.changeLog, this.downloadUrl});

  AppData.fromJson(Map<String, dynamic> json) {
    versionNumber = json['version_number'];
    changeLog = json['change_log'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version_number'] = this.versionNumber;
    data['change_log'] = this.changeLog;
    data['download_url'] = this.downloadUrl;
    return data;
  }
}

class Feeds {
  String info;
  String userPic;
  String body;
  String user;
  int id;
  String iamge;

  Feeds({this.info, this.userPic, this.body, this.user, this.id, this.iamge});

  Feeds.fromJson(Map<String, dynamic> json) {
    info = json['info'];
    userPic = json['user_pic'];
    body = json['body'];
    user = json['user'];
    id = json['id'];
    iamge = json['iamge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['info'] = this.info;
    data['user_pic'] = this.userPic;
    data['body'] = this.body;
    data['user'] = this.user;
    data['id'] = this.id;
    data['iamge'] = this.iamge;
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
