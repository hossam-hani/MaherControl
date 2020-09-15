import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 10,bottom:20,right: 10),
    child: Row(children: <Widget>[

      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
        InkWell(child: FaIcon(FontAwesomeIcons.bars),
        onTap: (){
          Scaffold.of(context).openDrawer();
        },)
      ],),

      SizedBox(width: 20,),

      ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset("images/logo.png",height: 45,),            
      ),

      SizedBox(width: 7,),
      Text("Maher",style: TextStyle(fontWeight: FontWeight.w300,fontFamily: "Lato",fontSize:20),),




    ],),);
  }
}