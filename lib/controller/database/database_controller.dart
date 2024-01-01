// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:game_flutter/controller/auth/auth_controller.dart';
import 'package:game_flutter/model/Score.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  Client client = Client();
  AuthController authController = Get.put(AuthController());
  late Databases databases;
  final dbId = '6591d6cd5400971051a3';
  final scoreCollectionId = '6591d6e9c9d8de2d075b';

  RxList scoreData = [].obs;
  var isLoading = false.obs;
  var move = 0.obs;
  var pola = "3x3".obs;

  @override
  void onInit() {
    super.onInit();
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('6591d2ab3257f076fa44');
    databases = Databases(client);
  }

  Future createDataScore() async {
    final docId = await authController.getUserId();
    var newData = {};

    try {
      final result = await databases.createDocument(
        databaseId: dbId,
        collectionId: scoreCollectionId,
        documentId: docId,
        data: {"pola": pola.value, "score": move.value},
      );

      move.value = 0;
      pola.value = "3x3";
    } catch (e) {
      log(e.toString());
    }
  }

  Future readDataScore() async {
    final docId = await authController.getUserId();
    scoreData.clear();

    try {
      final result = await databases.getDocument(
        databaseId: dbId,
        collectionId: scoreCollectionId,
        documentId: docId,
      );

      Score score = Score.fromJson(result.data);
      scoreData.add(score);
    } catch (e) {
      log(e.toString());
    }
  }

  Future updateDataScore() async {
    final docId = await authController.getUserId();

    try {
      Future result = databases.updateDocument(
          databaseId: dbId,
          collectionId: scoreCollectionId,
          documentId: docId,
          data: {"pola": pola.value, "score": move.value});
    } catch (e) {
      log(e.toString());
    }
  }

  Future checkDataScore() async {
    final docId = await authController.getUserId();

    try {
      final result = await databases.getDocument(
        databaseId: dbId,
        collectionId: scoreCollectionId,
        documentId: docId,
      );

      if (result.data.isEmpty) {
        createDataScore();
      } else {
        updateDataScore();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future addUserDetail(String username) async {
    final docId = await authController.getUserId();

    try {
      await databases.createDocument(
          databaseId: dbId,
          collectionId: "65920cdcefd7400498f8",
          documentId: docId,
          data: {"uid": docId, "username": username});
    } catch (e) {
      log(e.toString());
    }
  }

  Future addFriend(String uid) async {
    final friendId = await authController.getUserId();

    try {
      await databases.updateDocument(
          databaseId: dbId,
          collectionId: "65920cdcefd7400498f8",
          documentId: uid,
          data: {
            "uid": uid,
            "friends": [
              {"id": ID.unique(), "friend_id": friendId, "status": "requested"}
            ]
          });
    } catch (e) {
      log(e.toString());
    }
  }
}
