import 'package:flutter/material.dart';
import 'package:practicas_pre_profesionales_flutter/test/screens/principales/chart.dart';
import 'package:practicas_pre_profesionales_flutter/test/screens/principales/documentos.dart';
import 'package:practicas_pre_profesionales_flutter/test/screens/principales/viewPdf.dart';

class CustomDrawer extends StatefulWidget implements PreferredSizeWidget {
  CustomDrawer({Key? key})
      : preferredSize = Size.fromHeight(5.0),
        super(key: key);
final Size preferredSize;
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>{
  _CustomDrawerState();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Jhobany Ticona', style: (TextStyle(fontSize: 17)),),
              accountEmail: Text('Jhobany@gmail.com', style: (TextStyle(fontSize: 15)),),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://media-exp1.licdn.com/dms/image/C4D03AQFQ4EsbEQOP9g/profile-displayphoto-shrink_200_200/0/1650294861122?e=1675900800&v=beta&t=WNC7VAtLDtJlf-dTeayN6zYP3EAQQsUBkSVmVwsNpIo',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover
                  ),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                  'https://cloudraya.com/blog/wp-content/uploads/2021/10/Blog-Oct-3-1.jpg',
                ),
                fit: BoxFit.cover
                )
              ),
              ),
            /*DrawerHeader(
              child: Text('LOGO'),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 75, 105),
              ),
            ),*/
            ListTile(
              leading: Icon(Icons.telegram),
              title: Text("Información", style: (TextStyle(fontSize: 17)),),
               onTap: () => {Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => DocumentsCopyPage()),
               )},
            ),
            ListTile(
              leading: Icon(Icons.accessibility_new_outlined),
              title: Text('Administrador', style: (TextStyle(fontSize: 17)),),
              onTap: () => {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewPdf()),
              )},
              
            ),
            ListTile(
              leading: Icon(Icons.pie_chart),
              title: Text('Graficos', style: (TextStyle(fontSize: 17)),),
              onTap: () => {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChartPage()),
              )},
              
            ),
            Container(     
              margin: const EdgeInsets.only(top: 310, bottom: 12, left: 12, right: 12),
              width: double.infinity,
              color: Color.fromARGB(255, 0, 7, 109),
              child: ListTile(
                title: Text('Cerrar Sesión', textAlign: TextAlign.center, style: (TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255))),),
                onTap: () => debugPrint("Funcion Salir"),
            ),
            ),
          ],
        ),
        
      );
      
  }
}