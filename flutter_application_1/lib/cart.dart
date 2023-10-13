import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'orderdone.dart';
import 'classes.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'ordercreate.dart';
import 'itemdefault.dart';

class DopItem extends StatelessWidget {
  const DopItem({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 200,
          margin: EdgeInsets.only(left:20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color:Color(0xffFFEED1),
            boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(-2, 4), // changes position of shadow
                ),
              ],
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,

                children: [
                  Image.asset('assets/images/product3.png',width: 65,fit:BoxFit.cover),
                  SizedBox(width:10),
                  Flexible(child:Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Padding(padding: EdgeInsets.only(bottom:7),child: Text('Сырный соус',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color:Color(0xff272727)),),),
                    Padding(padding: EdgeInsets.only(bottom:7),child:Text('25 гр.',softWrap: true,overflow: TextOverflow.clip,style: TextStyle(color:Color(0xff444444),fontSize: 12,fontWeight: FontWeight.w400),),),
                    Container(padding: EdgeInsets.only(top:3,bottom: 3,left:7,right: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffA0130C),
                      ),
                      child: Text('20 ₽',style: TextStyle(color:Colors.white,fontSize: 13,fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}


class CartItemDefault extends StatefulWidget {
  var item;
  Function fo;
  Function fo1;
  CartItemDefault({ Key? key,required this.item,required this.fo,required this.fo1 }) : super(key: key);

  @override
  _CartItemDefaultState createState() => _CartItemDefaultState(item:item,fo:fo,fo2:fo1);
}

class _CartItemDefaultState extends State<CartItemDefault>  {
  var count = 1;
  void doNothing(){}
  var item;
  Function fo;
  Function fo2;
  var dopstotal = 0;
  var dopstext = '';
  @override
  void initState(){
     count = item['count'];
    super.initState();
    for (var i in item['dops']){
      dopstotal += int.parse(i['price']);
      dopstext += i['title'].toString()+' ';
    }
  }
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
    Future<void> delitem(int pk) async{
    var a = await getDeviceId();
      var b = await http.get(
        Uri.parse(baseurl+'delfromcartdefaultapp/?id='+pk.toString()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'session_key':''
          }
      );
      // var c = await fo2();
    }
  Future<void> countchange(String pm,int pk) async{
    var a = await getDeviceId();
    if(pm == '+'){
      var b = await http.get(
        Uri.parse(baseurl+'changeitemcartdefaultapp/?id='+pk.toString()+'&pm=%2B'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'session_key':''
          }
      );
    }else{
      var b = await http.get(
        Uri.parse(baseurl+'changeitemcartdefaultapp/?id='+pk.toString()+'&pm=-'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'session_key':''
          }
      );
    }
    // return int.parse( b.body);

  }
  _CartItemDefaultState({required this.item,required this.fo, required this.fo2});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key:  UniqueKey(),
      endActionPane:  ActionPane(
        extentRatio: 0.25,
          dismissible: DismissiblePane(onDismissed: () async{
            var a = await delitem(item['pk']);
            var c = await fo2();
            fo();
           
          }),
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            
            backgroundColor: Color(0xffA0130C),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Удалить',
            onPressed: (context)async{
               var a = await delitem(item['pk']);
            var c = await fo2();
            fo();
            },
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(left: 20,right:20,bottom:10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(baseurl+'media/'+item['img'],width: 80,fit:BoxFit.cover),
            
            SizedBox(width:18),

            Expanded(flex: 7,child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(bottom:8),child: Text(item['title'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color:Color(0xff272727)),),),
                    Padding(padding: EdgeInsets.only(bottom:8),child: Text(item['size'].toString()+' г'),),
                    if (item['dops'].join()!='')
                      Padding(padding: EdgeInsets.all(0),child: Text('+ '+dopstext),),
                  ],
                ),
                Container(
                  // alignment: Alignment.topRight,

                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,

                    children: [
                      SizedBox(height:30),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffA0130C),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        padding: EdgeInsets.only(left:7,right:7,top:1,bottom: 1),
                        child: Row(
                          children: [
                            InkWell(child: Text('–',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),onTap: ()async{
                              if (count != 1){
                                var a =  countchange('-',item['pk']);
                                fo();
                                setState(() {
                                  count -= 1;
                                });
                              }
                            },),
                            Padding(padding: EdgeInsets.only(left:10,right:10),child: Text(count.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize:14))),
                            InkWell(child: Text('+',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),onTap: ()async{
                              var a =  countchange('+',item['pk']);
                              fo();
                              setState(() {
                                count += 1;
                              });
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Text((item['price']+dopstotal).toString()+' ₽',style: TextStyle(fontSize:17,fontWeight: FontWeight.w600)),
                      ),
                    ],
                  )
                )
              ],
            ),),
          ],
        ),
      ),
    );
  }
}





