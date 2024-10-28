part of 'media_bloc.dart';

sealed class MediaState extends Equatable {
  const MediaState();

  @override
  List<Object?> get props => [];
}

final class MediaInitial extends MediaState {}

final class MediaLoading extends MediaState {}

final class MediaFailed extends MediaState {
  final String error;

  const MediaFailed({required this.error});

  @override
  List<Object> get props => [error];
}

final class MediaLoaded extends MediaState {
  final FileImage? fileImage;

  const MediaLoaded({required this.fileImage});

  @override
  List<Object?> get props => [fileImage];
}

final class MediaUpdated extends MediaState {
  const MediaUpdated();

  @override
  List<Object?> get props => [];
}
