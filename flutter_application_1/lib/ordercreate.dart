import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'classes.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'orderdone.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

enum SingingCharacter { online, cash }

class OrderCreate extends StatefulWidget {
  var bonusesuse = false;
   OrderCreate({ Key? key, required this.bonusesuse }) : super(key: key);

  @override
  _OrderCreateState createState() => _OrderCreateState(bonusesuse:bonusesuse);
}

class _OrderCreateState extends State<OrderCreate> with SingleTickerProviderStateMixin {
  var bonusesuse = false;
  _OrderCreateState({required this.bonusesuse});
  late Future<List>  user;
  var street = TextEditingController();
  var house = TextEditingController();
  var appertament = TextEditingController();
  var enter = TextEditingController();
  var floor = TextEditingController();
  var code = TextEditingController();
  var name = TextEditingController();
  var comment = TextEditingController();
  var timecontroller = TextEditingController();

  late TabController _tabController;
  var err = false;
  var info = '';
  late Future<int> totalcartvar;
  SingingCharacter? _character = SingingCharacter.online;
  // var errfield = false;
  var items1 ; 
  List<String> items = [];

  Future<List> getcaffes() async{
    print('here');
    // var a = await getcaffes();
    var b = await http.get(
      Uri.parse(baseurl+'api/shops/?format=json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'session_key':''
        }
    );
    print(utf8.decode(b.bodyBytes));
    var z = [json.decode(utf8.decode(b.bodyBytes))];
    for (var i in z){
      items.add(i[0]['street']);
    }
    
    // print(utf8.decode(b.bodyBytes));
    return items;
  }

