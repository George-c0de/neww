import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'classes.dart';
import 'app_icons.dart';
import 'home.dart';
import 'cart.dart';
import 'contact.dart';
import 'profile.dart';
import 'callback.dart';
import 'history.dart';
import 'address.dart';
import 'addresssettings.dart';
import 'choicecafe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'classes.dart';
// import 'orderdone.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      theme:  ThemeData(scaffoldBackgroundColor:  Colors.white),
      debugShowCheckedModeBanner: false,
      home:  Login(),
    );
  }
}
class MainLogin extends StatefulWidget {
  const MainLogin({ Key? key }) : super(key: key);

  @override
  _MainLoginState createState() => _MainLoginState();
}

class _MainLoginState extends State<MainLogin> {
  late Future<List> user;

  Future<String> checkuser() async{
    var a = await getDeviceId();
    var b = await http.get(
      Uri.parse(baseurl+'checkloggined/?phone='+a),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
    String checkuservar = b.body.toString();
    return checkuservar;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [],
    );
  }
}


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var fielderr = false;
  final phonefield = TextEditingController();
  var codeSend = "";
  var checkuservar = '';
  late Future<List> user;



  @override
  void initState(){
    user = getuser();
  }
  Future<List> getuser() async{
    var a = await getDeviceId();
    var b = await http.get(
      Uri.parse(baseurl+'api/user/'+a),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
    // print(json.decode(b.body)['phone'].toString()+ 'check loggined function');
    // bool g = json.decode(b.body)['loggined'] =='True';
    print(json.decode(b.body));
    return [json.decode(b.body)];
  }
  Future<void> sendCode(context) async {
    var a = phonefield.text;
    print(a);
    var rndnumber="";
    var rnd= Random();
    for (var i = 0; i < 6; i++) {
    rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    codeSend = rndnumber;
    print(codeSend + a);
    // http.get(
    // Uri.parse('https://toopizzabrothers.ru/loginsend/?phone='+ a +'&code='+this.codeSend),
    // headers: <String, String>{
    //                 'Content-Type': 'application/json; charset=UTF-8',
    //                 'session_key':''
    //   }
    // );
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: user,
        builder: (context, snapshot) {
      if (snapshot.hasData){
        print(snapshot.data![0]);
        if (snapshot.data![0] == []){
          if (snapshot.data![0][0]['loggined'] == true){
            return MyHomePage(title:'a');
          }
          else{
            return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 135.0),
                    child: Center(
                      child: SizedBox(
                          width: 170,
                          height: 150,
                          child: Image.asset('assets/images/logo.png')),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical:25), child:Text('Войти в аккаунт',style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:Color(0xff272727))),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child:  TextField(
                      controller: phonefield,
                      keyboardType: TextInputType.phone,
                      autocorrect: false,
                      inputFormatters: [
                        MaskedInputFormatter('+0(000)000-00-00',)
                      ],
                      minLines: 1,
                      maxLines: 1,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        fillColor: Color(0xffFFEED1),
                        contentPadding: EdgeInsets.symmetric(horizontal:10.0,vertical: 7),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C),width: fielderr? 3:1),
                          borderRadius: BorderRadius.all(Radius.circular(7))
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C), width: fielderr? 3:1),
                                              borderRadius: BorderRadius.all(Radius.circular(7))

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:  Color(0xffA0130C), width: fielderr? 3:1),
                                              borderRadius: BorderRadius.all(Radius.circular(7))

                        ),
                        isDense: true,
                        hintText: 'Номер телефона',
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:10),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                    decoration: BoxDecoration(
                        color: Color(0xffA0130C), 
                      borderRadius: BorderRadius.circular(40)
                      ),
                    child: InkWell(
                      onTap: () async{
                        if(phonefield.text ==''){
                          setState(() {
                            fielderr = true;
                          });
                        }else{
                          var a = await checkuser();
                          if (a == '200'){
                            sendCode(context);
                            Navigator.push(context, MaterialPageRoute(builder: (_) => LoginUser(code:codeSend,phone:phonefield.text)));
                          } else{
                            setState(() {
                              fielderr = true;
                            }); 
                          }
                        }
                      },
                      child: const Text(
                        'Получить код',
                        style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10),child:Text('Впервые у нас?',style: TextStyle(fontSize: 15),),),
                  Wrap(
                    children:[
                      Container(
                        clipBehavior: Clip.hardEdge,
                        padding: EdgeInsets.only(bottom: 5),
                        margin:const EdgeInsets.only(
                          left: 10, // Space between underline and text
                        ),
                        decoration:const BoxDecoration(
                          border: Border(bottom: BorderSide(
                            color: Color(0xffA0130C), 
                            width: 1.0, // Underline thickness
                            )
                          )
                        ),
                        child: InkWell(child: const Text(
                        "Зарегистрироваться",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff272727),
                          ),
                        ),onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => Register()));

                          // Register
                        },) 
                      ),
                    ]
                  ) ,
                  SizedBox(height: 100,),
                  Wrap(
                    children:[
                      Container(
                        clipBehavior: Clip.hardEdge,
                        padding: EdgeInsets.only(bottom: 5),
                        margin: const EdgeInsets.only(
                          left: 10,
                        ),
                        decoration: const BoxDecoration(
                          border:  Border(bottom: BorderSide(
                            color: Color(0xff939393), 
                            width: 1.0, // Underline thickness
                            )
                          )
                        ),
                        child: InkWell(child:const Text(
                          "Пропустить",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff939393),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage(title: 'Flutter Demo Home Page')));
                          },
                        )
                      ),
                    ]
                  ) ,
                ],
              ),
            ),
          );
          }
        } else{
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 135.0),
                    child: Center(
                      child: SizedBox(
                          width: 170,
                          height: 150,
                          child: Image.asset('assets/images/logo.png')),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical:25), child:Text('Войти в аккаунт',style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:Color(0xff272727))),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child:  TextField(
                      controller: phonefield,
                      keyboardType: TextInputType.phone,
                      autocorrect: false,
                      inputFormatters: [
                        MaskedInputFormatter('+0(000)000-00-00',)
                      ],
                      minLines: 1,
                      maxLines: 1,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        fillColor: Color(0xffFFEED1),
                        contentPadding: EdgeInsets.symmetric(horizontal:10.0,vertical: 7),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C),width: fielderr? 3:1),
                          borderRadius: BorderRadius.all(Radius.circular(7))
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA0130C), width: fielderr? 3:1),
                                              borderRadius: BorderRadius.all(Radius.circular(7))

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:  Color(0xffA0130C), width: fielderr? 3:1),
                                              borderRadius: BorderRadius.all(Radius.circular(7))

                        ),
                        isDense: true,
                        hintText: 'Номер телефона',
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:10),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                    decoration: BoxDecoration(
                        color: Color(0xffA0130C), 
                      borderRadius: BorderRadius.circular(40)
                      ),
                    child: InkWell(
                      onTap: () async{
                        if(phonefield.text ==''){
                          setState(() {
                            fielderr = true;
                          });
                        }else{
                          var a = await checkuser();
                          if (a == '200'){
                            sendCode(context);
                            Navigator.push(context, MaterialPageRoute(builder: (_) => LoginUser(code:codeSend,phone:phonefield.text)));
                          } else{
                            setState(() {
                              fielderr = true;
                            }); 
                          }
                        }
                      },
                      child: const Text(
                        'Получить код',
                        style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10),child:Text('Впервые у нас?',style: TextStyle(fontSize: 15),),),
                  Wrap(
                    children:[
                      Container(
                        clipBehavior: Clip.hardEdge,
                        padding: EdgeInsets.only(bottom: 5),
                        margin:const EdgeInsets.only(
                          left: 10, // Space between underline and text
                        ),
                        decoration:const BoxDecoration(
                          border: Border(bottom: BorderSide(
                            color: Color(0xffA0130C), 
                            width: 1.0, // Underline thickness
                            )
                          )
                        ),
                        child: InkWell(child: const Text(
                        "Зарегистрироваться",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff272727),
                          ),
                        ),onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => Register()));

                          // Register
                        },) 
                      ),
                    ]
                  ) ,
                  SizedBox(height: 100,),
                  Wrap(
                    children:[
                      Container(
                        clipBehavior: Clip.hardEdge,
                        padding: EdgeInsets.only(bottom: 5),
                        margin: const EdgeInsets.only(
                          left: 10,
                        ),
                        decoration: const BoxDecoration(
                          border:  Border(bottom: BorderSide(
                            color: Color(0xff939393), 
                            width: 1.0, // Underline thickness
                            )
                          )
                        ),
                        child: InkWell(child:const Text(
                          "Пропустить",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff939393),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage(title: 'Flutter Demo Home Page')));
                          },
                        )
                      ),
                    ]
                  ) ,
                ],
              ),
            ),
          );
        }
      }else{
        return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
      }
    });
  }
  Future<String> checkuser() async{
    var a = await getDeviceId();
    var b = await http.get(
      Uri.parse(baseurl+'checkuser/?phone='+phonefield.text),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
    String checkuservar = b.body.toString();
    return checkuservar;
  }
}







