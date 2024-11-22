part of 'media_bloc.dart';

sealed class MediaEvent extends Equatable {
  const MediaEvent();

  @override
  List<Object> get props => [];
}

class UploadPictureFromGalleryEvent extends MediaEvent {}

class UploadPictureFromCameraEvent extends MediaEvent {}

class UploadProfilePhotoEvent extends MediaEvent {
  const UploadProfilePhotoEvent(this.userId, this.file);
  final String userId;
  final File file;
}
class LoadVideosEvent extends MediaEvent {}

class LoadArticlesEvent extends MediaEvent {}  