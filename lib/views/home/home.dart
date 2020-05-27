import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:student_app/views/home_view/home_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List pages = [
    HomeView(),
    HomeView(),
  ];

  int _page = 0;

  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        buttonBackgroundColor: Color(0xFF7fcd91),
        animationDuration: Duration(milliseconds: 380),
        backgroundColor: Colors.grey[200],
        items: <Widget>[
          Icon(Icons.home, size: 34,color: _page == 0 ? Colors.white : Color(0xFF7fcd91),),
          Icon(Icons.supervised_user_circle, size: 34,color: _page == 1 ? Colors.white : Color(0xFF7fcd91),),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: pages[_page]
    );
  }
}
