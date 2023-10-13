import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlng/latlng.dart';
// import 'package:latlong2/latlong.dart'; 
import 'package:flutter_svg/flutter_svg.dart';
import 'policy.dart';
import 'callback.dart';
import 'about.dart';
class ContactPage extends StatelessWidget {
  Function fo = (){};
  ContactPage({ Key? key, required this.fo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
        child : ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(padding: EdgeInsets.all(20),child: Container(alignment: Alignment.centerLeft, child:Image.asset('assets/images/logo.png',width: 75,fit: BoxFit.cover,)),),
            Padding(padding: EdgeInsets.only(left:20,bottom: 10),child: Text('Мы на карте',style: TextStyle(fontWeight: FontWeight.w600,color: Color(0xff272727),fontSize: 30)),),
            
            // SizedBox(
            //   width: 200.0,
            //   height: 300.0,
            //   child:Container(
            //     padding: const EdgeInsets.all(8),
            //     child: const YandexMap()
            //   )
            // )
            // Container(height:220,child: 
            // // FlutterMap(
            // //   options: MapOptions(
            // //     center: LatLng( 39.866123, 57.650724),
            // //     zoom:5.05,
            // //   ),
            // //   layers: [
            // //     TileLayerOptions(
            // //       urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            // //       subdomains: ['a', 'b', 'c'],
            // //       attributionBuilder: (_) {
            // //         return Text("© OpenStreetMap contributors");
            // //       },
            // //     ),
            // //     MarkerLayerOptions(
            // //       markers: [
            // //         Marker(
            // //           width: 80.0,
            // //           height: 80.0,
            // //           point: LatLng(39.866123,57.650724),
            // //           builder: (ctx) =>
            // //           Container(
            // //             child: Text('Ярославль'),
            // //           ),
            // //         ),
            // //       ],
            // //     ),
            // //   ],
            // // ),),
            // Padding(padding: EdgeInsets.all(0),child: Text('Связаться с нами'),),
            Padding(padding: EdgeInsets.only(left:20,bottom: 20,top:30),child: Container(child: Text('Связаться с нами',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600,color:Color(0xff272727)),),),),
            Padding(padding:EdgeInsets.all(0), child: Row(children: [
              Container(
                padding: EdgeInsets.only(left:20,right:19,top:5,bottom:6),
                margin: EdgeInsets.only(left:20,right:15),
                decoration: BoxDecoration(
                  color: Color(0xffA0130C),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Text('Позвонить',style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600,fontSize: 19),),
              ),
              Container(
                padding: EdgeInsets.only(left:20,right:19,top:5,bottom:6),
                // margin: EdgeInsets.only(left:20,right:15),
                decoration: BoxDecoration(
                  color: Color(0xffA0130C),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: InkWell(child:Text('Обратная связь',style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600,fontSize: 19),),onTap: (){
                  // Navigator.of(context, rootNavigator: true).push(
                  //   MaterialPageRoute<bool>(fullscreenDialog: true,builder: (BuildContext context) => CalbackPage()),
                  // );
                  fo();
                },),
                )

            ],)),
            Padding(padding: EdgeInsets.only(left:20,top:30,bottom: 20),child: Row(
              children: [
                InkWell(
                  child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    'assets/images/inst.svg',
                    semanticsLabel: 'A red up arrow',
                    width: 27,
                    fit:BoxFit.cover,
                  ),
                ),
                ),
                InkWell(
                  child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    'assets/images/vk.svg',
                    semanticsLabel: 'A red up arrow',
                    width: 27,
                    fit:BoxFit.cover,

                  ),
                ),
                ),
                InkWell(
                  child: Padding(
                  padding: EdgeInsets.only(right: 7),
                  child: SvgPicture.asset(
                    'assets/images/facebook.svg',
                    semanticsLabel: 'A red up arrow',
                    width: 27,
                    fit:BoxFit.cover,

                  ),
                ),
                )
              ],
            ),),

            Padding(
              padding: EdgeInsets.only(left:20,bottom: 15),
              child:InkWell(
                child: Text(
                  'Правовые документы',
                  style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color:Color(0xff272727))
                ),
                onTap: (){
                  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<bool>(fullscreenDialog: true,builder: (BuildContext context) => PolicyPage()),);

                },
              )
            ),
            // Padding(padding: EdgeInsets.only(left:20),child: Text('О приложении',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color:Color(0xff272727))),),
            Padding(
              padding: EdgeInsets.only(left:20,bottom: 15),
              child:InkWell(
                child: Text(
                  'О приложении',
                  style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color:Color(0xff272727))
                ),
                onTap: (){
                  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<bool>(fullscreenDialog: true,builder: (BuildContext context) => AboutPage()),);

                },
              )
            ),

          ]
        )
      
    );
  }
}