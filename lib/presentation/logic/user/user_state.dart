part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState(
      {this.email,
      this.displayName,
      this.userEntity,
      this.error,
      this.users,
      this.photoUrl,
      this.posts,
      this.name,
      this.fullname});

  final UserEntity? userEntity;
  final String? error;
  final String? fullname;
  final String? email;
  final String? name;
  final String? displayName;
  final String? photoUrl;
  final List<UserEntity>? users;
  final List<Map<String, dynamic>>? posts;

  @override
  List<Object?> get props => [
        error,
        userEntity,
        email,
        displayName,
        photoUrl,
        posts,
        users,
        name,
        fullname
      ];
}

final class UserInitial extends UserState {}

final class UserFailed extends UserState {
  UserFailed(UserState initialState, String error)
      : super(userEntity: initialState.userEntity, error: error);
}

final class UserLoading extends UserState {
  UserLoading(UserState initialState)
      : super(userEntity: initialState.userEntity);
}

final class UserLoaded extends UserState {
  const UserLoaded(UserEntity? model) : super(userEntity: model);
}

final class UserModelState extends UserState {
  const UserModelState(UserEntity model) : super(userEntity: model);
}

class UserDataUpdated extends UserState {
  UserDataUpdated(UserState initState,
      {UserEntity? userEntity, String? email, String? fullname})
      : super(
          userEntity: userEntity ?? initState.userEntity,
          email: email ?? initState.email,
          fullname: fullname ?? initState.fullname,
        );
}

class MediaLoadSuccess extends UserState {
  const MediaLoadSuccess(List<Map<String, dynamic>> posts)
      : super(posts: posts);
}

final class UserStateSignedOut extends UserState {}

final class DeleteUserFromDBLoaded extends UserState {
  final String userId;
  const DeleteUserFromDBLoaded(this.userId);
}
