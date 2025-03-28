import 'dart:convert';
import 'package:http/http.dart' as http;

import './services/api.dart';

class TutorController {
  final Api api = Api();
  List<Map<String, dynamic>> tutores = [];

  Future<void> createTutor(Map<String, dynamic> tutor) async {
    try {
      final response = await api.postRequest("tutor", tutor);

      print("chegou a resposta");
      if (response.statusCode == 403) {
        throw Exception("Insira um email válido");
      }
      if (response.statusCode != 201) {
        throw Exception("Erro ao criar o tutor");
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Não foi possível conectar');
      } else {
        rethrow;
      }
    }
  }

  Future<void> getTutores() async {
    try {
      final response = await api.getRequest("tutor");

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        tutores = data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Erro ao buscar tutores');
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Não foi possível conectar');
      } else {
        rethrow;
      }
    }
  }

  Future<void> updateTutor(int id, Map<String, dynamic> tutor) async {
    try {
      final response = await api.putRequest("tutor/${id}", tutor);
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('erro ao salvar o tutor');
        throw Error();
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Não foi possível conectar');
      } else {
        rethrow;
      }
    }
  }

  Future<void> deleteTutor(int id) async {
    try {
      final response = await api.deleteRequest("tutor/${id}");
      if (response.statusCode == 409) {
        print("asfasfasdkfadsfjasjfnadsjfhasjdf");
        throw Exception(
            "Não foi possível apagar o tutor. Tente apagar todos os animais dependentes.");
      }
      if (response.statusCode != 200) {
        print('erro ao deletar');
        throw Error();
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Não foi possível conectar');
      } else {
        rethrow;
      }
    }
  }
}
