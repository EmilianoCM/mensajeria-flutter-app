import 'package:chat_app/helpers/mostrar_alerta_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/boton_azul_widget.dart';
import 'package:chat_app/widgets/custom_input_widget.dart';
import 'package:chat_app/widgets/labels_widget.dart';
import 'package:chat_app/widgets/logo_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Logo(
                    title: 'Messenger',
                  ),
                  _Formulario(),
                  Labels(
                    textOne: 'No Tienes Cuenta?',
                    textTwo: 'Crea una ahora!',
                    ruta: 'registro',
                  ),
                  Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Formulario extends StatefulWidget {
  const _Formulario({Key? key}) : super(key: key);

  @override
  __FormularioState createState() => __FormularioState();
}

class __FormularioState extends State<_Formulario> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Password',
            isPassword: true,
            // keyboardType: TextInputType.,
            textController: passController,
          ),
          BotonAzul(
              text: 'Ingrese',
              onPressed: authService.autenticando
                  ? () {}
                  : () async {
                      //Si el listen no esta en false, se redibuja el widget
                      // final authService =
                      //     Provider.of<AuthService>(context, listen: false);

                      //Para desaparecer el foco desde el context
                      FocusScope.of(context).unfocus();

                      final loginOk = await authService.login(
                          emailController.text.trim(),
                          passController.text.trim());

                      if (loginOk) {
                        //TODO: CONECTAR AL SOCKET
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        mostrarAlerta(context, 'Login Incorrecto',
                            'Revisar las credenciales nuevamente');
                      }
                    })
        ],
      ),
    );
  }
}
