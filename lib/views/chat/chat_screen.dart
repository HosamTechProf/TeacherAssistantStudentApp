import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:student_app/providers/auth.dart';
import 'package:student_app/providers/chat.dart';
import 'package:student_app/views/chat/widgets/widgets.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _scrollController = new ScrollController();

  bool _showBottom = false;
  TextEditingController messageBoxController = TextEditingController();
  Color myGreen = Color(0xff4bb17b);

  Chat chat = new Chat();
  List messages = [];
  var classData;
  var student;
  Auth auth = new Auth();

  @override
  void initState() {
    super.initState();
    auth.getUserData().then((value) => {
      student = value
    });
  }
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) classData = arguments['myClassData'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  classData['name'],
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w500
                  ),
                  overflow: TextOverflow.clip,
                ),
              ],
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Octicons.info),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: FutureBuilder(
                    future: chat.getMessages(classData['id']),
                    builder: (context, snapshot){
                      if(snapshot.data != null){
                        messages = snapshot.data;
                        messages = messages.reversed.toList();
                        return ListView.builder(
                          reverse: true,
                          controller: _scrollController,
                          padding: const EdgeInsets.all(15),
                          itemCount: messages.length,
                          itemBuilder: (ctx, i) {
                            if(student.isNotEmpty){
                              if(student[0]['id'] == messages[i]['student_id']){
                                return SentMessageWidget(messages[i]);
                              }else{
                                return ReceivedMessagesWidget(messages[i]);
                              }
                            }
                            return Container();
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  height: 61,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 20,),
                              Expanded(
                                child: TextField(
                                  controller: messageBoxController,
                                  decoration: InputDecoration(
                                      hintText: "Type Something...",
                                      border: InputBorder.none),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.photo_camera),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.attach_file),
                                onPressed: () {
                                  setState(() {
                                    _showBottom = _showBottom ? false : true;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: myGreen, shape: BoxShape.circle),
                        child: InkWell(
                          child: Icon(
                            MaterialIcons.send,
                            color: Colors.white,
                          ),
                          onTap: () {
                            var info = {
                              'class_id' : classData['id'].toString(),
                              'message' : messageBoxController.text,
                              'student_id' : student[0]['id'].toString()
                            };
                            setState(() {
                              messages.add(info);
                            });
                            messageBoxController.clear();
                            _scrollController.animateTo(
                              0.0,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                            chat.sendMessage(info, "student/sendmessage").then((res)=>{
                              print(res)
                            });
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
//          Positioned.fill(
//            child: GestureDetector(
//              onTap: () {
//                setState(() {
//                  _showBottom = false;
//                });
//              },
//            ),
//          ),
          _showBottom
              ? Positioned(
            bottom: 90,
            left: 25,
            right: 25,
            child: Container(
              padding: EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 15.0,
                      color: Colors.grey)
                ],
              ),
              child: GridView.count(
                mainAxisSpacing: 21.0,
                crossAxisSpacing: 21.0,
                shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(
                  icons.length,
                      (i) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey[200],
                        border: Border.all(color: myGreen, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              icons[i],
                              color: myGreen,
                            ),
                            onPressed: () {},
                          ),
                          Text(
                            texts[i],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                              letterSpacing: 0.7
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}

List<IconData> icons = [
  MaterialCommunityIcons.file_document_outline,
  Feather.image,
  AntDesign.sound
];
List<String> texts = [
  "Document",
  "Image",
  "Audio"
];