import 'dart:convert';
import 'package:http/http.dart';
import './services/api.dart';

class AnimalController {
  final Api api = Api();
  List<Map<String, dynamic>> animais = [];

  Future<void> createAnimal(Map<String, dynamic> animal) async {
    final response = await api.postRequest("animal", animal);
    if (response.statusCode != 201) {
      throw Error();
    }
  }

  Future<void> getAnimais() async {
    final response = await api.getRequest("animal");
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      animais = data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Erro ao buscar animais');
    }
  }

  Future<void> updateAnimais(int id, Map<String, dynamic> animal) async {
    final response = await api.putRequest("animal/${id}", animal);
    if (response.statusCode != 200) {
      throw Error();
    }
  }

  Future<void> deleteAnimais(int id) async {
    final response = await api.deleteRequest("animal/${id}");
    if (response.statusCode != 200) {
      throw Error();
    }
  }
}