class LoginUser extends StatefulWidget {
  var code;
  var phone;
  LoginUser({ Key? key,required this.code,required this.phone });

  @override
  _LoginUserState createState() => _LoginUserState(code:code,phone: phone);
}

class _LoginUserState extends State<LoginUser> {
  var code;
  var phone;
  final phonefield = TextEditingController();
  final codefield = TextEditingController();
  var errfield = false;
  _LoginUserState({required this.code,required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
      scrollDirection: Axis.vertical,
      children: [
          Align(alignment: Alignment.topRight,child: InkWell(
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
              // fo();
              Navigator.pop(context);
            },
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 170,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/logo.png')),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical:25), child:Center(child:Text('Войти в аккаунт',style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:Color(0xff272727))),)),
            //  Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            //   child: TextField(
            //     minLines: 1,
            //     maxLines: 1,
            //     style: TextStyle(fontSize: 15),
            //     decoration: InputDecoration(
            //       fillColor: Color(0xffFFEED1),
            //       contentPadding: EdgeInsets.symmetric(horizontal:10.0,vertical: 7),
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(color: Color(0xffA0130C),width: errfield? 3:1),
            //         borderRadius: BorderRadius.all(Radius.circular(7))
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Color(0xffA0130C), width: errfield? 3:1),
            //                             borderRadius: BorderRadius.all(Radius.circular(7))

            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Color(0xffA0130C), width: errfield? 3:1),
            //                             borderRadius: BorderRadius.all(Radius.circular(7))

            //       ),
            //       isDense: true,
            //       hintText: 'Номер телефона',
            //       filled: true,
            //     ),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal:10.0,vertical: 7),
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xffFFEED1),
                border: Border.all(
                  color: Color(0xffA0130C),
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(7))
              ),
              child: Text(phone,style: TextStyle(fontSize: 15),),
            ),
             Padding(
              padding: EdgeInsets.only(left: 40,right:40, top: 0,bottom:10),
              child: TextField(
                controller: codefield,
                minLines: 1,
                maxLines: 1,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  fillColor: Color(0xffFFEED1),
                  contentPadding: EdgeInsets.symmetric(horizontal:10.0,vertical: 7),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C),width: errfield? 3:1),
                    borderRadius: BorderRadius.all(Radius.circular(7))
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C), width: errfield? 3:1),
                    borderRadius: BorderRadius.all(Radius.circular(7))

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C), width: errfield? 3:1),
                                        borderRadius: BorderRadius.all(Radius.circular(7))

                  ),
                  isDense: true,
                  hintText: 'СМС-код',
                  filled: true,
                ),
              ),
            ),
            Wrap(
              children:[
                Center(child:Container(
                  clipBehavior: Clip.hardEdge,
                  padding: EdgeInsets.only(bottom: 1),
                  margin: EdgeInsets.only(
                    left: 0, // Space between underline and text
                  ),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      color: Color(0xff939393), 
                      width: 1.0, // Underline thickness
                      )
                    )
                  ),
                  child: const Text(
                  "Выслать повторно",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff939393),
                    ),
                  ),
                )),
              ]
            ),
            Container(
              margin: EdgeInsets.only(top:25,left:140,right:140),
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
              decoration: BoxDecoration(
                  color: Color(0xffA0130C), 
                borderRadius: BorderRadius.circular(40)
                ),
              child: InkWell(
                onTap: () {
                  if(codefield.text == code){
                    logginuser(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage(title: 'Flutter Demo Home Page')));
                  }
                  else{
                    print(codefield.text+' '+code);
                    setState(() {
                      errfield = true;

                    });
                  }
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => LoginUser()));
                },
                child:const Center(child:Text(
                  'Войти',
                  style: TextStyle(color: Colors.white, fontSize: 21,fontWeight: FontWeight.bold),
                ),),
              ),
            ),


      ]
    ));
  }

  Future<void> logginuser(context) async {
    var a = await getDeviceId();
    http.get(
      Uri.parse(baseurl+'getloggin/?phone='+ phone +'&device='+a),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'session_key':''
      }
    );
  }
}







