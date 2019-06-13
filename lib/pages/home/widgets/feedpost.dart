import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter_advanced_networkimage/provider.dart';
// import 'package:flutter_rating/flutter_rating.dart';
import 'package:swecha/misc/image_utils.dart';
import 'package:swecha/misc/palette.dart';
import 'package:swecha/widgets/modal_picker.dart';
import 'package:rounded_modal/rounded_modal.dart';

class FeedPostWidget extends StatefulWidget {
  const FeedPostWidget({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  _FeedPostWidgetState createState() =>
      _FeedPostWidgetState();
}

class _FeedPostWidgetState extends State<FeedPostWidget> {
  TextEditingController _commentController = TextEditingController();
  double _newRating = 0;

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
              controller: _commentController,
              decoration: InputDecoration.collapsed(
                hintText: "Give your opinion",
              ),
            ),
          ),
          AddPhotoBlankWidget(
            onChanged: (photo) {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Divider(),
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
                : Image.asset(
                    "images/icon_plus.png",
                    fit: BoxFit.contain,
                  )),
      ),
    );
  }
}
