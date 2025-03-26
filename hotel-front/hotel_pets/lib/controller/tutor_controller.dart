import 'dart:convert';
import 'package:http/http.dart';

import './services/api.dart';

class TutorController {
  final Api api = Api();
  List<Map<String, dynamic>> tutores = [];

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

  Future<void> getTutores() async {
    final response = await api.getRequest("tutor");

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      tutores = data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Erro ao buscar tutores');
    }
  }

  Future<void> updateTutor(int id, Map<String, dynamic> tutor) async {
    final response = await api.putRequest("tutor/${id}", tutor);
    if (response.statusCode != 200 && response.statusCode != 201) {
      print('erro ao salvar o tutor');
      throw Error();
    }
  }

  Future<void> deleteTutor(int id) async {
    final response = await api.deleteRequest("tutor/${id}");
    if (response.statusCode != 200) {
      print('erro ao deletar');
      throw Error();
    }
  }
}
