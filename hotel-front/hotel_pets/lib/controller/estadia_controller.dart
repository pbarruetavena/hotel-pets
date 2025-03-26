import 'dart:convert';
import 'package:http/http.dart';
import './services/api.dart';

class EstadiaController {
  final Api api = Api();
  List<Map<String, dynamic>> estadias = [];

  Future<void> createEstadia(Map<String, dynamic> estadia) async {
    final response = await api.postRequest("estadia", estadia);
    if (response.statusCode != 201) {
      throw Exception("Estadia não pode ser criada");
    }
  }

  Future<void> getEstadias() async {
    final response = await api.getRequest("estadia");
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      estadias = data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Erro ao buscar estadias');
    }
  }

  Future<void> deleteEstadias(int id) async {
    final response = await api.deleteRequest("estadia/$id");
    if (response.statusCode != 200) {
      throw Exception("Estadia não pode ser apagada");
    }
  }
}
