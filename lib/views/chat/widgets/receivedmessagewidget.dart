import 'package:flutter/material.dart';

import 'mycircleavatar.dart';
class ReceivedMessagesWidget extends StatefulWidget {
  ReceivedMessagesWidget(this.message);
  final message;

  @override
  _ReceivedMessagesWidgetState createState() => _ReceivedMessagesWidgetState();
}

class _ReceivedMessagesWidgetState extends State<ReceivedMessagesWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: <Widget>[
//          MyCircleAvatar(
//            imgUrl: messages[i]['contactImgUrl'],
//          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "sender name",
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 3,),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),

                ),
                child: Text(
                  "${widget.message['message']}",
                  style: Theme.of(context).textTheme.body1.apply(
                        color: Colors.black87,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(width: 15),
          Text(
            "time",
            style: Theme.of(context).textTheme.body2.apply(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