class CartItem extends StatefulWidget {
  var item;
  Function fo;
  Function fo1;
  CartItem({ Key? key,required this.item,required this.fo,required this.fo1 }) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState(item:item,fo:fo,fo2:fo1);
}

class _CartItemState extends State<CartItem>  {
  var count = 1;
  void doNothing(){}
  var item;
  Function fo;
  Function fo2;
  var dopstotal = 0;
  var dopstext = '';
  @override
  void initState(){
     count = item['count'];
    super.initState();
    for (var i in item['dops']){
      dopstotal += int.parse(i['price']);
      dopstext += i['title'].toString()+' ';
    }
  }
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
    Future<void> delitem(int pk) async{
    var a = await getDeviceId();
      var b = await http.get(
        Uri.parse(baseurl+'delfromcartapp/?id='+pk.toString()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'session_key':''
          }
      );
      // var c = await fo2();
    }
  Future<void> countchange(String pm,int pk) async{
    var a = await getDeviceId();
    if(pm == '+'){
      var b = await http.get(
        Uri.parse(baseurl+'changeitemcartapp/?id='+pk.toString()+'&pm=%2B'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'session_key':''
          }
      );
    }else{
      var b = await http.get(
        Uri.parse(baseurl+'changeitemcartapp/?id='+pk.toString()+'&pm=-'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'session_key':''
          }
      );
    }
    // return int.parse( b.body);

  }
  _CartItemState({required this.item,required this.fo, required this.fo2});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key:  UniqueKey(),
      endActionPane:  ActionPane(
        extentRatio: 0.25,
          dismissible: DismissiblePane(onDismissed: () async{
            var a = await delitem(item['pk']);
            var c = await fo2();
            fo();
           
          }),
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            
            backgroundColor: Color(0xffA0130C),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Удалить',
            onPressed: (context)async{
               var a = await delitem(item['pk']);
            var c = await fo2();
            fo();
            },
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(left: 20,right:20,bottom:10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(baseurl+'media/'+item['img'],width: 80,fit:BoxFit.cover),
            
            SizedBox(width:18),

            Expanded(flex: 7,child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(bottom:8),child: Text(item['title'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color:Color(0xff272727)),),),
                    Padding(padding: EdgeInsets.only(bottom:8),child: Text(item['size'].toString()+' см'),),
                    if (item['dops'].join()!='')
                      Padding(padding: EdgeInsets.all(0),child: Text('+ '+dopstext),),
                  ],
                ),
                Container(
                  // alignment: Alignment.topRight,

                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,

                    children: [
                      SizedBox(height:30),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffA0130C),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        padding: EdgeInsets.only(left:7,right:7,top:1,bottom: 1),
                        child: Row(
                          children: [
                            InkWell(child: Text('–',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),onTap: ()async{
                              if (count != 1){
                                var a =  countchange('-',item['pk']);
                                fo();
                                setState(() {
                                  count -= 1;
                                });
                              }
                            },),
                            Padding(padding: EdgeInsets.only(left:10,right:10),child: Text(count.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize:14))),
                            InkWell(child: Text('+',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),onTap: ()async{
                              var a =  countchange('+',item['pk']);
                              fo();
                              setState(() {
                                count += 1;
                              });
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Text((item['price']+dopstotal).toString()+' ₽',style: TextStyle(fontSize:17,fontWeight: FontWeight.w600)),
                      ),
                    ],
                  )
                )
              ],
            ),),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({ Key? key }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}



class _CartPageState extends State<CartPage> {
  late Future<List> check_loggined_var; 
  var loggined;
  late Future <List<ProductToCart>> futureAlbum;
  late Future <List<ProductToCartDefault>> futureAlbumDafault;

  late Future <List<ProductsCart>> futureAlbumDops;

