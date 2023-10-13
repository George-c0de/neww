import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'itempage.dart';
import 'itemdefault.dart';
// import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'choicecafe.dart';
import 'addresssettings.dart';
import 'classes.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final List<String> imgList = [
  'assets/images/main.png',
];

class StackOver extends StatefulWidget {
  Function fo;
  Function fo1;
  Function fo2;
  StackOver({ Key? key, required this.fo, required this.fo1, required this.fo2}) : super(key: key);

  @override
  _StackOverState createState() => _StackOverState(fo:fo,fo1:fo1,fo2:fo2);
}

class _StackOverState extends State<StackOver>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Function fo;
  Function fo1;
  Function fo2;
  _StackOverState({required this.fo,required this.fo1,required this.fo2});


  late Future<List>  user;
  Future<List> getuser() async{
    var a = await getDeviceId();
    // var b = await http.get(Uri.parse(baseurl+'api/user/'+a+'/?format=json'));
    print(a);
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
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    user = getuser();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  var addres_name = 'ул. Блюхера, д. 48';
  var cafe_choice = 'Выбрать ';
  void setaddres(String title){
    print(title);
    print('in func');
    setState(() {
      addres_name = title;
      user = getuser();
    });
  }
  void setcafe(String title){
    setState(() {
      cafe_choice = title;
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData){ 
            // print(json.decode( snapshot.data![0]));
            print('aasd-asdas-d-----------asd');
            if (snapshot.data![0]==[] || snapshot.data![0][0]['loggined'] == false){
              addres_name = 'Выбрать';
            }else{
              if(snapshot.data![0][0]["street"]==''){
                addres_name = 'Выбрать';
              }else{
                addres_name = 'ул. '+snapshot.data![0][0]["street"]+', '+snapshot.data![0][0]['house'];
              }
              if(snapshot.data![0][0]['pickup']==''){
                cafe_choice = 'Выбрать';
              }else{
                cafe_choice = snapshot.data![0][0]['pickup'];
              }
              if(snapshot.data![0][0]['delivery_choice'] == true){
                _tabController.animateTo(0);
              }else{
                _tabController.animateTo(1);
              }
            }
            print(snapshot.data![0][0]['delivery_choice']);
            print(addres_name+'    -----    ');
            return Container(
              height: 100,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // give the tab bar a height [can change hheight to preferred height]
                    Container(
                      height: 40,
                      width: 250,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Color(0xffFFEED1),
                        borderRadius: BorderRadius.circular(
                          5.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(-3, 5), // changes position of shadow
                          ),
                        ],

                      ),
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        
                        child:TabBar(
                          onTap: (int e)async{
                            if (e == 0){
                              var a = await getDeviceId();
                              var b = await http.get(
                                Uri.parse(baseurl+'deliverychoise/?device='+a),
                                headers: <String, String>{
                                  'Content-Type': 'application/json; charset=UTF-8',
                                  'session_key':''
                                }
                              );
                            }else{
                              var a = await getDeviceId();
                              var b = await http.get(
                                Uri.parse(baseurl+'pickupchoice/?device='+a),
                                headers: <String, String>{
                                  'Content-Type': 'application/json; charset=UTF-8',
                                  'session_key':''
                                }
                              );
                            }
                          },
                        controller: _tabController,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            5.0,
                          ),
                          color: Colors.white,
                          
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,



                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black,
                        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                        tabs: [
                          // first tab [you can add an icon using the icon property]
                          Tab(
                            text: 'Доставка',
                          ),

                          // second tab [you can add an icon using the icon property]
                          Tab(
                            text: 'Самовывоз',
                          ),
                        ],
                      )),
                    ),
                    // tab bar view here
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        
                        children: [
                          // first tab bar view widget 
                          Container(
                            alignment: Alignment.center,
                            // margin: EdgeInsets.only(left: 125,right:110),
                            
                            child:InkWell(child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                              // height: 10,
                                  alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                      bottom: 5, // Space between underline and text
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(
                                        color: Color(0xffA0130C), 
                                        width: 1.0, // Underline thickness
                                        ))
                                      ),
                                    child: Text(
                                        addres_name,
                                        style: TextStyle(
                                        color: Colors.black,
                                        ),
                                      ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5,bottom: 7),child:
                                SvgPicture.asset(
                                  'assets/images/arrow.svg',
                                  semanticsLabel: 'A red up arrow'
                                ),
                                )
                              ],
                            ),
                            onTap: (){
                              // fo();
                              if (snapshot.data![0]==[] || snapshot.data![0][0]['loggined'] == false){
                                                  fo();

                              }else{
                                Scaffold.of(context).showBottomSheet<void>(
                                
                                  (BuildContext context) {
                                    return AddressSettingsPage(fo:setaddres);
                                  }
                                );
                              }
                            },
                            )
                          ),
                          // second tab bar view widget
                          Container(
                            margin: EdgeInsets.only(left: 130,right:110),
                            alignment: Alignment.center,
                            child: InkWell(child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                              // height: 10,
                                  alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                      bottom: 5, // Space between underline and text
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(
                                        color: Color(0xffA0130C), 
                                        width: 1.0, // Underline thickness
                                        ))
                                      ),
                                    child: Text(
                                        cafe_choice,
                                        style: TextStyle(
                                        color: Colors.black,
                                        ),
                                      ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5,bottom: 3),child:
                                SvgPicture.asset(
                                  'assets/images/arrow.svg',
                                  semanticsLabel: 'A red up arrow'
                                ),
                                )
                              ],
                            ),
                            onTap: (){
                              // fo1();
                            if (snapshot.data![0]==[] || snapshot.data![0][0]['loggined'] == false){

                            
                            }else{
                              Scaffold.of(context).showBottomSheet<void>( 
                                (BuildContext context) {
                                  return CafePage(fo:setcafe);
                                }
                              );
                            }
                            
                            },
                          ),
                          )

                        ],
                      ),
                    ),
                  ],
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

