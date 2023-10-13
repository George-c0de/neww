import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'classes.dart';

class Switcher extends StatefulWidget {
  bool ispush = true;
  Switcher({ Key? key,required this.ispush  }) : super(key: key);

  @override
  _SwitcherState createState() => _SwitcherState(isSwitched:ispush);
}

class _SwitcherState extends State<Switcher> {
  var isSwitched = true ;
  _SwitcherState({Key? key,required this.isSwitched});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.only(left:20,right:20,top:20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
            Padding(padding:EdgeInsets.all(0),child: Text('Уведомления',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),),
            Padding(padding:EdgeInsets.only(top:7),child: Text('Пуш-уведомления, эл. почта, СМС',style: TextStyle(
                  fontSize: 13,
                  color: Color(0xff939393),
                  ),),),
          ]),),
          CupertinoSwitch(
            value: isSwitched,
            onChanged: (value) async{
              setState(() {
                isSwitched=value;
                print(isSwitched);
              });
              var a = await getDeviceId();
              if (value == true){
                var b = await http.get(
                  Uri.parse(baseurl+'savepush/?device='+a+'&push=true'),
                    headers: <String, String>{
                    'Content-Type': 'application/json; charset=utf-8',
                    'session_key':''
                  }
                );
              }else{
                var b = await http.get(
                  Uri.parse(baseurl+'savepush/?device='+a+'&push=false'),
                    headers: <String, String>{
                    'Content-Type': 'application/json; charset=utf-8',
                    'session_key':''
                  }
                );
              }
            },
            // activeTrackColor: Colors.lightGreenAccent,
            activeColor: Color(0xffA0130C),
          ),
      ],)
      
      

    );
  }
}

class AddressPage extends StatefulWidget {
  Function fo;
  AddressPage({ Key? key,required this.fo  }) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState(fo:fo);
}

class _AddressPageState extends State<AddressPage> {
  Function fo;
  var name = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var birthday = TextEditingController();
  var ispush = true;
  _AddressPageState({Key? key,required this.fo });
  late Future<List>  user;



  Future<List> getuser() async{
    var a = await getDeviceId();
    // var b = await http.get(Uri.parse(baseurl+'api/user/'+a+'/?format=json'));
    var b = await http.get(
      Uri.parse(baseurl+'api/user/'+a+'/?format=json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'session_key':''
        }
    );
    // print(utf8.decode(b.bodyBytes));
    return [json.decode(utf8.decode(b.bodyBytes))];
  }
  @override
  void initState() {
    user = getuser();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData){ 
            name = TextEditingController(text: snapshot.data![0][0]['name']);
            phone = TextEditingController(text: snapshot.data![0][0]['phone']);
            email = TextEditingController(text: snapshot.data![0][0]['email']);
            birthday = TextEditingController(text: snapshot.data![0][0]['birthday']);
            if (snapshot.data![0][0]['push'] == true){
              ispush = true;
            }else{
              ispush = false;
            }
            print(snapshot.data![0][0]['push']);
            return Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Align(alignment: Alignment.topRight,
                    child: InkWell(
                      child: InkWell(child:Container(
                        decoration: BoxDecoration(
                          color:Color(0xffFFEED1),
                          borderRadius: BorderRadius.all(Radius.circular(40))
                        ),
                        padding: EdgeInsets.only(left:7,right:7,top:7,bottom:7),
                        margin: EdgeInsets.only(right: 10,top:10),
                        child: SvgPicture.asset(
                          'assets/images/arrowleft.svg',
                          semanticsLabel : 'A red up arrow',
                          width : 18,
                          fit : BoxFit.cover
                        ),
                      ),
                    ),
                    onTap: (){
                      fo();
                    },
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(20),child:Text('Настройки профиля',style: TextStyle(fontWeight: FontWeight.w600,color: Color(0xff272727),fontSize: 30))),
                  Padding(padding: EdgeInsets.only(left:20,top:10),child: Text('Имя',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: name,
                      minLines: 1,
                      maxLines: 1,
                      onSubmitted: (var e) async{
                        var a = await getDeviceId();
                        var b = await http.get(
                          Uri.parse(baseurl+'savename/?device='+a+'&name='+name.text),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=utf-8',
                              'session_key':''
                            }
                        );
                      },
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        fillColor: Color(0xffFFEED1),
                        contentPadding: EdgeInsets.all(7.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C),width: 1)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                        ),
                        isDense: true,
                        hintText: 'Имя клиента',
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left:20,top:10),child: Text('Номер телефона',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: phone,
                      minLines: 1,
                      enabled: false, 
                      maxLines: 1,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        fillColor: Color(0xffFFEED1),
                        contentPadding: EdgeInsets.all(7.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C),width: 1)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                        ),
                        isDense: true,
                        hintText: '+7 (999) 999-99-99',
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left:20,top:10),child: Text('E-mail',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: email,
                      minLines: 1,
                      maxLines: 1,
                      onSubmitted: (var e) async{
                        var a = await getDeviceId();
                        var b = await http.get(
                          Uri.parse(baseurl+'saveemail/?device='+a+'&email='+email.text),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=utf-8',
                              'session_key':''
                            }
                        );
                      },
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        fillColor: Color(0xffFFEED1),
                        contentPadding: EdgeInsets.all(7.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C),width: 1)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                        ),
                        isDense: true,
                        hintText: 'Не указан',
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left:20,top:10),child: Text('Дата рождения',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: birthday,
                      minLines: 1,
                      maxLines: 1,
                      onSubmitted: (var e) async{
                        var a = await getDeviceId();
                        var b = await http.get(
                          Uri.parse(baseurl+'savebirthday/?device='+a+'&birthday='+birthday.text),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=utf-8',
                              'session_key':''
                            }
                        );
                      },
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        fillColor: Color(0xffFFEED1),
                        contentPadding: EdgeInsets.all(7.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C),width: 1)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                        ),
                        isDense: true,
                        hintText: 'ХХ.ХХ.ХХХХ',
                        filled: true,
                      ),
                    ),
                  ),
                  Switcher(ispush:ispush),
                //   Wrap(
                //   children:[
                //     Container(
                //       clipBehavior: Clip.hardEdge,
                //       padding: EdgeInsets.only(bottom: 5,top:50),
                //       margin: EdgeInsets.only(
                //         left: 20, // Space between underline and text
                //       ),
                //       decoration: BoxDecoration(
                //         border: Border(bottom: BorderSide(
                //           color: Color(0xff939393), 
                //           width: 1.0, // Underline thickness
                //           )
                //         )
                //       ),
                //       child: Text(
                //       "Выйти",
                //       style: TextStyle(
                //         fontSize: 15,
                //         color: Color(0xff939393),
                //         ),
                //       ),
                //     ),
                //   ]
                // )
                ]
              )
          );
        }else{
         return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
        }
      }
    );  
  }
}