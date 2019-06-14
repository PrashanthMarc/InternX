// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:swecha/widgets/white_app_bar.dart';
// import 'package:zefyr/zefyr.dart';

// class AddFeedPage extends StatefulWidget {
//   static String TAG = "ADD_FEED_PAGE";
//   @override
//   _AddFeedPageState createState() => _AddFeedPageState();
// }

// class _AddFeedPageState extends State<AddFeedPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey =
//       GlobalKey<ScaffoldState>(debugLabel: "add_feed_page");

//   ZefyrController _controller;
//   FocusNode _focusNode;

//   final document = new NotusDocument();

//   @override
//   void initState() {
//     super.initState();
//     _controller = new ZefyrController(document);
//     _focusNode = new FocusNode();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: WhiteAppBar(
//         title: Text("Add Post"),
//         centerTitle: true,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.check,
//             ),
//             onPressed: () {},
//           )
//         ],
//       ),
//       body: ZefyrScaffold(
//         child: ZefyrEditor(
//           controller: _controller,
//           focusNode: _focusNode,
//           imageDelegate: CustomZefyrImageDelegate(),
//         ),
//       ),
//     );
//   }
// }

// class CustomZefyrImageDelegate implements ZefyrImageDelegate<ImageSource> {
//   // ...

//   @override
//   Widget buildImage(BuildContext context, String imageSource) {
//     final file = new File.fromUri(Uri.parse(imageSource));

//     /// Create standard [FileImage] provider. If [imageSource] was an HTTP link
//     /// we could use [NetworkImage] instead.
//     final image = new FileImage(file);
//     return new Image(image: image);
//   }

//   @override
//   Future<String> pickImage(ImageSource source) async {
//     final file = await ImagePicker.pickImage(source: source);
//     if (file == null) return null;
//     // We simply return the absolute path to selected file.
//     return file.uri.toString();
//   }
// }
