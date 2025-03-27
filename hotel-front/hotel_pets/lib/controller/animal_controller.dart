import 'dart:convert';
import 'package:http/http.dart' as http;
import './services/api.dart';

class AnimalController {
  final Api api = Api();
  List<Map<String, dynamic>> animais = [];

  Future<void> createAnimal(Map<String, dynamic> animal) async {
    try {
      final response = await api.postRequest("animal", animal);
      if (response.statusCode != 201) {
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

  Future<void> getAnimais() async {
    try {
      final response = await api.getRequest("animal");
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        animais = data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Erro ao buscar animais');
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Não foi possível conectar');
      } else {
        rethrow;
      }
    }
  }

  Future<void> updateAnimais(int id, Map<String, dynamic> animal) async {
    try {
      final response = await api.putRequest("animal/$id", animal);
      if (response.statusCode != 200) {
        throw Exception('Erro ao atualizar o animal');
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Não foi possível conectar');
      } else {
        rethrow;
      }
    }
  }

  Future<void> deleteAnimais(int id) async {
    try {
      final response = await api.deleteRequest("animal/$id");
      if (response.statusCode == 409) {
        throw Exception(jsonDecode(response.body)['message']);
      }
      if (response.statusCode != 200) {
        throw Exception('Erro ao deletar o animal');
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
