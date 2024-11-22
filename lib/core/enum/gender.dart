enum Gender {
  female,
  male,
  unspecified;

  factory Gender.fromString(String gender) {
    return Gender.values.firstWhere(
      (element) => element.name == gender,
      orElse: () => Gender.unspecified,
    );
  }
}