  late Future<int> totalcartvar;
  late Future<int> checkpromocodevar;
  var promocontroller = TextEditingController();
  // var promocodeans = 
  var errprom = false;
    late Future<List>  user;
  var bonususe = false;
  @override
  void initState() {
    super.initState();
    check_loggined_var =  check_loggin();
    futureAlbum = fetchAlbum();
    futureAlbumDops = fetchAlbumDops();
    futureAlbumDafault = fetchAlbumDefault();

    totalcartvar = totalcart();
    checkpromocodevar = checkpromocode();
    user = getuser();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
  Future<List> check_loggin() async{
    var a = await getDeviceId();
    var b = await http.get(
      Uri.parse(baseurl+'checklogginedcart/?device='+a),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
    print(json.decode(b.body)['phone'].toString()+ 'check loggined function');
    bool g = json.decode(b.body)['loggined'] =='True';
    return [g,json.decode(b.body)['phone'].toString()];
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
  Future<int> checkpromocode() async{
    var a = await getDeviceId();
   var b = await http.get(
      Uri.parse(baseurl+'checkpromocade/?device='+a),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
    return int.parse( b.body);
  }
  Future<int> promocodetocart() async{
    var a = await getDeviceId();
    var b = await http.get(
      Uri.parse(baseurl+'promocodetocart/?device='+a+'&promocode='+promocontroller.text),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_key':''
        }
    );
    return int.parse( b.body);
  }
  
  void totalrefresh(){
    setState(() {
      totalcartvar = totalcart();
      checkpromocodevar = checkpromocode();
    });
  }
  void errpromvoid(){
    print('===-==-=---=-==-=-=-');
    setState(() {
      errprom = true;
      check_loggined_var =  check_loggin();
      // check_loggined_var =  check_loggin();
      futureAlbum = fetchAlbum();
    });
  }
  void cartrefresh(){
    setState(() {
      check_loggined_var =  check_loggin();
      futureAlbum = fetchAlbum();
      totalcartvar = totalcart();
      checkpromocodevar = checkpromocode();
      // futureAlbum = fetchAlbum();
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: check_loggined_var,
        builder: (context, snapshot) {
          if (snapshot.hasData){
            if(snapshot.data![0] == true){loggined = true;}else{loggined=false;}
              return ListView(
                children: [
                  if (loggined == true)
                    Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('Корзина',style: TextStyle(fontWeight: FontWeight.w600,color: Color(0xff272727),fontSize: 30),),
                      ),
                      // CartItem(),
                      Container(
                        margin: EdgeInsets.only(left:0,right:0),
                        child:SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: FutureBuilder<List<ProductToCart>>(
                              future: futureAlbum,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Wrap(
                                    spacing: 10.0,
                                    runSpacing: 10.0,
                                    children: [
                                      // item.image_url
                                      for (var item1 in snapshot.data!) CartItem(item:{'title':item1.title,'price':item1.price,'dops':item1.dops,'size':item1.size,'count':item1.count,'pk':item1.id,'img':item1.image_url},fo:totalrefresh,fo1:cartrefresh)
                                    ]
                                  );
                                } 
                                else if (snapshot.connectionState != ConnectionState.done){
                                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA0130C))));
                                }
                                else {
                                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA0130C))));
                                }
                              }
                            ),
                          ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left:0,right:0),
                        child:SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: FutureBuilder<List<ProductToCartDefault>>(
                              future: futureAlbumDafault,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Wrap(
                                    spacing: 10.0,
                                    runSpacing: 10.0,
                                    children: [
                                      // item.image_url
                                      for (var item1 in snapshot.data!) CartItemDefault(item:{'title':item1.title,'price':item1.price,'dops':item1.dops,'size':item1.weight,'count':item1.count,'pk':item1.id,'img':item1.image_url},fo:totalrefresh,fo1:cartrefresh)
                                    ]
                                  );
                                } 
                                else if (snapshot.connectionState != ConnectionState.done){
                                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA0130C))));
                                }
                                else {
                                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA0130C))));
                                }
                              }
                            ),
                          ),
                      ),
                      Padding(padding: EdgeInsets.only(left:20,top:15,bottom:7),child: Text('Добавить к заказу?',style: TextStyle(fontWeight: FontWeight.w600,color: Color(0xff272727),fontSize: 19)),),
                      Container(
                        height:120,
                        margin: EdgeInsets.only(bottom: 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(top:10,bottom: 10),
                          child: FutureBuilder<List<ProductsCart>>(
                              future: futureAlbumDops,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Wrap(
                                    spacing: 10.0,
                                    runSpacing: 10.0,
                                    children: [
                                      // item.image_url
                                      for (var item1 in snapshot.data!) InkWell(child: Container(
                                            width: 200,
                                            margin: EdgeInsets.only(left:20),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15.0),
                                              color:Color(0xffFFEED1),
                                              boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.3),
                                                    spreadRadius: 3,
                                                    blurRadius: 4,
                                                    offset: Offset(-2, 4), // changes position of shadow
                                                  ),
                                                ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Image.network(baseurl+'media/'+item1.fields['img'],width: 65,fit:BoxFit.cover),
                                                    SizedBox(width:10),
                                                    Flexible(child:Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                                      Padding(padding: EdgeInsets.only(bottom:7),child: Text(item1.fields['title'],style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color:Color(0xff272727)),),),
                                                      Padding(padding: EdgeInsets.only(bottom:7),child:Text(item1.fields['weight'].toString()+' гр.',softWrap: true,overflow: TextOverflow.clip,style: TextStyle(color:Color(0xff444444),fontSize: 12,fontWeight: FontWeight.w400),),),
                                                      Container(padding: EdgeInsets.only(top:3,bottom: 3,left:7,right: 7),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          color: Color(0xffA0130C),
                                                        ),
                                                        child: Text(item1.fields['price'].toString()+' ₽',style: TextStyle(color:Colors.white,fontSize: 13,fontWeight: FontWeight.w600),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: (){
                                        item1.fields['pk'] = item1.pk;
                                        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<bool>(fullscreenDialog: true,builder: (BuildContext context) => ItemDefaultPage(item:item1.fields)),);
                                      },
                                      )
                                    ]
                                  );
                                } 
                                else if (snapshot.connectionState != ConnectionState.done){
                                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA0130C))));
                                }
                                else {
                                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA0130C))));
                                }
                              }
                            ),
                        )
                      ),  
                      FutureBuilder<int>(
                        future: checkpromocodevar,
                        builder: (context, snapshot) {
                          if (snapshot.hasData){
                            print(snapshot.data!);
                            // return Text(snapshot.data!.toString()+' ₽',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),);
                            if (snapshot.data! == 400){
                              return Center(
                                child:InkWell( 
                                  onTap: (){
                                    Scaffold.of(context).showBottomSheet<void>(
                                      (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
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
                                                Padding(padding:EdgeInsets.only(left:20,right:20,top:20,bottom: 15),child: Text('Введите промокод',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),),
                                                // DropDown(fo:setName),
                                                SizedBox(
                                                  width:260,
                                                  // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                  child: TextField(
                                                    controller: promocontroller,
                                                    minLines: 1,
                                                    maxLines: 1,
                                                    style: TextStyle(fontSize: 15),
                                                    decoration: InputDecoration(
                                                      fillColor: Color(0xffFFEED1),
                                                      contentPadding: EdgeInsets.all(7.0),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Color(0xffA0130C),width:errprom? 3:1)
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Color(0xffA0130C), width: errprom? 3:1),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Color(0xffA0130C), width: errprom? 3:1),
                                                      ),
                                                      isDense: true,
                                                      hintText: 'Промокод',
                                                      filled: true,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(onTap: () async{
                                                  // fo(cafename);
                                                  var a = await getDeviceId();
                                                  var b = await http.get(
                                                    Uri.parse(baseurl+'promocodetocart/?device='+a+'&promocode='+promocontroller.text),
                                                      headers: <String, String>{
                                                        'Content-Type': 'application/json; charset=UTF-8',
                                                        'session_key':''
                                                      }
                                                  );
                                                  print('=====');
                                                  print(int.parse(b.body));
                                                  if (int.parse(b.body) == 200){
                                                    await promocodetocart();
                                                    cartrefresh();
                                                    // cartrefresh();
                                                    Navigator.pop(context);
                                                  }else{
                                                    setState(() {
                                                      errprom = true;
                                                    });
                                                    errpromvoid();
                                                  }
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
                                        });
                                      }
                                    );
                                  },
                                  child:Container(
                                    margin: const EdgeInsets.only(left:15.0,right:15,top:15),
                                    padding: const EdgeInsets.only(top:7,bottom:7,left: 20,right:20),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xffA0130C),width: 1),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    child: Wrap(children: [Text('Промокод',style: TextStyle(color: Color(0xffA0130C),fontSize: 20,fontWeight: FontWeight.w600),),])
                                  ),
                                )
                              );
                            }else{
                              return Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top:13),
                                child:Text('Вы использовали промокод на '+ snapshot.data!.toString()+ '%')
                              );
                            }
                          }
                          else{
                            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
                          }
                        },
                      ),
                      
                      Container(
                        margin: const EdgeInsets.only(left:20.0,right:20,top:10),
                        padding: const EdgeInsets.only(top:10,bottom:10,left: 20,right:20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xffA0130C),
                          borderRadius: BorderRadius.all(Radius.circular(80))
                        ),
                        child: InkWell(child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text('Оформить заказ на ',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                            FutureBuilder<int>(
                              future: totalcartvar,
                              builder: (context, snapshot) {
                                if (snapshot.hasData){
                                  return Text(snapshot.data!.toString()+' ₽',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),);
                                }
                                else{
                                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
                                }
                              }
                            )
                          ]),
                          onTap: () {
                                  Scaffold.of(context).showBottomSheet<void>(
                                    (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                        return FutureBuilder<List>(
                                          future: user,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData){
                                              return SizedBox(
                                                height: 300,
                                                child: Column(children: [
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
                                                        margin: EdgeInsets.symmetric(vertical: 15),
                                                        child: Text('Использовать бонусы',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(bottom: 20),
                                                        child: Text('У вас '+snapshot.data![0][0]['bonuses'].toString()+' бонусов',style: TextStyle(fontSize: 17),),
                                                      ),
                                                      InkWell(
                                                        child: Container(
                                                          margin: const EdgeInsets.only(left:20.0,right:20,top:10),
                                                          padding: const EdgeInsets.only(top:10,bottom:10,left: 20,right:20),
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color: Color(0xffA0130C),
                                                            borderRadius: BorderRadius.all(Radius.circular(80))
                                                          ),
                                                          child: Text('Использовать',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600)),
                                                        ),
                                                        onTap: (){
                                                          setState((){
                                                            bonususe = true;
                                                          });
                                                                                                               Navigator.pop(context);

                                                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<bool>(fullscreenDialog: true,builder: (BuildContext context) => OrderCreate(bonusesuse:true)),);


                                                        },
                                                      ),
                                                      InkWell(
                                                        child: Container(
                                                          margin: const EdgeInsets.only(left:20.0,right:20,top:10),
                                                          padding: const EdgeInsets.only(top:10,bottom:10,left: 20,right:20),
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey[200],
                                                            borderRadius: BorderRadius.all(Radius.circular(80))
                                                          ),
                                                          child: Text('Пропустить',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600)),
                                                        ),
                                                        onTap: (){
                                                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<bool>(fullscreenDialog: true,builder: (BuildContext context) => OrderCreate(bonusesuse:false)),);

                                                        },
                                                      ),
                                                  // Text('asd')
                                                ],),
                                              );
                                            }else{
                                              return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
                                            }
                                          }
                                        );
                                      }
                                  );
                                  // Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDone()));

                              }
                            );

                          },
                        )
                      ),
                      SizedBox(height: 60,)
                    ],
                  )
                else 
                  Column(
                    children: [
                      SizedBox(height: 110,),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20,horizontal: 80),
                        padding: EdgeInsets.only(top:20),
                        child:Image.asset('assets/images/cartempty.png')
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:30),
                        child: Text('Ваша корзина пуста.\nВыберите понравившийся \nтовар в меню.',textAlign: TextAlign.center,style: TextStyle(fontSize: 17),),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:20),
                        padding: EdgeInsets.symmetric(vertical:7,horizontal: 18),
                        decoration: BoxDecoration(
                          color:Color(0xffA0130C),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Меню',style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                    ],
                  )
              ]);
        }
        else{
          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE94F26))));
        }
      }
    );
  }
  Future <List<ProductToCart>> fetchAlbum() async {
    var a = await getDeviceId();
      final response =
          await http.get(Uri.parse(baseurl+'api/productstocartapp/'+a+'/?format=json'));
        print(a);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
        return parsed.map<ProductToCart>((json) => ProductToCart.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load album');
      }
  }
  Future <List<ProductToCartDefault>> fetchAlbumDefault() async {
    var a = await getDeviceId();
      final response =
          await http.get(Uri.parse(baseurl+'api/productstocartdefaultapp/'+a+'/?format=json'));
        print(a);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
        return parsed.map<ProductToCartDefault>((json) => ProductToCartDefault.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load album');
      }
  }
  Future <List<ProductsCart>> fetchAlbumDops() async {
    var a = await getDeviceId();
      final response =
          await http.get(Uri.parse(baseurl+'cartproducts/?device='+a));
        print(a);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
        return parsed.map<ProductsCart>((json) => ProductsCart.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load album');
      }
  }
}