class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool value = false;
  var errpolicy = false;
  final phonefield = TextEditingController();
  final namefield = TextEditingController();
  final birthdayfield = TextEditingController();


  
  Future<String> registeruser(context) async {
    var a = await getDeviceId();
    var b = await http.get(
      Uri.parse(baseurl+'registeruser/?phone='+ phonefield.text +'&device='+a+'&name='+namefield.text+'&birthday='+birthdayfield.text),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'session_key':''
      }
    );
    String registervar = b.body.toString();
    return registervar;
  }
  Future<String> checkuser() async{
    var a = await getDeviceId();
    var b = await http.get(
      Uri.parse(baseurl+'checkuser/?phone='+phonefield.text),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
    String checkuservar = b.body.toString();
    return checkuservar;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView(
      scrollDirection: Axis.vertical,
      children: [
          Align(alignment: Alignment.topRight,child: InkWell(
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
              // fo();
              Navigator.pop(context);
            },
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: SizedBox(
                    width: 170,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/logo.png')),
              ),
            ),
          Padding(padding: EdgeInsets.symmetric(vertical:20), child:Center(child:Text('Регистрация',style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:Color(0xff272727))),)),
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: TextField(
                controller: namefield,
                minLines: 1,
                maxLines: 1,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  fillColor: Color(0xffFFEED1),
                  contentPadding: EdgeInsets.symmetric(horizontal:10.0,vertical: 7),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C),width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(7))
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                                        borderRadius: BorderRadius.all(Radius.circular(7))

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                                        borderRadius: BorderRadius.all(Radius.circular(7))

                  ),
                  isDense: true,
                  hintText: 'Имя',
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40,right:40, top: 0,bottom:10),
              child: TextField(
                minLines: 1,
                maxLines: 1,
                controller: phonefield,
                style: TextStyle(fontSize: 15),
                keyboardType: TextInputType.phone,
                autocorrect: false,
                inputFormatters: [
                  MaskedInputFormatter('+0(000)000-00-00',)
                ],
                decoration: InputDecoration(
                  fillColor: Color(0xffFFEED1),
                  contentPadding: EdgeInsets.symmetric(horizontal:10.0,vertical: 7),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C),width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(7))
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                                        borderRadius: BorderRadius.all(Radius.circular(7))

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                                        borderRadius: BorderRadius.all(Radius.circular(7))

                  ),
                  isDense: true,
                  hintText: 'Номер телефона',
                  filled: true,
                ),
              ),
            ),
             Padding(
              padding: EdgeInsets.only(left: 40,right:40, top: 0,bottom:10),
              child: TextField(
                minLines: 1,
                maxLines: 1,
                controller:birthdayfield,
                keyboardType: TextInputType.phone,
                autocorrect: false,
                inputFormatters: [
                  MaskedInputFormatter('00.00.0000',)
                ],
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  fillColor: Color(0xffFFEED1),
                  contentPadding: EdgeInsets.symmetric(horizontal:10.0,vertical: 7),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C),width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(7))
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                                        borderRadius: BorderRadius.all(Radius.circular(7))

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                                        borderRadius: BorderRadius.all(Radius.circular(7))

                  ),
                  isDense: true,
                  hintText: 'Дата рождения',
                  filled: true,
                ),
              ),
            ),
            SizedBox(height:10),
            Center(child: Padding(padding: EdgeInsets.all(0),child:Text('Мы любим своих гостей\nи на День рождения мы дарим подарок!',textAlign: TextAlign.center,style: TextStyle(fontSize: 13.0),))),
            SizedBox(height:20),
            Container(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // SizedBox(child: Checkbox(
                  //   activeColor: Color(0xffA0130C),
                  //   value: this.value,
                  //   side: BorderSide(color: Color(0xffA0130C),width:1,),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       this.value = !this.value;
                  //     });
                  //   },
                  // ),
                  // width: 34,
                  // height: 20,
                  // ), 
                  ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    child: SizedBox(
                      width: Checkbox.width,
                      height: Checkbox.width,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.transparent,
                          ),
                          child: Checkbox(
                            value: value,
                            onChanged: (value) {
                                setState(() {
                                      this.value = !this.value;
                                    });
                                
                            },
                            activeColor: Color(0xffA0130C),
                            // checkColor: Color(0xffA0130C),
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text( 
                    'Согласен(-на) с Политикой конфиденциальности',
                    style: TextStyle(fontSize: 13.0,color: errpolicy?Color(0xffA0130C): Colors.black ),
                  ), 
                ], 
              ), 
              padding: EdgeInsets.only(left:0,right:2),
            ),
            Container(
              margin: EdgeInsets.only(top:25,left:60,right:60),
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
              decoration: BoxDecoration(
                  color: Color(0xffA0130C), 
                borderRadius: BorderRadius.circular(40)
                ),
              child: InkWell(
                onTap: () async {
                  if(value == true){
                    var a = await checkuser();
                    if (a == '400'){
                      var r = await registeruser(context);
                      if(r == '200'){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage(title: 'Flutter Demo Home Page')));
                      }else{
                        setState(() {
                          errpolicy = true;
                        });
                        print(r);
                      }
                    }
                    else{
                      setState(() {
                        errpolicy = true;
                      });
                      print(a);
                    }
                  }
                  else{
                    setState(() {
                      errpolicy = true;
                    });
                  }
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => LoginUser()));
                },
                child: Center(child:Text(
                  'Зарегистрироваться',
                  style: TextStyle(color: Colors.white, fontSize: 21,fontWeight: FontWeight.bold),
                ),),
              ),
            ),
      ]
    ));
  }
}











