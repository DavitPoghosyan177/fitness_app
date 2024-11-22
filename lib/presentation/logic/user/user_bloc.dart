import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/core/enum/gender.dart';
import 'package:fitness_app/domain/entites/user_entity.dart';
import 'package:fitness_app/domain/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.userRepositories) : super(UserInitial()) {
    on<AddUserToDbEvent>(_mapAddUserToDbEventToState);
    on<AddUserModelEvent>(_mapAddUserModelEventToState);
    on<UpdateUserDataEvent>(_mapUpdateUserDataEventToState);
    on<SubmitUserEvent>(_mapSubmitUserEventToState);
    on<SignOutEvent>(_mapSignOutEventToState);
    on<GetUserByIdEvent>(_mapGetUserByIdEventToState);
    on<DeleteUserFromDbEvent>(_mapDeleteUserFromDbEventToState);
    on<UpdateNameEvent>(_mapUpdateNameEventToState);
    on<UpdateEmailEvent>(_mapUpdateEmailEventToState);
    on<UpdateGenderEvent>(_mapUpdateGenderEventToState);
    on<UpdateAgeEvent>(_mapUpdateAgeEventToState);
    on<UpdateWeightEvent>(_mapUpdateWeightEventToState);
    on<UpdateHeightEvent>(_mapUpdateHeightEventToState);
    on<UpdateGoalEvent>(_mapUpdateGoalEventToState);
    on<UpdateActivityEvent>(_mapUpdateActivityEventToState);
    on<UpdateNickNameEvent>(_mapUpdateNickNameEventToState);
    on<UpdateMobileNumberEvent>(_mapUpdateMobileNumberEventToState);
  }

  final UserRepository userRepositories;

  FutureOr<void> _mapAddUserToDbEventToState(
      AddUserToDbEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading(state));
      final bool exists =
          await userRepositories.isUserExist(event.userEntity.userId ?? "");
      if (exists == false) {
        await userRepositories.saveUserToDB(event.userEntity);
      }
      final UserEntity userEntity =
          await userRepositories.getUserById(event.userEntity.userId ?? '');
      emit(UserLoaded(userEntity));
    } catch (e) {
      emit(UserFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapUpdateNameEventToState(
      UpdateNameEvent event, Emitter<UserState> emit) {
    emit(UserDataUpdated(state, fullname: event.fullname));
  }

  FutureOr<void> _mapUpdateEmailEventToState(
      UpdateEmailEvent event, Emitter<UserState> emit) {
    emit(UserDataUpdated(state, email: event.email));
  }

  FutureOr<void> _mapUpdateGenderEventToState(
      UpdateGenderEvent event, Emitter<UserState> emit) {
    emit(UserDataUpdated(state, gender: event.gender));
  }

  FutureOr<void> _mapUpdateAgeEventToState(
      UpdateAgeEvent event, Emitter<UserState> emit) {
    emit(UserDataUpdated(state, age: event.age));
  }

  FutureOr<void> _mapUpdateWeightEventToState(
      UpdateWeightEvent event, Emitter<UserState> emit) {
    emit(UserDataUpdated(state, weight: event.weight));
  }

  FutureOr<void> _mapUpdateHeightEventToState(
      UpdateHeightEvent event, Emitter<UserState> emit) {
    emit(UserDataUpdated(state, height: event.height));
  }

  FutureOr<void> _mapUpdateGoalEventToState(
      UpdateGoalEvent event, Emitter<UserState> emit) {
    emit(UserDataUpdated(state, goal: event.goal));
  }

  FutureOr<void> _mapUpdateActivityEventToState(
      UpdateActivityEvent event, Emitter<UserState> emit) {
    emit(UserDataUpdated(state, activity: event.activity));
  }

  FutureOr<void> _mapUpdateNickNameEventToState(
      UpdateNickNameEvent event, Emitter<UserState> emit) {
    emit(UserDataUpdated(state, nickName: event.nickName));
  }

  FutureOr<void> _mapUpdateMobileNumberEventToState(
      UpdateMobileNumberEvent event, Emitter<UserState> emit) {
    emit(UserDataUpdated(state, mobileNumber: event.mobileNumber));
  }

  FutureOr<void> _mapAddUserModelEventToState(
      AddUserModelEvent event, Emitter<UserState> emit) {
    emit(UserLoaded(event.userEntity));
  }

  FutureOr<void> _mapSubmitUserEventToState(
      SubmitUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading(state));
      await userRepositories.saveUserToDB(event.userEntity);
      emit(UserLoaded(event.userEntity));
    } catch (e) {
      emit(UserFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapUpdateUserDataEventToState(
      UpdateUserDataEvent event, Emitter<UserState> emit) async {
    await userRepositories.updateUserData(event.userEntity);
    final UserEntity userEntity =
        await userRepositories.getUserById(event.userEntity.userId ?? "");
    emit(UserDataUpdated(state, userEntity: userEntity));
  }

  FutureOr<void> _mapSignOutEventToState(
      SignOutEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading(state));
      await userRepositories.signOut();
      emit(UserStateSignedOut());
    } on FirebaseAuthException catch (error) {
      emit(UserFailed(state, error.toString()));
    }
  }

  FutureOr<void> _mapGetUserByIdEventToState(
      GetUserByIdEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading(state));
      final UserEntity userEntity =
          await userRepositories.getUserById(event.userId);
      emit(UserLoaded(userEntity));
    } catch (e) {
      emit(UserFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapDeleteUserFromDbEventToState(
      DeleteUserFromDbEvent event, Emitter<UserState> emit) async {
    try {
      final userModelById = UserEntity(userId: event.userId);
      await userRepositories.deleteUser(userModelById.userId!);
    } on FirebaseAuthException catch (error) {
      emit(UserFailed(state, error.toString()));
    }
  }
}
