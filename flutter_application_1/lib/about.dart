// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'classes.dart';
import 'dart:math';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/style.dart'; // For using CSS



class About extends StatefulWidget {
  const About({ Key? key }) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  var text;
  @override
  void initState() {
    super.initState();
    text = policytext();
  }
  Future<String> policytext() async{
    var a = await getDeviceId();
   var b = await http.get(
      Uri.parse(baseurl+'getabout/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
    return b.body;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child : ListView(
          scrollDirection: Axis.vertical,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                child: InkWell(child:Container(
                    decoration: BoxDecoration(
                      color:Color(0xffFFEED1),
                      borderRadius: BorderRadius.all(Radius.circular(40))
                    ),
                    padding: EdgeInsets.only(left:5,right:5,top:9,bottom:8),
                    margin: EdgeInsets.only(right: 10,top:10),
                    child: SvgPicture.asset(
                      'assets/images/arrowdown.svg',
                      semanticsLabel : 'A red up arrow',
                      width : 18,
                      fit : BoxFit.cover
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),child:Text('О приложении',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),)),
            Container(
              margin: EdgeInsets.only(left:20,right:20),
              child:SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: FutureBuilder<String>(
                  future: text,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        child:Text(snapshot.data!,style: TextStyle(fontSize: 16),),
                      );
                    }
                    else if (snapshot.connectionState != ConnectionState.done){
                      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA0130C))));
                    }
                    else {
                      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA0130C))));
                    }
                  }
                )
              )
            ),

          ]
        )
      )
    );
  }
}



class AboutPage extends StatelessWidget {
  const AboutPage({ Key? key}) : super(key: key); 
  @override
  Widget build(BuildContext context) {
    return About();
       
  }
}