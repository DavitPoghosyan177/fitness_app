import 'dart:io';

import 'package:flutter/material.dart';

abstract class MediaService {
  Future<FileImage?> uploadPicture();
  Future<FileImage?> uploadFromCamera();
  Future<void> uploadProfilePicture(String userId, File file);
  Stream<List<Map<String, dynamic>>> getVideos();
  Stream<List<Map<String, dynamic>>> getArticles();
}

