part of 'media_bloc.dart';

sealed class MediaState extends Equatable {
  const MediaState({this.articles = const [], this.videos = const [],});

  final List<Map<String, dynamic>> articles;
  final List<Map<String, dynamic>> videos;

  @override
  List<Object?> get props => [articles, videos];
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
class VideoLoadingState extends MediaState {
    VideoLoadingState(MediaState initState): super(videos: initState.videos, articles: initState.articles);

}

class VideoLoadedState extends MediaState {

  VideoLoadedState(MediaState initState, List<Map<String, dynamic>> videos): super(videos: videos, articles: initState.articles);

  @override
  List<Object> get props => [videos];
}

class VideoErrorState extends MediaState {
  final String error;

  const VideoErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class ArticleLoadingState extends MediaState {
    ArticleLoadingState(MediaState initState): super(articles: initState.articles, videos: initState.videos);

}

class ArticleLoadedState extends MediaState {

  ArticleLoadedState(MediaState initState, List<Map<String, dynamic>> articles): super(articles: articles, videos: initState.videos);
}

class ArticleErrorState extends MediaState {
  final String error;

  const ArticleErrorState(this.error);
}
