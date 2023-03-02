import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:json_practice/model/user_model.dart';
import 'package:json_practice/repository/get_data.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final Future<List<UserModel>> _repo = UserRepository().getUserList();
  late final Future<List<UserModel>> _userList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userList = _repo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remote Api with Dio'),
      ),
      body: Center(
          child: FutureBuilder<List<UserModel>>(
        future: _userList,
        builder: (
          context,
          snapshot,
        ) {
          if (snapshot.hasData) {
            var userList = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) {
                var user = userList[index];
                return ListTile(
                  title: Text(user.email),
                  subtitle: Text(user.address.toString()),
                  leading: Text(user.id.toString()),
                );
              },
              itemCount: userList.length,
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error as String);
          } else {
            return const CircularProgressIndicator();
          }
        },
      )),
    );
  }
}
