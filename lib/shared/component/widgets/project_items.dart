import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
Widget LoginOrRegister({
  required TextEditingController controller,
  required    FormFieldValidator function,
  required Icon prefixIcon,
  required String label,
  required Color TextFormLabelColor,
  Icon? suffixIcon

}) => Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.blueGrey[800],
    boxShadow: [
      BoxShadow(
        color: Colors.blueGrey[900]! ,
        blurRadius: 30,
        spreadRadius: 1.0,
        inset: false
            
      ),

    ]
  ),
  child:   TextFormField(
        controller: controller,
        validator: function,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: prefixIcon,
            labelText: label,
            suffixIcon: suffixIcon,
            labelStyle: TextStyle(color: TextFormLabelColor)),
      ),
);
Widget SettingsField({
  required TextEditingController controller,
  required    FormFieldValidator function,
  required Icon prefixIcon,
  required String label,
  required Color TextFormLabelColor,
  Icon? suffixIcon

}) => Container(
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey[200],
      boxShadow: [
        BoxShadow(
            color: Colors.grey[300]! ,
            blurRadius: 30,
            spreadRadius: 1.0,
            inset: false

        ),

      ]
  ),
  child:   TextFormField(
    controller: controller,
    validator: function,
    decoration: InputDecoration(
        border:OutlineInputBorder(
          gapPadding: 4.0
        ),
        prefixIcon: prefixIcon,
        labelText: label,
        suffixIcon: suffixIcon,
        labelStyle: TextStyle(color: TextFormLabelColor)),
  ),
);

Widget OurMaterialButton({
  required VoidCallback function,
required String text,
  double? width,
  double? height,

})=>
    MaterialButton(onPressed: function
      ,child: Container(
        width: width,
        height:height ,
        decoration: BoxDecoration(
            color: Colors.blueGrey[800],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.blueGrey[900]!,
                  blurRadius: 30,
                  spreadRadius: 1.0,
                  inset:false
              )
            ]
        ),
        child: Center(
          child: Text(text,style: TextStyle(color: Colors.white),),
        ),
      ),);

Widget OnBordingItem({obBoardingItem})
{
  return Column(
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(15),
            child: Image(image: AssetImage('${obBoardingItem.image}'))),
      ),
      SizedBox(height: 10,),
      Text('${obBoardingItem.title}',style: TextStyle(fontSize: 20,color:Colors.blueGrey ),),
    ],
  );
}
