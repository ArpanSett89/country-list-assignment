import 'package:flutter/material.dart';
import 'booklist.dart';
import 'history.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    return MaterialApp(
      home: MBNB(),
    );
  }
}
class MBNB extends StatefulWidget {
  const MBNB({Key? key}) : super(key: key);

  @override
  State<MBNB> createState() => _MBNBState();
}

final List<String> title = <String>['HOME', 'COUNTRY LIST', 'HISTORY'];
final List<Widget> TapFunction = <Widget>[
  MyHomePage(),
  BookList(),
  History()
];
class _MBNBState extends State<MBNB> {
  int  _selectedIndex=0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title[_selectedIndex],
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      extendBody: true,
      body: TapFunction.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list_outlined), label: 'Country List'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
          child: ListView(
            children:  [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black26,
                ),
                child: Text(
                  'Drawer',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.home,color: Colors.blue,),
                      title: Text(
                        title[index],
                        style: const TextStyle(fontSize: 10, color: Colors.black),
                      ),
                      onTap: (){_onItemTapped(index);
                      Navigator.pop(context);
                      }
                    );
                  }),
            ],
          )),
    );
  }
}

