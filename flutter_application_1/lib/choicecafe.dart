import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'classes.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class DropDown extends StatefulWidget {
  Function fo;
  DropDown({ Key? key, required this.fo}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState(fo:fo);
}

class _DropDownState extends State<DropDown> {
  Function fo;
  String? selectedValue;
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
    super.initState();
    items1 = getcaffes();
  }

  _DropDownState({ Key? key, required this.fo});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: items1,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          return Container(
            width: 260,
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
                      fo(value as String);
                    });
                  },
                  buttonHeight: 40,
                  buttonWidth: 140,
                  itemHeight: 40,
                ),
              ),
          );
        }
        else{
          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
        }
      }
    );
  }
}

class CafePage extends StatelessWidget {
  Function fo;
  CafePage({ Key? key, required this.fo }) : super(key: key);
  var cafename = '';
  void setName(String title){
    cafename = title;
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        // scrollDirection: Axis.vertical,
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
            Padding(padding:EdgeInsets.only(left:20,right:20,top:20,bottom: 15),child: Text('Выберите ресторан',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),),
            DropDown(fo:setName),
            InkWell(onTap: () async{
              fo(cafename);
              var a = await getDeviceId();
              var b = await http.get(
                Uri.parse(baseurl+'pickupchange/?device='+a+'&restoraunt='+cafename),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'session_key':''
                }
              );
              Navigator.pop(context);

            },child: 
              Container(
                margin: EdgeInsets.only(left:20,right:20,top:15,),
                width: 260,
                padding: EdgeInsets.symmetric(vertical: 5,),
                decoration: BoxDecoration(
                  color: Color(0xffA0130C),
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Text('Сохранить',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,),
              )
            ,)
        ]
      )
    );
  }
}