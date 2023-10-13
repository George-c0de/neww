import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'classes.dart';

class AddressSettingsPage extends StatefulWidget {
  Function fo;
   AddressSettingsPage({ Key? key,required this.fo }) : super(key: key);

  @override
  _AddressSettingsPageState createState() => _AddressSettingsPageState(fo:fo);
}

class _AddressSettingsPageState extends State<AddressSettingsPage> {
    Function fo;
    _AddressSettingsPageState({ Key? key,required this.fo });
  var street = TextEditingController();
  var house = TextEditingController();
  var appertament = TextEditingController();
  var enter = TextEditingController();
  var floor = TextEditingController();
  var code = TextEditingController();
  var name = TextEditingController();
  var comment = TextEditingController();
  late Future<List> addressvar;
  var err = false;
  @override
  void initState() {
    // check_loggined_var =  check_loggin();
    addressvar = getaddress();

    super.initState();
  }

  Future<List> getaddress() async{
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
    return [json.decode(utf8.decode(b.bodyBytes))];
  }

  Future<void> saveaddress() async{
    var a = await getDeviceId();
    var street1 = street.text;
    var house1 = house.text;
    var appertament1 = appertament.text;
    var enter1 = enter.text;
    var floor1 = floor.text;
    var code1 = code.text;
    var name1 = name.text;
    var comment1 = comment.text;
    print(street1);
    var b = await http.get(
      Uri.parse(baseurl+'saveaddress/?device='+a+'&street='+street1+'&house='+house1+'&apartament='+appertament1+'&enter='+enter1+'&floor='+floor1+'&code='+code1+'&name='+name1+'&comment='+comment1),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
    // print(json.decode(b.body)['phone'].toString()+ 'check loggined function');
    // bool g = json.decode(b.body)['loggined'] =='True';
    // return [g,json.decode(b.body)['phone'].toString()];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: addressvar,
        builder: (context, snapshot) {
          
          if (snapshot.hasData){
            // setState(() {
             street = TextEditingController(text: snapshot.data![0][0]['street']);
             house = TextEditingController(text: snapshot.data![0][0]['house']);
             appertament = TextEditingController(text: snapshot.data![0][0]['apartament']);
             enter = TextEditingController(text: snapshot.data![0][0]['enter']);
             floor = TextEditingController(text: snapshot.data![0][0]['floor']);
             code = TextEditingController(text: snapshot.data![0][0]['code']);
             name = TextEditingController(text: snapshot.data![0][0]['address_name']);
             comment = TextEditingController(text: snapshot.data![0][0]['address_comment']);
            print(snapshot.data![0][0]['street']);
          // });
          // if(snapshot.data![0] == true){loggined = true;}else{loggined=false;}
            return SizedBox(
              height: 550,
              child: Column(
                // scrollDirection: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Padding(padding:EdgeInsets.only(left:20,right:20,top:0),child: Text('Измените адрес',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    SizedBox(width:20),
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
                  SizedBox(width:20),
                  ],),
                  SizedBox(height: 10,),
                  Row(children: [
                    SizedBox(width:20),
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
                  SizedBox(width:20),
                  ],),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
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
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left:20,right:20,top:10),
                      padding: EdgeInsets.symmetric(vertical: 7),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xffA0130C),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Text('Сохранить',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                    onTap: () async {
                      if (street.text != '' && house.text != ''){
                        var a = 'ул. '+   street.text + ', д. '+ house.text;
                        var v = await saveaddress();
                        fo(a);
                        
                        Navigator.pop(context);
                      } else{
                        setState(() {
                          err = true;
                        });
                      }
                    },
                  )
                ]
              )

            );
          }
          else{
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
          }
      }
    );
  }
}