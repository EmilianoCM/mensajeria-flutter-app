import 'package:chat_app/pages/chat_pages.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/registro_page.dart';
import 'package:chat_app/pages/usuarios_pages.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRutas = {
  'usuarios': (_) => const UsuariosPage(),
  'chat': (_) => const ChatPage(),
  'login': (_) => const LoginPage(),
  'registro': (_) => const RegistroPage(),
  'loading': (_) => const LoadingPage(),
};
