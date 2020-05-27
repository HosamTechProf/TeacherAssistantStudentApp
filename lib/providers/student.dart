import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/providers/serve_url.dart';

class Student{

  String serverUrl = ServerUrl.url;

  var status;
  var token;
  var error;

  Future<List> getClasses() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/api/auth/student/classes";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        });
    return json.decode(response.body);
  }

  updateUserData(info) async{
    String myUrl = "$serverUrl/api/auth/user/update";
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer ${prefs.get('token')}'
        },
        body: info
    );
    var data = json.decode(response.body);
    print(data);
    if(response.statusCode == 200){
      return true;
    }else{
      error = data['error'];
      return error.values.toList()[0][0];
    }
  }

}