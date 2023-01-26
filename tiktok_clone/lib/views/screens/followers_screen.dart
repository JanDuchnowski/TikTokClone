import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/models/user/user.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({Key? key, required this.user}) : super(key: key);

  final User? user;
  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.user!.name),
        centerTitle: true,
      ),
      body: ListView(children: [Text("Test")]),
    );
  }
}
