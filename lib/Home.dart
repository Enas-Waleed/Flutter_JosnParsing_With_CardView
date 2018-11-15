import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  Map data;
  List userData;

  Future getData() async{

    String url="https://reqres.in/api/users?page=2";

    http.Response response= await http.get(url);
    data=json.decode(response.body);

    setState(() {
      userData=data["data"];
    });

  }

  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text(
          "Json With Card",
          style: TextStyle(fontSize: 18.0),
        ),
      ),

      body: new Container(
        child: new ListView.builder(
            itemCount: userData==null?0:userData.length,
            itemBuilder: (BuildContext build,int index){
              return Card(
                  child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                  children: <Widget>[
                  CircleAvatar(
                  backgroundImage: NetworkImage(userData[index]["avatar"]),
                  ),
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: new Text("${userData[index]["first_name"]} ${userData[index]["last_name"]}",

                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.indigo
                        ),

                      ),
                    )
              ],
              ),
                  ),
              );

            },
        )
      ),



    );
  }
}
