import 'package:chat_app/global/enviroments.dart';
import 'package:chat_app/models/mensajes_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/models/usuario.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final uri = Uri.parse(
      '${Enviroment.apiUrl}/mensajes/$usuarioID',
    );
    String? token = await AuthService.getToken();
    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': token.toString()
    });

    final mensajeResp = mensajeResponseFromJson(resp.body);

    return mensajeResp.mensajes;
  }
}
