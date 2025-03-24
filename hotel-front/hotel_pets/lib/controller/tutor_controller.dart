import 'dart:convert';
import './services/api.dart';

class TutorController {
  final Api api = Api();

  Future<void> createTutor(Map<String, dynamic> tutor) async {
    final response = await api.postRequest("tutor", tutor);

    print("chegou a resposta");
    //print(response.body);
    //print(response.statusCode);
    if (response.statusCode != 201) {
      print('erro ao criar o tutor');
      throw Error();
    }
  }
}
