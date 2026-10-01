import'package:flutter/material.dart';
import'pages/home_page.dart';
import'pages/profile_page.dart';

class Root extends StatefulWidget{

    const Root({super.key});
    @override
    State<Root> createState()=> _RootState();
}

//Membuat tombol navigator
class _RootState extends State<Root>{
    int _selectedIndex = 0;

    @override
    Widget build(BuildContext context){
        final List<Widget> pages = [
            HomePage(),
            ProfilePage(),
        ];
        return Scaffold(
            body: pages[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: (index) {
                    setState((){
                        _selectedIndex = index;
                    }
                    );
                },
                items: [
                    BottomNavigationBarItem(icon: Icon(Icons.store), label:'Beranda'),
                    BottomNavigationBarItem(icon: Icon(Icons.person), label:'Profil'),
                ],
            ),
        );
    }
}