  @override
  void initState() {
    user = getuser();
    _tabController = TabController(length: 2, vsync: this);
    totalcartvar = totalcart();
    items1 = getcaffes();

    super.initState();

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  Future<String> checkaddressin(String street,String house,String appertament,String enter,String floor,String code,String name,String comment) async{
    var a = await getDeviceId();
    var urll = baseurl+'checkaddressanswer/?street='+street+'&house='+house+'&apartment='+appertament+'&name='+name+'&entrance='+enter+'&floor='+floor+'&comment='+comment+'&code='+code+'&type=delivery&device='+a;
    var b = await http.get(
      Uri.parse(urll),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'session_key':''
        }
    );
    print(utf8.decode(b.bodyBytes));
    return b.body.toString();
  }
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
  Future<int> totalcart() async{
    var a = await getDeviceId();
    var b = await http.get(
      Uri.parse(baseurl+'gettotalcart/?device='+a),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
    return int.parse( b.body);
  }

  // List<String> items = [
  //   'ул. Звездная 15',
  //   'ул. Жукова 26',
  //   'ул. Кирова 12',
  //   'ул. Московская 40',
  // ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child : ListView(
          scrollDirection: Axis.vertical,
          children: [
            Align(alignment: Alignment.topRight,child: InkWell(
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
            ),),
            Container(
              margin: EdgeInsets.only(left:20,top:10,bottom: 10),
              child: Text('Доставка',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            ),
            FutureBuilder<List>(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  street = TextEditingController(text: snapshot.data![0][0]['street']);
                  house = TextEditingController(text: snapshot.data![0][0]['house']);
                  appertament = TextEditingController(text: snapshot.data![0][0]['apartament']);
                  enter = TextEditingController(text: snapshot.data![0][0]['enter']);
                  floor = TextEditingController(text: snapshot.data![0][0]['floor']);
                  code = TextEditingController(text: snapshot.data![0][0]['code']);
                  name = TextEditingController(text: snapshot.data![0][0]['address_name']);
                  comment = TextEditingController(text: snapshot.data![0][0]['address_comment']);
                  
                    // if(snapshot.data![0][0]["street"]==''){
                    //   addres_name = 'Выбрать';
                    // }else{
                    //   addres_name = 'ул. '+snapshot.data![0][0]["street"]+', '+snapshot.data![0][0]['house'];
                    // }
                    // if(snapshot.data![0][0]['pickup']==''){
                    //   cafe_choice = 'Выбрать';
                    // }else{
                    //   cafe_choice = snapshot.data![0][0]['pickup'];
                    // }
                    if(snapshot.data![0][0]['delivery_choice'] == true){
                      _tabController.animateTo(0);
                    }else{
                      _tabController.animateTo(1);
                    }
                  
                  return Container(
                    child: Column(children: [
                      Container(
                        height: 400,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                width: 350,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xffFFEED1),
                                  borderRadius: BorderRadius.circular(
                                    5.0,
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(4.0),
                                  child:TabBar(
                                  controller: _tabController,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      5.0,
                                    ),
                                    color: Colors.white,
                                  ),
                                  labelColor: Colors.black,
                                  unselectedLabelColor: Colors.black,
                                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                                  tabs: [
                                    Tab(
                                      text: 'Доставка',
                                    ),
                                    Tab(
                                      text: 'Самовывоз',
                                    ),
                                  ],
                                )),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: _tabController,  
                                  children: [
                                    Column(children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                        child: TextField(
                                          controller: street,
                                          minLines: 1,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 15),
                                          decoration: InputDecoration(
                                            fillColor: Color(0xffFFEED1),
                                            contentPadding: EdgeInsets.all(7.0),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xffA0130C),width: err?3: 1)
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xffA0130C), width: err?3: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xffA0130C), width: err?3: 1),
                                            ),
                                            
                                            isDense: true,
                                            hintText: 'Улица',
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                      Row(children: [
                                        SizedBox(width:14),
                                        Flexible(
                                        // padding: EdgeInsets.symmetric(horizontal: 1 , vertical: 1),
                                        child: TextField(
                                          controller: house,
                                          minLines: 1,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 15),
                                          decoration: InputDecoration(
                                            fillColor: Color(0xffFFEED1),
                                            contentPadding: EdgeInsets.all(7.0),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xffA0130C),width: err?3: 1)
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xffA0130C), width: err?3: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xffA0130C), width: err?3: 1),
                                            ),
                                            isDense: true,
                                            hintText: 'Дом',
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Flexible(
                                        // padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                                        child: TextField(
                                          controller: appertament,
                                          minLines: 1,
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
                                            hintText: 'Квартира',
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Flexible(
                                        // padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                                        child: TextField(
                                          controller: enter,
                                          minLines: 1,
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
                                            hintText: 'Подъезд',
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width:14),
                                      ],),
                                      SizedBox(height: 10,),
                                      Row(children: [
                                        SizedBox(width:14),
                                        Flexible(
                                        // padding: EdgeInsets.symmetric(horizontal: 1 , vertical: 1),
                                        child: TextField(
                                          controller: floor,
                                          minLines: 1,
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
                                            hintText: 'Этаж',
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Flexible(
                                        // padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                                        child: TextField(
                                          controller: code,
                                          minLines: 1,
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
                                            hintText: 'Код',
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width:14),
                                      ],),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                        child: TextField(
                                          controller: name,
                                          minLines: 1,
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
                                            hintText: 'Название адреса',
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 14),
                                        child: TextField(
                                          controller: comment,
                                          minLines: 6,
                                          maxLines: 6,
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
                                            hintText: 'Комментарий к адресу',
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                    ],),
                                    // Container(
                                    //   width: 400,
                                    //   alignment: Alignment.topCenter,
                                    //   margin: EdgeInsets.only(left:20,right:20),
                                    //           child: DropdownButtonHideUnderline(
                                    //             child: DropdownButton2(
                                    //               hint: Text(
                                    //                 'Выберите ресторан',
                                    //                 style: TextStyle(
                                    //                   fontSize: 14,
                                    //                   color: Theme
                                    //                           .of(context)
                                    //                           .hintColor,
                                    //                 ),
                                    //               ),
                                    //               items: items
                                    //                       .map((item) =>
                                    //                       DropdownMenuItem<String>(
                                    //                         value: item,
                                    //                         child: Text(
                                    //                           item,
                                    //                           style: const TextStyle(
                                    //                             fontSize: 14,
                                    //                           ),
                                    //                         ),
                                    //                       ))
                                    //                       .toList(),
                                    //               value: selectedValue,
                                    //               onChanged: (value) {
                                    //                 setState(() {
                                    //                   selectedValue = value as String;
                                    //                   // fo(value as String);
                                    //                 });
                                    //               },
                                    //               buttonHeight: 40,
                                    //               buttonWidth: 320,
                                    //               itemHeight: 40,
                                    //             ),
                                    //           ),
                                    //         // )
                                    // )
                                    FutureBuilder<List>(
                                      future: items1,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData){
                                          return Container(
                                            width: 400,
                                            alignment: Alignment.topCenter,
                                            margin: EdgeInsets.only(left:20,right:20),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                hint: Text(
                                                  'Выберите ресторан',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme
                                                    .of(context)
                                                    .hintColor,
                                                  ),
                                                ),
                                                items: snapshot.data!
                                                  .map((item) =>
                                                    DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ))
                                                  .toList(),
                                                  value: selectedValue,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedValue = value as String;
                                                      // fo(value as String);
                                                    });
                                                    print(selectedValue);
                                                  },
                                                  buttonHeight: 40,
                                                  buttonWidth: 400,
                                                  itemHeight: 40,
                                                ),
                                              ),
                                          );
                                        }
                                        else{
                                          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
                                        }
                                      }
                                    )
                                  ],
                                ),
                              ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left:25),
                        alignment: Alignment.centerLeft,
                        child: Text('Выберите удобное для вас время',textAlign: TextAlign.left,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: TextField(
                          controller: timecontroller,
                          minLines: 1,
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
                          hintText: 'Время',
                          filled: true,
                        ),),),
                        Container(
                          margin: EdgeInsets.only(left:25,top:20,bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: Text('Выберите способ оплаты',textAlign: TextAlign.left,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left:20,right:20),
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.loose,
                                child:RadioListTile<SingingCharacter>(
                                  contentPadding: EdgeInsets.all(0),
                                  activeColor: Color(0xffA0130C),
                                  title: const Text('Онлайн оплата'),
                                  value: SingingCharacter.online,
                                  groupValue: _character,
                                  onChanged: (SingingCharacter? value) {
                                    setState(() {
                                      _character = value;
                                    });
                                  },
                                )
                              ),
                              SizedBox(width: 20,),
                              Flexible(
                                fit: FlexFit.loose,
                                child:RadioListTile<SingingCharacter>(
                                  contentPadding: EdgeInsets.all(0),
                                  title: const Text('Наличными'),
                                  activeColor: Color(0xffA0130C),
                                  value: SingingCharacter.cash,
                                  groupValue: _character,
                                  onChanged: (SingingCharacter? value) {
                                    setState(() {
                                      _character = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          )
                        ),
                        Container(alignment: Alignment.center,child: Text(info),),
                        InkWell(
                          child: Container(
                            margin: const EdgeInsets.only(left:20.0,right:20,top:10),
                            padding: const EdgeInsets.only(top:10,bottom:10,left: 20,right:20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xffA0130C),
                              borderRadius: BorderRadius.all(Radius.circular(80))
                            ),
                            child: const Text('Оформить заказ',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600)),
                          ),
                          onTap: () async{
                            print(_tabController.index);
                            if(_tabController.index == 0){
                              if (street.text == '' || house.text == ''){
                                setState(() {
                                  err = true;
                                });
                              } else{
                                var z = await checkaddressin(street.text,house.text,appertament.text,enter.text,floor.text,code.text,name.text,comment.text);
                                print(z); 
                                if (z.split('.')[0] == '400'){
                                  setState(() {
                                    info = z;
                                  });
                                }else{
                                  Navigator.pop(context);
                                }
                                // if (z == 'Пиццерия закрыта'){
                                //   setState(() {
                                //     info = 'Пиццерия еще не открылась';
                                //   });
                                // }
                                // else{
                                //   var i = z.split('.')[0];
                                //   if (i == 'Входит в область доставки'){
                                //     setState(() {
                                //       info = 'Адрес входит в область доставки. Проверка суммы минимального заказа';
                                //     });
                                //     var tot = await totalcart();
                                //     var mini = int.parse(z.split('.')[1].split('-')[1].replaceAll(' ', ''));
                                //     if (tot > mini){
                                //       setState((){
                                //         info = 'Сумма минимального заказа меньше суммы заказа. Все в порядке можно идти дальше';
                                //       });
                                //     }
                                //     else{
                                //       setState(() {
                                //         info = 'Сумма минимального заказа больше суммы заказа. Нужно добавить чтото в карзину до '+ mini.toString();
                                //       });
                                //     }
                                //   }
                                //   else if (i == 'Не входит в область доставки'){
                                //     info = 'Адрес не входит в область доставки.';
                                //   }
                                //   else{
                                //     info = 'Ошибка. Попробуйте позже';
                                //   }
                                // }
                              }
                            } else{
                              if ( selectedValue == null || selectedValue == ''){
                                setState(() {
                                  info = 'Выберите пункт выдачи';
                                });
                              }else{
                                var a = await getDeviceId();
                                var urll = baseurl+'createorderpickup/?pickup='+selectedValue!+'&paymethod='+_character.toString()+'&time='+timecontroller.text+'&type=pickup&device='+a;
                                var b = await http.get(
                                  Uri.parse(urll),
                                    headers: <String, String>{
                                      'Content-Type': 'application/json; charset=utf-8',
                                      'session_key':''
                                    }
                                );
                                print(utf8.decode(b.bodyBytes));
                                Navigator.pop(context);
                              }
                            }
                            // setState((){
                            // });
                            // Navigator.pop(context);
                            // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<bool>(fullscreenDialog: true,builder: (BuildContext context) => OrderDone()),);
                          },
                        ),
                    ],),
                  );

                }else{
                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
                }
              }
            )
          ]
        )
      ),

    );
  }
}