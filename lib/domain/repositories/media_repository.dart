import 'dart:io';

import 'package:flutter/material.dart';

abstract class MediaRepository {
  Future<FileImage?> uploadPicture();
  Future<FileImage?> uploadFromCamera();
  Future<void> uploadProfilePicture(String userId, File file);

}
