import 'dart:io';

import 'package:fitness_app/data/services/media_service/media_serivce.dart';
import 'package:fitness_app/domain/repositories/media_repository.dart';
import 'package:flutter/material.dart';


class MediaRepostoryImp implements MediaRepository {
  MediaRepostoryImp({required this.mediaService});

  final MediaService mediaService;

  @override
  Future<FileImage?> uploadFromCamera() {
    return mediaService.uploadFromCamera();
  }

  @override
  Future<FileImage?> uploadPicture() {
    return mediaService.uploadPicture();
  }
    @override
  Future<void> uploadProfilePicture(String userId, File file) async {
    await mediaService.uploadProfilePicture(userId, file);
  }
   @override
  Stream<List<Map<String, dynamic>>> getVideos() {
    return mediaService.getVideos();
  }
  @override
  Stream<List<Map<String, dynamic>>> getArticles() {
    return mediaService.getArticles();
  }
}
