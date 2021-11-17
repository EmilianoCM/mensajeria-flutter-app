import 'dart:convert';

import 'package:chat_app/models/usuario.dart';

LoginRespuesta loginRespuestaFromJson(String str) =>
    LoginRespuesta.fromJson(json.decode(str));

String loginRespuestaToJson(LoginRespuesta data) => json.encode(data.toJson());

class LoginRespuesta {
  LoginRespuesta({
    required this.ok,
    required this.usuario,
    required this.token,
  });

  bool ok;
  Usuario usuario;
  String token;

  factory LoginRespuesta.fromJson(Map<String, dynamic> json) => LoginRespuesta(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
      };
}
