import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dand_names/models/models.dart';
import 'package:dand_names/services/services.dart';


class HomeScreen extends StatefulWidget {

  static const String routeName = 'Home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    List<Banda> bandas = [
      Banda(id: '1', name: 'Metalica', votos: 3),
      Banda(id: '2', name: 'Opera', votos: 4),
      Banda(id: '3', name: 'Pop', votos: 2),
    ];


     @override
    void initState() {
      final socketServises = Provider.of<SocketService>(context,listen: false);
      socketServises.socket.on('active-bands', (payload) {
        print(payload);
      });

      super.initState();
      
    }

  @override
  Widget build(BuildContext context) {

    final socketServises = Provider.of<SocketService>(context);

    return Scaffold(
    appBar: AppBar(
      title: const Text('Bandas',style: TextStyle(color: Colors.black87),),
      backgroundColor: Colors.white,
      elevation: 1,
      actions: [
        Container(
          margin: const  EdgeInsets.only(right: 10),
          child: socketServises.serverStatus == ServerStatus.Online
          ?Icon(Icons.check_circle, color: Colors.blue[300],)
          :Icon(Icons.offline_bolt, color: Colors.red[300],),
        )
      ],
    ),
    body: ListView.builder(
      itemCount: bandas.length,
      itemBuilder: (contes, i) => _bandasTile(bandas[i])
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add, color: Colors.black,),
        elevation: 1,
        onPressed: addNewBanda
        ),
   );
  }

  Widget _bandasTile(Banda banda) {
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Eliminar Banda', style: TextStyle(color: Colors.white),),
        ),
      ),
      child: ListTile(
          leading: CircleAvatar(
            child: Text(banda.name.substring(0,2)),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(banda.name, style: const TextStyle(fontSize: 20, color: Colors.black),),
          trailing: Text('${banda.votos}', style: const TextStyle(fontSize: 20),),
          onTap: () => print(banda.name),
    
        ),
    );
  }


  addNewBanda(){

    final textController = new TextEditingController();
    if(Platform.isAndroid){
        showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:   const Text('Nueva Banda: '),
            content: TextField(
            controller: textController,
            ),
            actions: [
              MaterialButton(
                child: Text('Agregar'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: ()=> addBandaToList(textController.text))
            ],

          );
        }
        );
      }else{
          showCupertinoDialog(
            context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: const Text('Nueva Banda'),
                content: CupertinoTextField(
                controller: textController,
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text('Agregar'),
                  isDefaultAction: true,
                  onPressed: ()=> addBandaToList(textController.text))
              ],
            );
          }
          );

      }

    }

       



  void addBandaToList (String name){
    print(name);

    if(name.length >1){
      //guardar
      this.bandas.add(new Banda(id: DateTime.now().toString(), name: name,votos: 0));
      setState(() {
      });
    }

    Navigator.pop(context);

  }
}