class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _myPage = PageController(initialPage: 0);
  int _selectedIndex = 0;

  void changePageCallback(){
    setState(() {
      _selectedIndex = 2;
      _myPage.jumpToPage(_selectedIndex);
    });
  }
  void changePageCallbackTo(){
    setState(() {

      _selectedIndex = 4;
      _myPage.jumpToPage(_selectedIndex);
      print('asdasd');
    });
  }

  void changePageHistory(){
    setState(() {
      _selectedIndex = 3;
      _myPage.jumpToPage(_selectedIndex);
    });
  }
  void changePageHistoryTo(){
    setState(() {

      _selectedIndex = 5;
      _myPage.jumpToPage(_selectedIndex);
      print('asdasd');
    });
  }

  void changePageAddress(){
    setState(() {
      _selectedIndex = 3;
      _myPage.jumpToPage(_selectedIndex);
    });
  }
  
  void changePageAddressTo(){
    setState(() {
      _selectedIndex = 6;
      _myPage.jumpToPage(_selectedIndex);
      print('asdasd');
    });
  }

  
  void changePageAddressSetting(){
    setState(() {
      _selectedIndex = 0;
      _myPage.jumpToPage(_selectedIndex);

    });
  }
  void changePageAddressSettingTo(){
    setState(() {
      _selectedIndex = 7;
      _myPage.jumpToPage(_selectedIndex);
      print('asdasd');
    });
  }


  void changePageCafeTo(){
    setState(() {
      _selectedIndex = 8;
      _myPage.jumpToPage(_selectedIndex);
      print('asdasd');
    });
  }
   void changePageCafe(){
    setState(() {
      _selectedIndex = 0;
      _myPage.jumpToPage(_selectedIndex);

    });
  }

    void changePageProfile(){
    setState(() {
      _selectedIndex = 3;
      _myPage.jumpToPage(_selectedIndex);
      print('asdasd');
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> _tabs = [
      HomeTab(), // see the HomeTab class below
      SettingTab() // see the SettingsTab class below
    ];
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body:SafeArea(bottom: false,child: Stack(
      children: <Widget>[
        PageView(
        // child: Image.network("https://picsum.photos/660/1420"),
        // child: Text('Test')
          physics: NeverScrollableScrollPhysics(),
          controller: _myPage,
          onPageChanged: (intt) {
            print('Page Changes to index $intt');
            _selectedIndex = intt;
          },
          children: <Widget>[
            Center(
              child: Container(
                child: HomePage(fo:changePageAddressSettingTo,fo1:changePageCafeTo,fo2:changePageProfile)
              ),
            ),
            Center(
              child: Container(
                child: CartPage(),
              ),
            ),
            Center(
              child: Container(
                child: ContactPage(fo:changePageCallbackTo),
              ),
            ),
            Center(
              child: Container(
                child: ProfilePage(fo:changePageHistoryTo,fo1:changePageAddressTo),
              ),
            ),
            Center(
              child: Container(
                child: CalbackPage(fo:changePageCallback),
              ),
            ),
            Center(
              child: Container(
                child: HistoryPage(fo:changePageHistory),
              ),
            ),
            Center(
              child: Container(
                child: AddressPage(fo:changePageAddress),
              ),
            ),
            Center(
              child: Container(
                child: AddressSettingsPage(fo:changePageAddressSetting),
              ),
            ),
            // Center(
            //   child: Container(
            //     child: CafePage(fo:changePageCafe),
            //   ),
            // ),
          ]
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
              backgroundColor: Color(0xffF0F0F0).withOpacity(0.8), //here set your transparent level
              elevation: 0,
              selectedItemColor:  Color(0xffA0130C),
              unselectedItemColor: Color(0xff939393),
              type: BottomNavigationBarType.fixed,
              currentIndex: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (int index){
                  setState(() {
                    _selectedIndex = index;
                    _myPage.jumpToPage(_selectedIndex);
                  });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    MyFlutterApp.main,
                    size: 25,
                    color: _selectedIndex == 0||_selectedIndex == 7?Color(0xffA0130C):Color(0xff939393),
                  ), 
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    MyFlutterApp.cart,
                    size: 25,
                    color: _selectedIndex == 1?Color(0xffA0130C):Color(0xff939393),
                  ), 
                  label: 'Search'
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    MyFlutterApp.phone, 
                    size: 25,
                    color: _selectedIndex == 2 || _selectedIndex == 4 ?Color(0xffA0130C):Color(0xff939393),
                  ), 
                  label: 'User'
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    MyFlutterApp.account, 
                    size: 25,
                    color: _selectedIndex == 3 || _selectedIndex == 5 || _selectedIndex == 6 ?Color(0xffA0130C):Color(0xff939393),
                  ), 
                   label:'User',
                )

              ],
            )),
      ],
    ),

      // navigationBar: CupertinoNavigationBar(
      //   // middle: Text('Kindacode.com'),
      // ),
      // child: TabScaffold(
      //     tabBar: CupertinoTabBar(
      //       items: [
      //         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //         BottomNavigationBarItem(
      //             icon: Icon(Icons.settings), label: 'Settings')
      //       ],
      //     ),
      //     tabBuilder: (BuildContext context, index) {
      //       return _tabs[index];
      //     }),

    )
    );

  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Home'),
    );
  }
}

class SettingTab extends StatelessWidget {
  const SettingTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Settings'),
    );
  }
}