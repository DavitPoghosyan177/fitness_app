part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class AddUserToDbEvent extends UserEvent {
  const AddUserToDbEvent(this.userEntity);
  final UserEntity userEntity;
}

class UpdateNameEvent extends UserEvent {
  const UpdateNameEvent(this.fullname);
  final String fullname;
}

class AddUserModelEvent extends UserEvent {
  const AddUserModelEvent(this.userEntity);
  final UserEntity userEntity;
}

class UpdateEmailEvent extends UserEvent {
  const UpdateEmailEvent(this.email);
  final String email;
}

class UpdateUserDataEvent extends UserEvent {
  const UpdateUserDataEvent(this.userEntity);
  final UserEntity userEntity;
}

class SubmitUserEvent extends UserEvent {
  const SubmitUserEvent(this.userEntity);
  final UserEntity userEntity;
}

class SignOutEvent extends UserEvent {
  const SignOutEvent();
}

class GetUserByIdEvent extends UserEvent {
  final String userId;
  const GetUserByIdEvent({required this.userId});
}

class DeleteUserFromDbEvent extends UserEvent {
  const DeleteUserFromDbEvent(this.userId);
  final String userId;
}

class GetMessagesEvent extends UserEvent {
  const GetMessagesEvent();
}

class ListenUserEvent extends UserEvent {
  final String userId;

  const ListenUserEvent({required this.userId});
}
