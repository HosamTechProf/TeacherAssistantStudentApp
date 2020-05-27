import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/views/chat/chat_screen.dart';
import 'package:student_app/views/home/home.dart';
import 'package:student_app/views/login/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = false;
  final prefs = await SharedPreferences.getInstance();
  if(prefs.get('token') != null){
    isLoggedIn = true;
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Poppins'),
    debugShowCheckedModeBanner: false,
    title: 'Teacher Assistnat',
    home: isLoggedIn ? HomePage() : LoginPage(),
    routes: <String, WidgetBuilder>{
      '/login': (BuildContext context) => LoginPage(),
      '/home': (BuildContext context) => HomePage(),
      '/chat': (BuildContext context) => ChatScreen(),
    },
  ));
}
