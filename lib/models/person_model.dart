class PersonModel {
  PersonModel({
    this.height,
    this.weight,
    this.gender,
    this.age,
    this.result,
  });

  double? height;
  double? weight;
  Gender? gender;
  int? age;
  double? result;
}

enum Gender { male, female }
