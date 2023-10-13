import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'classes.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


String dateformater(String date ){
  List<String> a = date.split(' ');
  Map li = {	
    'January':'января',
    'February':'февраля',	
    'March':'марта',
    'April':'апреля'	,
    'May':'мая'	,
    'June':'июня'	,
    'July':'июля'	,
    'August':'августа'	,
    'September':'сентября'	,
    'October':'октября'	,
    'November'	:'ноября',
    'December':'декабря'	,
  };
  String z = a[1];
  a[1] = li[z];
  String r = a[0] +' '+ a[1] +' '+ a[2]+' '+a[3];
  return r;
}

class History extends StatefulWidget {
  const History({ Key? key }) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}
  Future <List<OrderClass>> fetchAlbum() async {
    var a = await getDeviceId();
      final response =
          await http.get(Uri.parse(baseurl+'api/userorders/'+a+'/?format=json'));
        print(a);

      if (response.statusCode == 200) {
        print(response);
        final parsed = jsonDecode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
        return parsed.map<OrderClass>((json) => OrderClass.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load album');
      }
  }
class _HistoryState extends State<History> {
  late Future <List<OrderClass>> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Padding(padding: EdgeInsets.symmetric(vertical:10,horizontal: 20),child:Column(children: [
              // Container(
              //   decoration: BoxDecoration(
              //     color: Color(0xffFFEED1),
              //     borderRadius: BorderRadius.all(Radius.circular(20)),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.shade300,
              //         offset: Offset.zero,
              //         blurRadius: 5,
              //         spreadRadius: 3
              //       )
              //     ]
              //   ),
              //   child:Padding(
              //     child:Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Padding(padding: EdgeInsets.all(0),child: Text('Заказ №111',style: TextStyle(color:Color(0xff939393),fontSize: 13)),),
              //           Padding(padding: EdgeInsets.all(0),child: Text('22 декабря 2021 г. в 23:07',style: TextStyle(color:Color(0xff272727),fontSize: 15),),)
              //         ],
              //       ),
              //       Padding(padding: EdgeInsets.only(top:8,bottom:10),child: Text('На доставку',style: TextStyle(color:Color(0xff939393),fontSize: 15)),),
              //       Padding(padding: EdgeInsets.only(bottom:10),child: Text('Ярославль, ул. Блюхера, д. 34',style: TextStyle(color:Color(0xff272727),fontSize: 15),),),
              //       Padding(padding: EdgeInsets.all(0),child: Row(children: [
              //         Container(padding: EdgeInsets.only(right:10),child:Image.asset('assets/images/product.png',width: 45,fit: BoxFit.cover,)),
              //         Container(padding: EdgeInsets.only(right:10),child:Image.asset('assets/images/product.png',width: 45,fit: BoxFit.cover)),
              //         Container(padding: EdgeInsets.only(right:10),child:Image.asset('assets/images/product.png',width: 45,fit: BoxFit.cover)),
              //       ],),),
              //       Padding(padding: EdgeInsets.only(top:15),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           children: [
              //             Container(
              //               padding:EdgeInsets.symmetric(vertical:7,horizontal:15),
              //               decoration: BoxDecoration(
              //                 color: Color(0xffA0130C),
              //                 borderRadius: BorderRadius.all(Radius.circular(20))
              //               ),
              //               child: Text('Повторить заказ',style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize: 17),),
              //             ),
              //             Container(child: Text('993 ₽ ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),)
              //           ],
              //         ),
              //       )
              //     ],),
              //     padding: EdgeInsets.all(15),
              //   )
              // ),
    //           Container(
    //             margin: EdgeInsets.only(top:15),
    //             decoration: BoxDecoration(
    //               color: Color(0xffFFEED1),
    //               borderRadius: BorderRadius.all(Radius.circular(20)),
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Colors.grey.shade300,
    //                   offset: Offset.zero,
    //                   blurRadius: 5,
    //                   spreadRadius: 3
    //                 )
    //               ]
    //             ),
    //             child:Padding(
    //               child:Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Padding(padding: EdgeInsets.all(0),child: Text('Заказ №111',style: TextStyle(color:Color(0xff939393),fontSize: 13)),),
    //                     Padding(padding: EdgeInsets.all(0),child: Text('22 декабря 2021 г. в 23:07',style: TextStyle(color:Color(0xff272727),fontSize: 15),),)
    //                   ],
    //                 ),
    //                 Padding(padding: EdgeInsets.only(top:8,bottom:10),child: Text('На доставку',style: TextStyle(color:Color(0xff939393),fontSize: 15)),),
    //                 Padding(padding: EdgeInsets.only(bottom:10),child: Text('Ярославль, ул. Блюхера, д. 34',style: TextStyle(color:Color(0xff272727),fontSize: 15),),),
    //                 Padding(padding: EdgeInsets.all(0),child: Row(children: [
    //                   Container(padding: EdgeInsets.only(right:10),child:Image.asset('assets/images/product.png',width: 45,fit: BoxFit.cover,)),
    //                   Container(padding: EdgeInsets.only(right:10),child:Image.asset('assets/images/product.png',width: 45,fit: BoxFit.cover)),
    //                   Container(padding: EdgeInsets.only(right:10),child:Image.asset('assets/images/product.png',width: 45,fit: BoxFit.cover)),
    //                 ],),),
    //                 Padding(padding: EdgeInsets.only(top:15),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     children: [
    //                       Container(
    //                         padding:EdgeInsets.symmetric(vertical:7,horizontal:15),
    //                         decoration: BoxDecoration(
    //                           color: Color(0xffA0130C),
    //                           borderRadius: BorderRadius.all(Radius.circular(20))
    //                         ),
    //                         child: Text('Повторить заказ',style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize: 17),),
    //                       ),
    //                       Container(child: Text('993 ₽ ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),)
    //                     ],
    //                   ),
    //                 )
    //               ],),
    //               padding: EdgeInsets.all(15),
    //             )
    //           ),
    //           Container(
    //             margin: EdgeInsets.only(top:15),
    //             decoration: BoxDecoration(
    //               color: Color(0xffFFEED1),
    //               borderRadius: BorderRadius.all(Radius.circular(20)),
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Colors.grey.shade300,
    //                   offset: Offset.zero,
    //                   blurRadius: 5,
    //                   spreadRadius: 3
    //                 )
    //               ]
    //             ),
    //             child:Padding(
    //               child:Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Padding(padding: EdgeInsets.all(0),child: Text('Заказ №111',style: TextStyle(color:Color(0xff939393),fontSize: 13)),),
    //                     Padding(padding: EdgeInsets.all(0),child: Text('22 декабря 2021 г. в 23:07',style: TextStyle(color:Color(0xff272727),fontSize: 15),),)
    //                   ],
    //                 ),
    //                 Padding(padding: EdgeInsets.only(top:8,bottom:10),child: Text('На доставку',style: TextStyle(color:Color(0xff939393),fontSize: 15)),),
    //                 Padding(padding: EdgeInsets.only(bottom:10),child: Text('Ярославль, ул. Блюхера, д. 34',style: TextStyle(color:Color(0xff272727),fontSize: 15),),),
    //                 Padding(padding: EdgeInsets.all(0),child: Row(children: [
    //                   Container(padding: EdgeInsets.only(right:10),child:Image.asset('assets/images/product.png',width: 45,fit: BoxFit.cover,)),
    //                   Container(padding: EdgeInsets.only(right:10),child:Image.asset('assets/images/product.png',width: 45,fit: BoxFit.cover)),
    //                   Container(padding: EdgeInsets.only(right:10),child:Image.asset('assets/images/product.png',width: 45,fit: BoxFit.cover)),
    //                 ],),),
    //                 Padding(padding: EdgeInsets.only(top:15),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     children: [
    //                       Container(
    //                         padding:EdgeInsets.symmetric(vertical:7,horizontal:15),
    //                         decoration: BoxDecoration(
    //                           color: Color(0xffA0130C),
    //                           borderRadius: BorderRadius.all(Radius.circular(20))
    //                         ),
    //                         child: Text('Повторить заказ',style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize: 17),),
    //                       ),
    //                       Container(child: Text('993 ₽ ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),)
    //                     ],
    //                   ),
    //                 )
    //               ],),
    //               padding: EdgeInsets.all(15),
    //             )
    //           )
    //         ],)
    //       ),
    // );
    return Container(
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<OrderClass>>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [
                    // item.image_url
                    for (var item1 in snapshot.data!) Padding(padding: EdgeInsets.symmetric(horizontal:20,vertical:10),child:Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFEED1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: Offset.zero,
                            blurRadius: 5,
                            spreadRadius: 3
                          )
                        ]
                      ),
                      child:Padding(
                        padding: EdgeInsets.all(15),
                        child:Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.all(0),child: Text('Заказ №'+item1.id,style: TextStyle(color:Color(0xff939393),fontSize: 13)),),
                              Padding(padding: EdgeInsets.all(0),child: Text(dateformater(item1.date),style: TextStyle(color:Color(0xff272727),fontSize: 15),),)
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top:8,bottom:10),child: Text(item1.status,style: TextStyle(color:Color(0xff939393),fontSize: 15)),),
                          Padding(padding: EdgeInsets.only(bottom:10),child: Text(item1.address,style: TextStyle(color:Color(0xff272727),fontSize: 15),),),
                          Padding(padding: EdgeInsets.all(0),child: Row(children: [
                            // Container(padding: EdgeInsets.only(right:10),child:Image.asset('assets/images/product.png',width: 45,fit: BoxFit.cover,)),
                            // Container(padding: EdgeInsets.only(right:10),child:Image.asset('assets/images/product.png',width: 45,fit: BoxFit.cover)),
                            // Container(padding: EdgeInsets.only(right:10),child:Image.asset('assets/images/product.png',width: 45,fit: BoxFit.cover)),
                            for (var i in item1.products) Container(padding: EdgeInsets.only(right:10),child:Image.network(baseurl+'media/'+i['img'],width: 45,fit: BoxFit.cover,)),
                            for (var i in item1.productsdefault) Container(padding: EdgeInsets.only(right:10),child:Image.network(baseurl+'media/'+i['img'],width: 45,fit: BoxFit.cover,)),
                          ],),),
                          Padding(padding: EdgeInsets.only(top:15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding:EdgeInsets.symmetric(vertical:7,horizontal:15),
                                  decoration: BoxDecoration(
                                    color: Color(0xffA0130C),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: Text('Повторить заказ',style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize: 17),),
                                ),
                                Container(child: Text(item1.price.toString()+' ₽ ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),)
                              ],
                            ),
                          )
                        ],),
                      )
                    )),
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
    );
  }
}


class HistoryPage extends StatelessWidget {
    Function fo = (){};
   HistoryPage({ Key? key,required this.fo }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

            Padding(padding: EdgeInsets.all(20),child:Text('История заказов',style: TextStyle(fontWeight: FontWeight.w600,color: Color(0xff272727),fontSize: 30))),
            History(),
          ]
      )
    );
  }
}