import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note1/style/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.CardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            doc['note_title'],
            style: AppStyle.mainTitle,
          ),
          SizedBox(height: 4.0,),
          Text(doc['creation_date'],style: AppStyle.dateTitle,),
          SizedBox(height: 8.0,),
          Text(doc['note_content'],style: AppStyle.mainContent,overflow: TextOverflow.ellipsis,),

          SizedBox(height: 10,),
       Row(
         mainAxisAlignment: MainAxisAlignment.end,
         children: [ IconButton(
         onPressed: (){
           delete(doc.id);
         },
         icon: Icon(Icons.delete_outline,color: Color(0xFF000633)
             ),
       )],)
        ],
      ),
    ),
  );

}
delete(item){
  DocumentReference documentReference=
  FirebaseFirestore.instance.collection("Notes").doc(item);
  documentReference.delete().whenComplete(() => print("successfully deleted"));
}