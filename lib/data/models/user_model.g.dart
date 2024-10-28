// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      fullname: json['fullname'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      age: json['age'] as String?,
      weight: json['weight'] as String?,
      height: json['height'] as String?,
      goal: json['goal'] as String?,
      activity: json['activity'] as String?,
      nickName: json['nickName'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{
    'userId': instance.userId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  writeNotNull('displayName', instance.displayName);
  writeNotNull('photoUrl', instance.photoUrl);
  writeNotNull('fullname', instance.fullname);
  writeNotNull('gender', _$GenderEnumMap[instance.gender]);
  writeNotNull('age', instance.age);
  writeNotNull('weight', instance.weight);
  writeNotNull('height', instance.height);
  writeNotNull('goal', instance.goal);
  writeNotNull('activity', instance.activity);
  writeNotNull('nickName', instance.nickName);
  writeNotNull('mobileNumber', instance.mobileNumber);
  return val;
}

const _$GenderEnumMap = {
  Gender.female: 'female',
  Gender.male: 'male',
  Gender.unspecified: 'unspecified',
};
