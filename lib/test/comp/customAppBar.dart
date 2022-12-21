import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);
final Size preferredSize;
  @override
 // _CustomAppBarState createState() => _CustomAppBarState();
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{
  _CustomAppBarState();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 0, 9, 136),
        title: Image.network('https://s3.amazonaws.com/files.patmos.upeu.edu.pe/img/logos/logo-upeu-blanco.png', fit: BoxFit.cover),
        actions: <Widget>[
          //IconButton(icon: Icon(Icons.search),onPressed: ()=>debugPrint("Buscar algo especifico"),),
          //IconButton(icon: Icon(Icons.add_box),onPressed: ()=>debugPrint("Agregar"),),
          IconButton(icon: Icon(Icons.notifications),onPressed: ()=>debugPrint("mostrar notificación"),),
        ],
    );
  }
}