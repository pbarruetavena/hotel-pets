import 'dart:convert';
import 'package:http/http.dart' as http;
import './services/api.dart';

class EstadiaController {
  final Api api = Api();
  List<Map<String, dynamic>> estadias = [];

  Future<void> createEstadia(Map<String, dynamic> estadia) async {
    try {
      final response = await api.postRequest("estadia", estadia);
      if (response.statusCode != 201) {
        throw Exception("Estadia não pode ser criada");
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Não foi possível conectar');
      }
    }
  }

  Future<void> getEstadias() async {
    try {
      final response = await api.getRequest("estadia");
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        estadias = data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Erro ao buscar estadias');
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Não foi possível conectar');
      }
    }
  }

  Future<void> updateEstadia(int id, Map<String, dynamic> estadia) async {
    try {
      final response = await api.putRequest("estadia/$id", estadia);
      if (response.statusCode != 200) {
        throw Exception('Erro ao atualizar');
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Não foi possível conectar');
      }
    }
  }

  Future<void> deleteEstadias(int id) async {
    try {
      final response = await api.deleteRequest("estadia/$id");
      if (response.statusCode != 200) {
        throw Exception("Estadia não pode ser apagada");
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Não foi possível conectar');
      }
    }
  }
}
