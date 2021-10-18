import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_app/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(
        online: true, email: 'test1@test.com', nombre: 'Emiliano', uid: '1'),
    Usuario(online: false, email: 'test2@test.com', nombre: 'Nahuel', uid: '2'),
    Usuario(online: true, email: 'test3@test.com', nombre: 'Martina', uid: '3'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.black54),
            onPressed: () {},
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue[400],
              ),
              // child : Icon(
              //   Icons.offline_bolt,
              //   color: Colors.red,
              // ),
            )
          ],
          title: Text(
            'NombreUsuario',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.blue[400]),
            waterDropColor: Colors.blue[400]!,
          ),
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: usuarios.length,
      itemBuilder: (_, int index) => _usuarioListTile(usuarios[index]),
      separatorBuilder: (_, int index) => Divider(),
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
