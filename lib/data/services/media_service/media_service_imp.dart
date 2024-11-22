import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_app/data/services/media_service/media_serivce.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaServiceImp implements MediaService {
  MediaServiceImp(this.firebaseFirestore, this.firebaseStorage);

  ImagePicker get picker => ImagePicker();
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  @override
  Future<FileImage?> uploadFromCamera() async {
    XFile? xFile = await picker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      return FileImage(File(xFile.path));
    }
    return null;
  }

  @override
  Future<FileImage?> uploadPicture() async {
    XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      return FileImage(File(xFile.path));
    }
    return null;
  }

  @override
  Future<void> uploadProfilePicture(String userId, File file) async {
    final Reference ref = firebaseStorage
        .ref('usersAvatar/')
        .child(Timestamp.now().millisecondsSinceEpoch.toString());
    await ref.putFile(file);
    final String downloadUrl = await ref.getDownloadURL();
    await firebaseFirestore
        .collection('users')
        .doc(userId)
        .update({'photoUrl': downloadUrl});
  }

  @override
  Stream<List<Map<String, dynamic>>> getVideos() {
    return firebaseFirestore.collection('videos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          "title": doc.data()["title"] ?? "",
          "video_url": doc.data()["video_url"] ?? "",
        };
      }).toList();
    });
  }
  @override
  Stream<List<Map<String, dynamic>>> getArticles() {
    return firebaseFirestore.collection('articles').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}
