// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'addresssettings.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'classes.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'dart:math';

final List<String> imgList = [
  'assets/images/main.png',
];
class ProfilePage extends StatefulWidget {
  Function fo;
  Function fo1;
  ProfilePage({ Key? key,required this.fo,required this.fo1 }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState(fo:fo,fo1:fo1);
}

class _ProfilePageState extends State<ProfilePage> {
  Function fo;
  Function fo1;
  _ProfilePageState({required this.fo,required this.fo1});
  bool loggined=false;
  var loggined_count = 0;
  late Future<List> check_loggined_var; 


  var fielderr = false;
  final phonefield = TextEditingController();
  final codefield = TextEditingController();
  var codeSend = "";
  var errfield = false;

  bool value = false;
  var errpolicy = false;
  final phonefieldreg = TextEditingController();
  final namefield = TextEditingController();
  final birthdayfield = TextEditingController();


  Future<void> logginuser(context) async {
    var a = await getDeviceId();
    http.get(
      Uri.parse(baseurl+'getloggin/?phone='+ phonefield.text +'&device='+a),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'session_key':''
      }
    );
  }
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
    http.get(
    Uri.parse('https://toopizzabrothers.ru/loginsend/?phone='+ a +'&code='+codeSend),
    headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                    'session_key':''
      }
    );
  }

  Future<void> logout() async{
    var a = await getDeviceId();
    var b = await http.get(
      Uri.parse(baseurl+'logout/?device='+a),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
  }

  Future<List> check_loggin() async{
    var a = await getDeviceId();
    var b = await http.get(
      Uri.parse(baseurl+'checkloggined/?device='+a),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
    print(json.decode(b.body)['phone'].toString()+ 'check loggined function');
    bool g = json.decode(b.body)['loggined'] =='True';
    return [g,json.decode(b.body)['phone'].toString(),json.decode(b.body)['name'].toString()];
  }
  Future<String> registeruser(context) async {
    var a = await getDeviceId();
    var b = await http.get(
      Uri.parse(baseurl+'registeruser/?phone='+ phonefieldreg.text +'&device='+a+'&name='+namefield.text+'&birthday='+birthdayfield.text),
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
  void initState() {
    check_loggined_var =  check_loggin();
    user = getuser();

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  void  setaddres(String title){

  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: check_loggined_var,
        builder: (context, snapshot) {
          if (snapshot.hasData){
          if(snapshot.data![0] == true){loggined = true;}else{loggined=false;}
              return ListView(

                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 0,),
                  loggined == true ?
                    Column(
                      children: [
                        Align(alignment: Alignment.topRight,child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color:Color(0xffFFEED1),
                              borderRadius: BorderRadius.all(Radius.circular(40))
                            ),
                            padding: EdgeInsets.all(3),
                          margin: EdgeInsets.only(right: 10,top:10),
                            child: SvgPicture.asset(
                                'assets/images/settings.svg',
                                  semanticsLabel: 'A red up arrow',
                                  width: 23,
                                  fit:BoxFit.cover
                            ),
                          ),
                          onTap: (){
                            fo1();
                          },
                        ),),
                        Container(padding: EdgeInsets.all(20),alignment: Alignment.centerLeft,child:Text(snapshot.data![2],style: TextStyle(fontWeight: FontWeight.w600,color: Color(0xff272727),fontSize: 30)),),
                        Padding(padding: EdgeInsets.only(left:20,right:20,top:10,bottom:15),child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color:Color(0xffFFEED1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 4,
                                    offset: Offset(-4, 4), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              padding: EdgeInsets.only(top:15,bottom:15,left:25,right:25),
                              child:Column(
                                children: [
                                  Padding(padding: EdgeInsets.only(bottom:20),child: Text('Ваши бонусы',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),),
                                  FutureBuilder<List>(
                                    future:user,
                                    builder:  (context, snapshot) {
                                      if (snapshot.hasData){
                                        print(snapshot.data![0][0]['qr']);
                                        return Container(
                                          padding: EdgeInsets.only(left:20,right:19,top:5,bottom:6),
                                          decoration: BoxDecoration(
                                            color: Color(0xffA0130C),
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                          ),
                                          child: Text(snapshot.data![0][0]['bonuses'].toString(),style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600,fontSize: 19)),                    
                                        );
                                      }else{
                                        return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
                                      }
                                    }
                                  )
                                ],
                              )
                            ),
                            Column(
                              children: [
                                InkWell(
                                  child: Container(
                                  padding: EdgeInsets.only(left:15,right:15,top:13,bottom:13),
                                // margin: EdgeInsets.only(left:20,right:15),
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFEED1),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 4,
                                        offset: Offset(-4, 4), // changes position of shadow
                                      ),
                                    ],
                                  ),

                                  child: Text('История заказов',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                ),
                                  onTap: (){
                                    fo();
                                  },
                                ),
                                
                                SizedBox(height: 12,),
                                InkWell(
                                  child:Container(
                                  padding: EdgeInsets.only(left:15,right:15,top:13,bottom:13),
                                // margin: EdgeInsets.only(left:20,right:15),
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFEED1),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 4,
                                          offset: Offset(-4, 4), // changes position of shadow
                                        ),
                                      ],
                                    ),

                                    child: Text('Адреса доставки',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                  ),
                                  onTap: (){
                                    Scaffold.of(context).showBottomSheet<void>(
                                    
                                      (BuildContext context) {
                                        return AddressSettingsPage(fo:setaddres);
                                      }
                                    );

                                  },
                                ),
                                
                              ],
                            )
                          ],
                        ),),
                        FutureBuilder<List>(
                          future:user,
                          builder:  (context, snapshot) {
                            if (snapshot.hasData){
                              print(snapshot.data![0][0]['qr']);
                              return InkWell(
                                child:Container(
                                  margin:EdgeInsets.only(left:20,right:20,bottom:20) ,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(top:8,bottom:8),
                                  decoration: BoxDecoration(
                                  color: Color(0xffFFEED1),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 4,
                                        offset: Offset(-4, 4), // changes position of shadow
                                      ),
                                    ],
                                  ),   
                                  child: Text('QR code',textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                ),
                                onTap: (){
                                  // Navigator.
                                  Scaffold.of(context).showBottomSheet<void>(
                                    (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                          return SizedBox(
                                            height: 470,
                                            child: Column(
                                              children: [
                                                    Align(alignment: Alignment.topRight,
                                                        child: InkWell(
                                                          child: InkWell(child:Container(
                                                            decoration: BoxDecoration(
                                                              color:Color(0xffFFEED1),
                                                              borderRadius: BorderRadius.all(Radius.circular(40))
                                                            ),
                                                            padding: EdgeInsets.only(left:7,right:7,top:10,bottom:10),
                                                            margin: EdgeInsets.only(right: 10,top:10),
                                                            child: SvgPicture.asset(
                                                              'assets/images/arrowdown.svg',
                                                              semanticsLabel : 'A red up arrow',
                                                              width : 15,
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
                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 20),
                                                        margin: EdgeInsets.only(top:10,bottom: 10),
                                                        child: Text('Предъявите qr code менеджеру в нашем ресторане и получите скидку',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.symmetric(horizontal: 20),
                                                        child: Image.network(snapshot.data![0][0]['qr'],fit:BoxFit.contain),
                                                      )
                                                  ]
                                            )

                                          );
                                        }
                                      );
                                    }
                                  );             
                                },
                              );
                            }
                            else{
                              return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
                            }
                          }
                        ),

                        Container(padding: EdgeInsets.only(left:20,top:5,bottom:7),alignment: Alignment.centerLeft,child: Text('Персональные предложения',style: TextStyle(fontWeight: FontWeight.w600,color: Color(0xff272727),fontSize: 19)),),

                        Container(
                          child: CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1.0,
                              // enlargeCenterPage: false,

                            ),
                            items: imgList
                                .map((item) => Container(
                                      child: Center(
                                          child:
                                              Image.asset(item, fit: BoxFit.cover)),
                                    ))
                                .toList(),
                          )
                        ),
                        SizedBox(height:60),
                        Align(
                          alignment:Alignment.centerLeft,
                          child:
                            InkWell(
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                padding: EdgeInsets.only(bottom: 5),
                                margin: EdgeInsets.only(
                                  left: 20, // Space between underline and text
                                ),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(
                                    color: Color(0xff939393), 
                                    width: 1.0, // Underline thickness
                                    )
                                  )
                                ),
                                child: Text(
                                "Выйти",
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff939393),
                                  ),
                                ),
                              ),
                              onTap: () async{
                                var a = await logout();
                                setState(() {
                                  print('asd');
                                  check_loggined_var =  check_loggin();
                                  loggined_count = 0 ;
                                  loggined = false;
                                });
                              },
                            )
                          
                        )
                      ]
                    )
                  :
                    Column(children: [
                      if (loggined_count == 0)
                        Column(children: [
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
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage(title: 'Flutter Demo Home Page')));
                                if(phonefield.text ==''){
                                  setState(() {
                                    fielderr = true;
                                  });
                                }else{
                                  
                                  sendCode(context);
                                  setState(() {
                                    loggined_count = 1;
                                  });
                                  // Navigator.push(context, MaterialPageRoute(builder: (_) => LoginUser(code:codeSend,phone:phonefield.text)));
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
                          // FlatButton(
                          //   onPressed: (){
                          //     //TODO FORGOT PASSWORD SCREEN GOES HERE
                          //   },
                          //   child: Text(
                          //     'Forgot Password',
                          //     style: TextStyle(color: Colors.blue, fontSize: 15),
                          //   ),
                          // ),
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
                                  // Navigator.push(context, MaterialPageRoute(builder: (_) => Register()));
                                  setState(() {
                                    loggined_count=2;
                                  });
                                  // Register
                                },) 
                              ),
                            ]
                          ) ,
                        ],)
                      else if (loggined_count == 1)
                        Column(children: [
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
                            Container(
                              width: double.infinity,
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
                              child: Text(phonefield.text,style: TextStyle(fontSize: 15),),
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
                                onTap: () async{
                                  if(codefield.text == codeSend) {
                                    var a = await logginuser(context);
                                    setState(() {
                                      print('asdasd');
                                      check_loggined_var =  check_loggin();

                                      loggined = true;
                                    });
                                    // Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage(title: 'Flutter Demo Home Page')));
                                  }
                                  else{
                                    print(codefield.text+' '+codeSend);
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
                        ],)
                      else if (loggined_count == 2)
                        Column(children:[
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
                                controller: phonefieldreg,
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
                                        setState(() {
                                          check_loggined_var =  check_loggin();

                                          loggined = true;

                                        });
                                        // Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage(title: 'Flutter Demo Home Page')));
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

                        ])
                      else
                        Column(children: const [

                        ],)
                    ],)
                ],
              );
          }
          else{
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
          }
        }
    );      
  }
}