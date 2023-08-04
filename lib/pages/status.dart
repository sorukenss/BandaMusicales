import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dand_names/services/services.dart';

class StatusScreen extends StatelessWidget {

  static const String routeName='Status';

  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final sokecService = Provider.of<SocketService>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Estado de Coneccion :${sokecService.serverStatus}')
          ],
        ),
     ),
     floatingActionButton: FloatingActionButton(
      child: Icon(Icons.message),
      onPressed: (){
        sokecService.socket.emit('Emitir-Mensaje',{'nombre': 'flutter','mensaje' :'hola desde flutter'});
     }),
   );
  }
}