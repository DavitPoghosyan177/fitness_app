import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/repositories/media_repository.dart';
import 'package:flutter/material.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc(this._mediaRepository) : super(MediaInitial()) {
    on<UploadPictureFromCameraEvent>(_mapOnUploadPictureFromCameraEventToState);
    on<UploadPictureFromGalleryEvent>(
        _mapOnUploadPictureFromGalleryEventToState);
    on<UploadProfilePhotoEvent>(_mapUploadProfilePhotoEventToState);
    on<LoadVideosEvent>(_mapOnUploadVideosEventToState);
    on<LoadArticlesEvent>(_mapOnLoadArticlesEventToState); 
  }
  final MediaRepository _mediaRepository;

  FutureOr<void> _mapOnUploadPictureFromCameraEventToState(
      UploadPictureFromCameraEvent event, Emitter<MediaState> emit) async {
    try {
      emit(MediaLoading());
      final FileImage? fileImage = await _mediaRepository.uploadFromCamera();
      emit(MediaLoaded(fileImage: fileImage));
    } catch (e) {
      emit(MediaFailed(error: e.toString()));
    }
  }

  FutureOr<void> _mapOnUploadPictureFromGalleryEventToState(
      UploadPictureFromGalleryEvent event, Emitter<MediaState> emit) async {
    try {
      emit(MediaLoading());
      final FileImage? fileImage = await _mediaRepository.uploadPicture();
      emit(MediaLoaded(fileImage: fileImage));
    } catch (e) {
      emit(MediaFailed(error: e.toString()));
    }
  }

  FutureOr<void> _mapUploadProfilePhotoEventToState(
      UploadProfilePhotoEvent event, Emitter<MediaState> emit) async {
    try {
      emit(MediaLoading());
      await _mediaRepository.uploadProfilePicture(event.userId, event.file);
      emit(const MediaUpdated());
    } catch (e) {
      emit(MediaFailed(error: e.toString()));
    }
  }
 FutureOr<void> _mapOnUploadVideosEventToState(
    LoadVideosEvent event, Emitter<MediaState> emit) async {
  try {
    emit(VideoLoadingState(state));

    await for (final videos in _mediaRepository.getVideos()) {
      emit(VideoLoadedState(state, videos));
    }
  } catch (e) {
    emit(VideoErrorState(e.toString()));
  }
}
 Future<void> _mapOnLoadArticlesEventToState(
      LoadArticlesEvent event, Emitter<MediaState> emit) async {
    try {
      emit(ArticleLoadingState(state));
      await for (final articles in _mediaRepository.getArticles()) {
        emit(ArticleLoadedState(state, articles));
      }
    } catch (e) {
      emit(ArticleErrorState(e.toString()));
    }
  }
}
