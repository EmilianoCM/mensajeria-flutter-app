import 'dart:io';

import 'package:chat_app/widgets/chat_mensajes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  List<ChatMensaje> _mensajes = [];

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                child: Text(
                  'Te',
                  style: const TextStyle(fontSize: 12),
                ),
                backgroundColor: Colors.blue[100],
                maxRadius: 14,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                'Emiliano Caceres',
                style: const TextStyle(color: Colors.black87, fontSize: 12),
              )
            ],
          ),
          centerTitle: true,
          elevation: 1,
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _mensajes.length,
                itemBuilder: (_, int i) => _mensajes[i],
                reverse: true,
              )),
              const Divider(
                height: 1,
              ),
              Container(
                color: Colors.white,
                child: _inputChat(),
              )
            ],
          ),
        ));
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (String texto) {
              setState(() {
                if (texto.trim().isEmpty) {
                  _estaEscribiendo = true;
                } else {
                  _estaEscribiendo = false;
                }
              });
            },
            decoration:
                const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
            focusNode: _focusNode,
          )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                    child: const Text('Enviar'),
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: _estaEscribiendo
                            ? () => _handleSubmit(_textController.text.trim())
                            : null,
                        icon: const Icon(
                          Icons.send,
                        ),
                      ),
                    )),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    if (texto.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus();

    final nuevoMensaje = ChatMensaje(
        texto: texto,
        uid: '123',
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 200)));
    _mensajes.insert(0, nuevoMensaje);
    nuevoMensaje.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    //TODO:OFF del socket

    for (ChatMensaje mensaje in _mensajes) {
      mensaje.animationController.dispose();
    }
    super.dispose();
  }
}
