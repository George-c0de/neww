import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderDone extends StatelessWidget {
  const OrderDone({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 30,),
        Align(alignment: Alignment.topRight,
            child: InkWell(
                child: InkWell(child:Container(
                  decoration: BoxDecoration(
                    color:Color(0xffFFEED1),
                    borderRadius: BorderRadius.all(Radius.circular(40))
                  ),
                  padding: EdgeInsets.only(left:7,right:7,top:11,bottom:10),
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
              Navigator.pop(context);
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          alignment: Alignment.center,
          width: 190,
          height: 130,
          child: Image.asset('assets/images/logo.png',fit: BoxFit.cover,),
        ),
        Padding(padding: EdgeInsets.only(top:40,bottom: 20),child: Text('Заказ №32402 принят',style: TextStyle(fontSize: 25,color: Color(0xffA0130C),fontWeight: FontWeight.bold),),),
        Padding(padding: EdgeInsets.all(0),child: Text('Спасибо за заказ!\nПримерное время доставки 30 минут.',style: TextStyle(fontSize: 15),textAlign: TextAlign.center,),),
        Padding(padding: EdgeInsets.only(top:250),child: Text('Остались вопросы?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),),
        Container(
          margin: EdgeInsets.only(top:10),
          padding: EdgeInsets.symmetric(horizontal: 17,vertical: 7),
          decoration: BoxDecoration(
            color: Color(0xffA0130C),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Text('Позвонить',style: TextStyle(color:Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
        )


      ],),
    );
  }
}