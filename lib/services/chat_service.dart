import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat/services/auth_service.dart';

import 'package:chat/global/environment.dart';

import 'package:chat/models/usuario.dart';
import 'package:chat/models/mensajes_response.dart';

class ChatService with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioId) async {
    print('El id del usuario es $usuarioId');
    final resp = await http.get('${Environment.apiUrl}/mensajes/$usuarioId',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        });

    final mensajesResponse = mensajesResponseFromJson(resp.body);

    return mensajesResponse.mensajes;
  }
}
