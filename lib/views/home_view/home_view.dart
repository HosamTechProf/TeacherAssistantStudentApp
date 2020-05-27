import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:student_app/providers/student.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  Student student = new Student();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HOME PAGE',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.6,
                  color: Colors.black54),
            ),
            Text(
              'Student App'.toUpperCase(),
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6),
            ),
            SizedBox(height: 15,),
            Text(
              'Your Classes'.toUpperCase(),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                  color: Colors.black),
            ),
            FutureBuilder(
              future: student.getClasses(),
              builder: (context, snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator(),);
                  default:
                    if (snapshot.hasError) {
                      return new Text(
                          'Error: ${snapshot.error}');
                    } else {
                      List myData = snapshot.data;
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: myData.length,
                          itemBuilder: (context, i){
                            return Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: InkWell(
                                onTap: ()=> Navigator.pushNamed(context, "/chat", arguments: {"myClassData":myData[i]}),
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 14, left: 0, right: 0, bottom: 20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color:
                                                Colors.black12.withOpacity(0.3),
                                                offset: const Offset(1.1, 4.0),
                                                blurRadius: 8.0),
                                          ],
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.green,
                                              Color(0xFF7fcd91),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(8.0),
                                            bottomLeft: Radius.circular(8.0),
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              left: 16,
                                              right: 16,
                                              bottom: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(Ionicons.ios_chatbubbles,color: Colors.white,),
                                              SizedBox(height: 3,),
                                              Text(
                                                myData[i]['name'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  letterSpacing: 0.2,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

