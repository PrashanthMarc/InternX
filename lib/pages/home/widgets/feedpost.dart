import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:swecha/misc/const_utils.dart';
// import 'package:flutter_advanced_networkimage/provider.dart';
// import 'package:flutter_rating/flutter_rating.dart';
import 'package:swecha/misc/image_utils.dart';
import 'package:swecha/misc/palette.dart';
import 'package:swecha/misc/prefs.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/pages/home/state/feedstate.dart';
import 'package:swecha/widgets/modal_picker.dart';
import 'package:rounded_modal/rounded_modal.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

class FeedPostWidget extends StatefulWidget {
  final Function onDone;
  const FeedPostWidget({
    Key key,
    this.onDone,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  _FeedPostWidgetState createState() => _FeedPostWidgetState();
}

class _FeedPostWidgetState extends State<FeedPostWidget> {
  TextEditingController _postController = TextEditingController();

  bool isUpdating = false;

  File currentPhoto;

  _postFeed() async {
    if (_postController.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: "Please type something.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
      );
      return;
    }

    int userId = await Prefs.getInt("userId");

    if (userId == 0) {
      await Prefs.clear();
      WidgetUtils.proceedToAuth(context, replaceAll: true);
    }

    setState(() {
      isUpdating = true;
    });

    String token = await Prefs.getString("token");

    Uri postUri = Uri.parse("${ConstUtils.baseUrl}feed/");

    Map<String, dynamic> uploadData = {
      "body": _postController.text,
      "user": userId.toString(),
    };

    if (currentPhoto != null) {
      uploadData["image"] = new UploadFileInfo(
          currentPhoto, "${DateTime.now().millisecondsSinceEpoch}.png");
    }

    FormData formData = new FormData.from(uploadData);

    var response = await Dio().post(
      "${ConstUtils.baseUrl}feed/",
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token", // set content-length
        },
      ),
      onSendProgress: (int sent, int total) {
        // print("$sent $total");
      },
    );

    if (response.statusCode == 201) {
      isUpdating = false;
      widget.onDone();
      Navigator.of(context).pop(true);
    } else {
      Fluttertoast.showToast(
        msg: "Error posting feed",
        timeInSecForIos: 1,
        toastLength: Toast.LENGTH_SHORT,
      );
    }

    setState(() {
      isUpdating = false;
    });
  }

  Widget _buildAddComentBox() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      // padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: TextField(
              autocorrect: true,
              maxLines: 5,
              controller: _postController,
              decoration: InputDecoration.collapsed(
                  hintText: "Type something...",
                  hintStyle: TextStyle(fontFamily: "Nunito")),
            ),
          ),
          AddPhotoBlankWidget(
            onChanged: (photo) {
              currentPhoto = photo;
              print(currentPhoto == null);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Status Update",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildAddComentBox(),
                SizedBox(
                  height: 8.0,
                ),
                // StarRating(
                //   size: 35.0,
                //   color: Palette.starBlack,
                //   borderColor: Palette.lightGrey,
                //   rating: _newRating,
                //   onRatingChanged: (value) {
                //     setState(() {
                //       _newRating = value;
                //     });
                //   },
                // ),
              ],
            ),
          ),
          Divider(
            height: 1.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0a57d2),
                        fontFamily: "Nunito",
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
                      child: isUpdating
                          ? CircularProgressIndicator()
                          : Text(
                              "Post",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0a57d2),
                                fontFamily: "Nunito",
                              ),
                            ),
                    ),
                  ),
                  onTap: () {
                    _postFeed();
                    // Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddPhotoBlankWidget extends StatefulWidget {
  final Function(File) onChanged;

  AddPhotoBlankWidget({@required this.onChanged});

  @override
  _AddPhotoBlankWidgetState createState() => _AddPhotoBlankWidgetState();
}

class _AddPhotoBlankWidgetState extends State<AddPhotoBlankWidget> {
  File _selectedImage;
  File _croppedImage;

  // Image Picker
  _openImagePicker() {
    showRoundedModalBottomSheet(
      context: context,
      builder: (context) => ModalImagePicker(
            pop: true,
            onSelected: (file) async {
              if (mounted && file != null) {
                print(file.path);
                print(await file.stat());
                setState(() {
                  _selectedImage = file;
                });
                final snapshot = await ImageUtils.nativeResize(
                  _selectedImage,
                  683,
                  centerCrop: false,
                );
                if (snapshot != null) {
                  setState(() {
                    _croppedImage = snapshot;
                  });
                } else {
                  setState(() {
                    _croppedImage = null;
                  });
                }
                widget.onChanged(_croppedImage);
              }
            },
          ),
    );
  }
  // Image picker End

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openImagePicker();
      },
      child: Container(
        width: 70.0,
        height: 70.0,
        color: _croppedImage == null ? Palette.lightGrey : Colors.white,
        child: Center(
          child: _croppedImage == null
              ? ImageIcon(
                  AssetImage("images/icon_plus.png"),
                  size: 20.0,
                )
              : Image.file(_croppedImage),
        ),
      ),
    );
  }
}
