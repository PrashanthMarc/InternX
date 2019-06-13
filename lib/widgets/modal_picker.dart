/**
 * Copyright (c) Foodie Labs, Inc  - All Rights Reserved
 * 
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Karthik Ponnam for Foodie Labs, Inc , April 2019.
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:swecha/i18n/translation.dart';
import 'package:swecha/misc/logger.dart';
import 'package:image_picker/image_picker.dart';

class ModalImagePicker extends StatelessWidget {
  static const String TAG = "MODAL_IMAGE_PICKER";

  final Function(File) onSelected;
  final bool pop;

  const ModalImagePicker({Key key, @required this.onSelected, this.pop: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translation = Translation.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          onTap: () {
            if (pop) Navigator.of(context).pop();

            ImagePicker.pickImage(source: ImageSource.camera)
                .catchError((exception, stacktrace) {
              Logger.log(TAG,
                  message: "Couldn't get file from gallery, error: $exception");
              return null;
            }).then(onSelected);
          },
          leading: Icon(Icons.add_a_photo),
          title: Text(translation.cameraLabel),
        ),
        ListTile(
          onTap: () {
            if (pop) Navigator.of(context).pop();

            ImagePicker.pickImage(source: ImageSource.gallery)
                .catchError((exception, stacktrace) {
              Logger.log(TAG,
                  message: "Couldn't get file from gallery, error: $exception");
              return null;
            }).then(onSelected);
          },
          leading: Icon(Icons.image),
          title: Text(translation.galleryLabel),
        ),
      ],
    );
  }
}
