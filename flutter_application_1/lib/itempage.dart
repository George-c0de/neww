import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'classes.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future <List<DopClass>> fetchAlbum1() async {

   final response =
        await http.get(Uri.parse(baseurl+'api/dops/?format=json'));

    if (response.statusCode == 200) {
      final parsed = jsonDecode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();

      return parsed.map<DopClass>((json) => DopClass.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
}
List<DopClass> DopFromJson(String str) =>
    List<DopClass>.from(json.decode(str).map((x) => DopClass.fromJson(x)));




class DopItem extends StatefulWidget {
  Function fo;
  Function fo1;
  var item;
  var activeit;
  DopItem({ Key? key, required this.fo, required this.fo1,required this.item,required this.activeit}) : super(key: key);

  @override
  _DopItemState createState() => _DopItemState(fo:fo,fo1:fo1,item:item,activeit:activeit);
}

class _DopItemState extends State<DopItem> {
  var activeit ;
  Function fo;
  Function fo1;
  var item;
  _DopItemState({ Key? key, required this.fo, required this.fo1,required this.item,required this.activeit});
  @override
  void initState() {
    // super.initState();
    activeit = false;
  }
  
  @override
  Widget build(BuildContext context) {
    item = widget.item;
    // activeit = widget.activeit;
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(color:activeit? Color(0xffffd691) : Color(0xffFFEED1),width: 5),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          children: [
            Container(width: 100,padding: EdgeInsets.only(left:5,right:5),child:Image.network(item['img'].toString(),fit: BoxFit.cover,),),
            Padding(padding: EdgeInsets.only(top:14),child:Text(item['title'],style: TextStyle(color: Color(0xff272727),fontSize: 14),)),
            Padding(padding: EdgeInsets.only(top:5,bottom: 5),child:Text(item['price'].toString() + ' ₽',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),)),
          ],
        )
      ),
      onTap: (){
        setState(() {
          activeit = !activeit;
        });
        if (activeit == true){
          fo(item['title'],item['price']);
        }else{
          fo1(item['title'],item['price']);
        }
      },
    );
  }
}

class PriceDigits extends StatefulWidget {
  var item;
  PriceDigits({ Key? key, required this.item}) : super(key: key);

  @override
  _PriceDigitsState createState() => _PriceDigitsState(item:item);
}

class _PriceDigitsState extends State<PriceDigits> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  var price_per_25 = 500;
  var price_per_30 = 700;
  List dops = [];
  var dops_price = 0;
  var base_price = 0;
  var total = 0;
  var item;
  late Future <List<DopClass>> futureAlbum;
  var is25 = true;
  var text25 = '';
  var text38 = '';
  var productselected = 0;
  _PriceDigitsState({ Key? key, required this.item});
  @override
  void initState() {
    super.initState();
    print(item);
    //  futureAlbum = fetchAlbum1();
    text25 = 'Маленькая '+ item['types'][productselected]['size'] +' см, '+ item['types'][productselected]['weight'].toString() +' г';
    text38 = 'Маленькая '+ item['types'][productselected]['size'] +' см, '+ item['types'][productselected]['weight'].toString() +' г';
    // price_per_25 = item['price'];
    // price_per_30 = item['price_per_30'];
    base_price = item['types'][productselected]['price'];
    total = base_price + dops_price;
    _tabController = TabController(length: item['types'].length, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  void addtolist(String title,int price){
    dops_price = 0;
    dops.add({title:price});
    for (var i in dops){
      // dops_price += i.values;
      for (int b in i.values){
        dops_price += b;
      }
    }
    setState(() {
      total = base_price + dops_price;
    });
  }
  void delfromList(String title,int price){
    dops_price = 0;
    dops.removeWhere((item) => item[title] == price);
    for (var i in dops){
      for (int b in i.values){
        dops_price += b;
      }
    }
    setState(() {
      total = base_price + dops_price;
    });  
  }
  
  Future<void> addtocart() async{
    var a = await getDeviceId();
    var size = 0;
    if (is25 == true){
     size = 25;
    }else{
     size = 38;
    }
    var id = item['pk'];
    var count =1;
    var price = total;
    var dopss = '';
    for (var i in dops){
      for (String b in i.keys){
        dopss += b+';';
      }
    }
    var ur = baseurl+'addtocartapp/?device='+a+'&size='+size.toString()+'&id='+id.toString()+'&count='+count.toString()+'&price='+price.toString()+'&dops='+dopss;
    var b = await http.get(
      Uri.parse(ur),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
    print(ur);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        child: FittedBox(
          child: InkWell(
            child: Container(
              width: 370,
              padding: EdgeInsets.only(top:10,bottom: 10),
              decoration: BoxDecoration(
                color: Color(0xffA0130C),
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: Center(child:Text('В корзину за '+ total.toString() +' ₽',style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600,fontSize: 18))),
            ),
            onTap: (){
              addtocart();
              Navigator.pop(context);
            },
          ),
        )
      ),
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
              margin:  EdgeInsets.only(left:60, right:60, top:20, bottom:20),
              child: Image.network(item['types'][productselected]['img'],width: 120,fit:BoxFit.cover),
            ),
            Padding(padding: EdgeInsets.only(left: 20, right: 20, bottom: 8),child: Text(item['title'],style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color:Color(0xff272727)),),),
            Padding(padding: EdgeInsets.only(left: 20, right: 20, bottom: 12),child: Text('Маленькая '+ item['types'][productselected]['size'] +' см, '+ item['types'][productselected]['weight'].toString() +' г',style: TextStyle(fontSize: 15,color:Color(0xff272727)),),),
            Padding(padding: EdgeInsets.only(left: 20, right: 20, bottom: 12),child: Text(item['types'][productselected]['composition'],style: TextStyle(fontSize: 16,color:Color(0xff272727)),),), Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 62,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 35,
                        width: 370,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xffFFEED1),
                          borderRadius: BorderRadius.circular(
                            5.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(-3, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child:TabBar(
                            onTap: (int index) {
                              setState(() {
                                productselected = index;
                                base_price = item['types'][productselected]['price'];
                                dops_price = 0;
                                dops.clear();
                                total = base_price + dops_price;
                              });
                            },
                            controller: _tabController,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5.0,
                              ),
                              color: Colors.white,
                            ),
                            labelColor: Colors.black,
                            labelStyle: TextStyle(fontWeight: FontWeight.w500),
                            unselectedLabelColor: Colors.black,
                            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                            tabs: [
                              for (var size in item['types']) Tab(
                                text: size['size']+' см',
                              ),
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left:20,right:20),child: Text('Добавить в пиццу',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:Color(0xff272727)),textAlign: TextAlign.center,),),
              Container(
                margin: EdgeInsets.only(left:0,right:0),
                padding: EdgeInsets.only(left:16,right:16,bottom:70,top:15),
                child:SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [
                      for (var itemdop in item['types'][productselected]['dops']) DopItem(fo:addtolist,fo1:delfromList,item: {'title':itemdop['title'],'img':itemdop['img'],'price':itemdop['price']},activeit:false),
                    ]
                  )
                ),
              )
            ],
          )
        ]
      )
      )
    );
  }
}


class ItemPage extends StatelessWidget {
  var item;
  ItemPage({ Key? key,required this.item}) : super(key: key); 
  @override
  Widget build(BuildContext context) {
    return PriceDigits(item: item);
       
  }
}