class Menu extends StatelessWidget {
  const Menu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.green,
              title: Text('Have a nice day'),
              floating: true,
            ),
           
          SliverList(
            delegate: SliverChildListDelegate([
                
            ]
          ),
        )
      ],
    );
  }
}

class HitItem extends StatelessWidget {
  var item;
  Function fo2;
    var loggined;

  HitItem({ Key? key,required this.item,required this.fo2,required this.loggined }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Container(
          width: 270,
          margin: EdgeInsets.only(left:20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color:Color(0xffFFEED1),
            boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(-4, 4), // changes position of shadow
                ),
              ],
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.network(item['types'][0]['img'],width: 110,fit:BoxFit.cover),
                  SizedBox(width:10),
                  Flexible(child:Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Container(height: 27,padding: EdgeInsets.only(bottom:7),child: Text(item['title'],style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color:Color(0xff272727)),),),
                    Container(height:50,padding: EdgeInsets.only(bottom:7),child:Text(item['types'][0]['composition'],softWrap: true,overflow: TextOverflow.clip,style: TextStyle(color:Color(0xff444444),fontSize: 12,fontWeight: FontWeight.w400),),),
                    Container(padding: EdgeInsets.only(top:5,bottom: 5,left:15,right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffA0130C),
                      ),
                      child: Text( 'от ' + item['types'][0]['price'].toString() + ' ₽',style: const TextStyle(color:Colors.white,fontSize: 13,fontWeight: FontWeight.w500),
                    ),
                  )

                ],
              )
            ),
          ],
        ),
      ),
    ),
    onTap:(){
      //  Navigator.of(context, rootNavigator: true).push(
      //             // arguments: {'exampleArgument': 'exampleArgument'},

      //             MaterialPageRoute<bool>(fullscreenDialog: true,builder: (BuildContext context) => ItemPage(item: item,)),
      //           );
                 if(loggined == true){
                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<bool>(fullscreenDialog: true,builder: (BuildContext context) => ItemPage(item:item)),);
                  }else{
                    fo2();
                  }
                // },);
    }
    );
  }
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class ItemMiniWidget extends StatelessWidget{
  var item ;
  var loggined;
  Function fo2;
  ItemMiniWidget({Key? key, this.item, this.loggined,required this.fo2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Container(color:Colors.white,padding:EdgeInsets.only(left:20,right:20,bottom: 15),child: Row(children: [
                  Image.network(item['types'][0]['img'],width: 130,fit:BoxFit.cover),
                  SizedBox(width:15),
                  Flexible(child:Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Padding(padding: EdgeInsets.only(bottom:10),child: Text(item['title'],style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color:Color(0xff272727)),),),
                    Padding(padding: EdgeInsets.only(bottom:10),child:Text(item['types'][0]['composition'],softWrap: true,overflow: TextOverflow.clip,style: TextStyle(color:Color(0xff444444),fontSize: 13),),),
                    Container(padding: EdgeInsets.only(top:5,bottom: 5,left:15,right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffA0130C),
                    ),child: Text('от '+item['types'][0]['price'].toString()+' ₽',style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500),),
                  )]))
                ],),),onTap: (){
                  if(loggined == true){
                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<bool>(fullscreenDialog: true,builder: (BuildContext context) => ItemPage(item:item)),);
                  }else{
                    fo2();
                  }
                },);
  }
}



