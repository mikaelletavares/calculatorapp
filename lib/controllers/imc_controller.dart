import 'package:calculatorapp/models/person_model.dart';

class ImcController {
  PersonModel calculateImc(double height, double weight) {
    double result = weight / (height * height);
    return PersonModel(height: height, weight: weight, result: result);
  }
}
