import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_modal/rounded_modal.dart';
import 'package:swecha/misc/const_utils.dart';
import 'package:swecha/misc/palette.dart';
import 'package:swecha/misc/prefs.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/widgets/modal_picker.dart';
import 'package:swecha/widgets/white_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:swecha/misc/retoken.dart';

class ProfilePage extends StatefulWidget {
  static String TAG = "PROFILE";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "profile_page");
  bool isFollowing = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController trackController = TextEditingController();

  FocusNode nameFocus;

  String image = "";
  String uid = "";
  File currentPhoto;
  _showSnack(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(milliseconds: 1500),
    ));
  }

  _fetchUser() async {
    image =
        "${ConstUtils.baseUrlNoSlash}${await Prefs.getString("profilePic")}";
    uid = await Prefs.getString("uid");
    String name = await Prefs.getString("name");
    String track = await Prefs.getString("track");

    nameController.text = name;
    trackController.text = track;
    setState(() {});
    return null;
  }

  @override
  void initState() {
    nameFocus = FocusNode();
    _fetchUser();

    nameFocus.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  bool isUploadingProfilePic = false;

  _updateProfilePic() async {
    setState(() {
      isUploadingProfilePic = true;
    });

    Map<String, dynamic> uploadData = {
      "name": nameController.text,
    };

    if (currentPhoto != null) {
      uploadData["image"] = new UploadFileInfo(
          currentPhoto, "${DateTime.now().millisecondsSinceEpoch}.png");
    }

    String token = await Prefs.getString("token");

    FormData formData = new FormData.from(uploadData);

    var response = await Dio().post(
      "${ConstUtils.baseUrl}update_details/",
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token", // set content-length
        },
      ),
      onSendProgress: (int sent, int total) {
        print("$sent $total");
      },
    );

    if (response.statusCode == 401) {
      if (await refreshToken()) {
        token = await Prefs.getString("token");

        response = await Dio().post(
          "${ConstUtils.baseUrl}update_details/",
          data: formData,
          options: Options(
            headers: {
              "Authorization": "Bearer $token", // set content-length
            },
          ),
          onSendProgress: (int sent, int total) {
            print("$sent $total");
          },
        );
      } else {
        await Prefs.clear();
        WidgetUtils.proceedToAuth(context);
        return;
      }
    }

    if (response.statusCode == 200) {
      isUploadingProfilePic = false;
      await fetchUserDetails();
      await _fetchUser();
    } else {
      Fluttertoast.showToast(
        msg: "Error updating profile.",
        timeInSecForIos: 1,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    setState(() {});
  }

  Future<bool> fetchUserDetails() async {
    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };

    var response = await http.get(
      "${ConstUtils.baseUrl}get_user_details/",
      headers: headers,
    );

    bool _error = false;
    String _jsonResonse = "";

    if (response.statusCode == 200) {
      _jsonResonse = response.body;
      print(_jsonResonse);

      if (_jsonResonse.isNotEmpty) {
        Map<String, dynamic> json = jsonDecode(_jsonResonse);
        if (json["detail"] != null) {
          _error = true;
        } else {
          await Prefs.setString("profilePic", json["profile_pic"]);
          await Prefs.setString("uid", json["uid"]);
          await Prefs.setString("name", json["name"]);
          await Prefs.setString("track", json["track"]);
          _error = false;
        }
      } else {
        _error = true;
      }
    } else {
      _error = true;
    }

    return _error;
  }

  _openImagePicker() {
    showRoundedModalBottomSheet(
      context: context,
      builder: (context) => ModalImagePicker(
            pop: true,
            onSelected: (file) async {
              currentPhoto = file;
              _updateProfilePic();
            },
          ),
    );
  }

  @override
  void dispose() {
    nameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: WhiteAppBar(),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      right: 20.0,
                      left: 20.0,
                      top: 16.0,
                      bottom: 16.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: Palette.textBlack,
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: _openImagePicker,
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 0.0),
                                  child: Image(
                                    // color: Colors.red,
                                    height: 80.0,
                                    width: 80.0,
                                    fit: BoxFit.cover,
                                    image: AdvancedNetworkImage(
                                      image,
                                      useDiskCache: true,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Material(
                                    type: MaterialType.canvas,
                                    elevation: 10.0,
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      color: Colors.white,
                                      child: ImageIcon(
                                        AssetImage("images/camera.png"),
                                        color: Palette.lightGrey,
                                        size: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 20.0,
                      left: 20.0,
                      top: 16.0,
                      bottom: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            bottom: 0.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Name",
                                  style: TextStyle(
                                    color: Palette.lightGrey, //44464d, 100%
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: TextField(
                                  onSubmitted: (value) {
                                    _updateProfilePic();
                                  },
                                  focusNode: nameFocus,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Name",
                                    hintStyle: TextStyle(
                                      color:
                                          Palette.appBlack, //44464d 38% opacity
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  controller: nameController,
                                  style: TextStyle(
                                    color: nameFocus.hasFocus
                                        ? Palette.lightGrey
                                        : Palette.textBlack, //44464d, 100%
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                flex: 3,
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            bottom: 16.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Track",
                                  style: TextStyle(
                                    color: Palette.lightGrey,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration.collapsed(
                                    border: InputBorder.none,
                                    hintText: "Track",
                                    hintStyle: TextStyle(
                                      color: Palette
                                          .lightGrey, //44464d 38% opacity
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  controller: trackController,
                                  style: TextStyle(
                                    color: Palette.appBlack,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                flex: 3,
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