Future <List<Product>> fetchAlbum() async {

   final response =
        await http.get(Uri.parse(baseurl+'api/products/?format=json'));
    
    if (response.statusCode == 200) {
      final parsed = jsonDecode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
      // print(parsed);
      return parsed.map<Product>((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
}

List<Product> productsFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));



Future <List<Category>> fetchAlbumCategories() async {

   final response =
        await http.get(Uri.parse(baseurl+'api/defaultproducts/?format=json'));
    
    if (response.statusCode == 200) {
      final parsed = jsonDecode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
      // print(parsed);
      return parsed.map<Category>((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
}

List<Category> categoriesFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));




class HomePage extends StatefulWidget {
  Function fo;
  Function fo1;
  Function fo2;
  HomePage({
    Key? key,
    this.controller,
    required this.fo,
    required this.fo1,
    required this.fo2,

  }) : super(key: key);


  final ScrollController? controller;
  @override
  State<HomePage> createState() => HomePageState(fo:fo,fo1:fo1,fo2:fo2,controller: controller);

}
class HomePageState  extends State<HomePage>{
  Function fo;
  Function fo1;
  Function fo2;
  final ScrollController? controller;
  late Future <List<Product>> futureAlbum;
  late Future <List<Category>> futureAlbumCategories;

  late Future<List> check_loggined_var; 

  HomePageState({ Key? key, required this.fo, required this.fo1,required this.fo2,required this.controller,});
  
  Future<List> check_loggin() async{
    var a = await getDeviceId();
    print(a);
    var b = await http.get(
      Uri.parse(baseurl+'checkloggined/?device='+a),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
    print(json.decode(b.body)['phone'].toString() + 'check loggined function');
    bool g = json.decode(b.body)['loggined'] =='True';
    return [g,json.decode(b.body)['phone'].toString()];
  }
  



  @override
  void initState() {
    super.initState();
      check_loggined_var =  check_loggin();
      futureAlbum = fetchAlbum();
      futureAlbumCategories = fetchAlbumCategories();

      // user = getuser();

    //  nameCategory = 'Пицца';
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  var loggined;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: check_loggined_var,
        builder: (context, snapshot) {
          if (snapshot.hasData){
          if(snapshot.data![0] == true){loggined = true;}else{loggined=false;}
          return CustomScrollView(
            slivers: [

              SliverList(delegate: SliverChildListDelegate([

              Padding(padding: EdgeInsets.only(bottom: 8,top:10),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 7),
                      child: SvgPicture.asset(
                        'assets/images/place.svg',
                        semanticsLabel: 'A red up arrow'
                      ),
                    ),
                    Text('Ярославль',style: TextStyle(fontSize: 16),),
                  ],
                ),
              ),
              StackOver(fo:fo,fo1:fo1,fo2:fo2),
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
              Padding(padding: EdgeInsets.only(left:20,bottom: 3,top:13),child: Container(child: Text('Хиты',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600,color:Color(0xff272727)),),),),
                Container(
                  margin: EdgeInsets.only(left:0,right:0,bottom: 13),
                  // height:160,
                  // padding: EdgeInsets.symmetric(vertical: 10),
                  child:SingleChildScrollView(
                    scrollDirection: Axis.horizontal,

                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: FutureBuilder<List<Product>>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          for (var item in snapshot.data!) {
                            print({'type':'pizza','description':item.description, 'title':item.title, 'hit':item.hit, 'new':item.neww, 'types':item.types ,'pk':item.pk});
                          }
                          return Wrap(
                            children: [
                              if (loggined == true)
                                for (var item in snapshot.data!) HitItem(item:{'type':'pizza','description':item.description, 'title':item.title, 'hit':item.hit, 'new':item.neww, 'types':item.types ,'pk':item.pk},fo2: fo2,loggined: true,),
                              if(loggined==false)
                                for (var item in snapshot.data!) HitItem(item:{'type':'pizza','description':item.description, 'title':item.title, 'hit':item.hit, 'new':item.neww, 'types':item.types ,'pk':item.pk},fo2: fo2,loggined: false,),
                            ]
                          );
                        } else {
                          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA0130C))));
                        }
                      }),
                  )
                ),
              ])),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 50.0,
                  maxHeight:50.0,
                  child:Container(
                    height: 50.0,
                    color: Colors.white,
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height:50,
                      alignment: Alignment.bottomCenter,
                      decoration:  BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 10), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(bottom: 12.0),
                      // margin: EdgeInsets.only(bottom: 20),
                      child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        Container(
                          padding: EdgeInsets.only(top:5,bottom: 5,left:15,right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffA0130C),
                          ),
                          margin: EdgeInsets.only(left:20),
                          child: Text('Пицца',style: TextStyle(color: Colors.white,fontSize: 14),),
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.only(top:5,bottom: 5,left:15,right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffF5F5F5),
                            ),
                            margin: EdgeInsets.only(left:10),
                            child: Text('Роллы',style: TextStyle(color: Color(0xff444444),fontSize: 14),),
                          ),
                          onTap: (){
                            // controller.animateTo(500, duration: Duration(seconds: 2), curve: Curves.easeIn);
                          },
                        ),
                        Container(
                          padding: EdgeInsets.only(top:5,bottom: 5,left:15,right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffF5F5F5),
                          ),
                          margin: EdgeInsets.only(left:10),
                          child: Text('Обеды',style: TextStyle(color: Color(0xff444444),fontSize: 14),),

                        ),
                        Container(
                          padding: EdgeInsets.only(top:5,bottom: 5,left:15,right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffF5F5F5),
                          ),
                          margin: EdgeInsets.only(left:10),
                          child: Text('Напитки',style: TextStyle(color: Color(0xff444444),fontSize: 14),),

                        ),
                        Container(
                          padding: EdgeInsets.only(top:5,bottom: 5,left:15,right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffF5F5F5),
                          ),
                          margin: EdgeInsets.only(left:10),
                          child: Text('Комбо',style: TextStyle(color: Color(0xff444444),fontSize: 14),),

                        ),
                        Container(
                          padding: EdgeInsets.only(top:5,bottom: 5,left:15,right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffF5F5F5),
                          ),
                          margin: EdgeInsets.only(left:10),
                          child: Text('Пасты',style: TextStyle(color: Color(0xff444444),fontSize: 14),),

                        ),
                      ],
                    ))
                  ),
                ),
              )),
              SliverList(delegate: SliverChildListDelegate([
              SizedBox(height: 20,),

                Container(
                  margin: EdgeInsets.only(left:0,right:0),
                  child:SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: FutureBuilder<List<Product>>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: [
                              if (loggined == true)
                                for (var item in snapshot.data!) ItemMiniWidget(item:{'type':'pizza','description':item.description, 'title':item.title, 'hit':item.hit, 'new':item.neww, 'types':item.types ,'pk':item.pk},loggined:true,fo2:fo2),
                              if (loggined == false)
                                for (var item in snapshot.data!) ItemMiniWidget(item:{'type':'pizza','description':item.description, 'title':item.title, 'hit':item.hit, 'new':item.neww, 'types':item.types ,'pk':item.pk},loggined:false,fo2:fo2),
                            ]
                          );
                        } else {
                          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA0130C))));
                        }
                      }),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left:0,right:0),
                  child:SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: FutureBuilder<List<Category>>(
                      future: futureAlbumCategories,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: [
                              if (loggined == true)
                                // for (var item in snapshot.data!) ItemMiniWidget(item:{'type':'pizza','description':item.description, 'title':item.title, 'hit':item.hit, 'new':item.neww, 'types':item.types ,'pk':item.pk},loggined:true,fo2:fo2),
                                for (var category in snapshot.data!) 
                                  for(var item in category.products) InkWell(child: Container(color:Colors.white,padding:EdgeInsets.only(left:20,right:20,bottom: 15),child: Row(children: [
                                    Image.network(item['img'],width: 130,fit:BoxFit.cover),
                                    SizedBox(width:15),
                                    Flexible(child:Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                      Padding(padding: EdgeInsets.only(bottom:10),child: Text(item['title'],style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color:Color(0xff272727)),),),
                                      Padding(padding: EdgeInsets.only(bottom:10),child:Text(item['description'],softWrap: true,overflow: TextOverflow.clip,style: TextStyle(color:Color(0xff444444),fontSize: 13),),),
                                      Container(padding: EdgeInsets.only(top:5,bottom: 5,left:15,right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xffA0130C),
                                      ),child: Text(item['price'].toString()+' ₽',style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500),),
                                    )]))
                                  ],),),onTap: (){
                                    if(loggined == true){
                                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<bool>(fullscreenDialog: true,builder: (BuildContext context) => ItemDefaultPage(item:item)),);
                                    }else{
                                      fo2();
                                    }
                                  },),
                              if (loggined == false)

                                for (var category in snapshot.data!) 
                                  for(var item in category.products) InkWell(child: Container(color:Colors.white,padding:EdgeInsets.only(left:20,right:20,bottom: 15),child: Row(children: [
                                    Image.network(item['img'],width: 130,fit:BoxFit.cover),
                                    SizedBox(width:15),
                                    Flexible(child:Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                      Padding(padding: EdgeInsets.only(bottom:10),child: Text(item['title'],style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color:Color(0xff272727)),),),
                                      Padding(padding: EdgeInsets.only(bottom:10),child:Text(item['description'],softWrap: true,overflow: TextOverflow.clip,style: TextStyle(color:Color(0xff444444),fontSize: 13),),),
                                      Container(padding: EdgeInsets.only(top:5,bottom: 5,left:15,right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xffA0130C),
                                      ),child: Text(item['price'].toString()+' ₽',style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500),),
                                    )]))
                                  ],),),onTap: (){
                                    if(loggined == true){
                                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<bool>(fullscreenDialog: true,builder: (BuildContext context) => ItemDefaultPage(item:item)),);
                                    }else{
                                      fo2();
                                    }
                                  },),

                                // for (var item in snapshot.data!) ItemMiniWidget(item:{'type':'pizza','description':item.description, 'title':item.title, 'hit':item.hit, 'new':item.neww, 'types':item.types ,'pk':item.pk},loggined:false,fo2:fo2),
                            ]
                          );
                        } else {
                          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA0130C))));
                        }
                      }),
                  )
                ),
                SizedBox(height: 100,)
              ]
            )),
            ]
          );
          }
          else{
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
          }
        }
    );    
  }
}

