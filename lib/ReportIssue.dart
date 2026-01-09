import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renttech/Error.dart';

class ReportIssue extends StatefulWidget {
  const ReportIssue({super.key});

  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {

  final FirebaseAuth _auth=FirebaseAuth.instance;
  CollectionReference ref=FirebaseFirestore.instance.collection('Reports');
  final _key=GlobalKey<FormState>();
  final titleController=TextEditingController();
  final desController=TextEditingController();
  bool load=false;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: const Color(0xffF5EFE6),
     appBar: AppBar(
       title: const Text("Report"),
       backgroundColor: const Color(0xffF5EFE6),
     ),
     body: Padding(
       padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
       child: ListView(
         children: [
           Text("We're here to help! If you’ve encountered a problem while using RentTech, please describe your issue below. Our team will review and get back to you as soon as possible.",
           style: TextStyle(fontSize: 15,color: Colors.black.withValues(alpha: 0.6),fontWeight: FontWeight.w600),textAlign: TextAlign.justify,),
           const SizedBox(height: 15,),
           Form(
             key: _key,
               child: Column(children: [
             TextFormField(
               keyboardType: TextInputType.text,
               decoration: InputDecoration(hintText: "Title",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.5)),border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                   focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff4F6F52)))),
               controller: titleController,
               validator: (value){
                 if(value==null || value.isEmpty){
                   return "Title is required";
                 } else {
                   return null;
                 }
               },
             ),
             const SizedBox(height: 25,),
             TextFormField(
               keyboardType: TextInputType.text,
               maxLines: 5,
               decoration: InputDecoration(hintText: "Description",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.5)),border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                   focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff4F6F52)))),
               controller: desController,
               validator: (value){
                 if(value==null || value.isEmpty){
                   return "Description is required";
                 } else {
                   return null;
                 }
               },
             ),
           ],)),
           const SizedBox(height: 30,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Container(
                 height: 45,
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.grey)),
                 child: TextButton(
                   child: Padding(
                     padding: const EdgeInsets.only(left: 20,right: 20),
                     child: Text("Cancel",style: TextStyle(fontSize: 16,color: Colors.black.withValues(alpha: 0.6),fontWeight: FontWeight.w600),),
                   ),
                   onPressed: (){
                     Navigator.pop(context);
                   },
                 ),
               ),
               Container(
                 height: 45,
                 decoration: BoxDecoration(color: const Color(0xff4F6F52),borderRadius: BorderRadius.circular(5)),
                 child: TextButton(
                   child: Padding(
                     padding: const EdgeInsets.only(left: 20,right: 20),
                     child: load?const CircularProgressIndicator(color: Colors.white,) :const Text("Submit",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),),
                   ),
                   onPressed: () async {
                     setState(() {
                       load=true;
                     });
                     if(_key.currentState!.validate()){
                       final String unique=DateTime.now().millisecondsSinceEpoch.toString();
                       DocumentSnapshot data=await FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).get();
                       await ref.doc(unique).set({
                         'title':titleController.text.toString(),
                         'description':desController.text.toString(),
                         'userName':data['name'].toString(),
                         'userID':data.id.toString(),
                         'userEmail':data['email'].toString()
                       }).then((onValue){
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Report submitted")));
                         Navigator.pop(context);
                       }).onError((error, stackTrace){
                         setState(() {
                           load=false;
                           Error().toastMessage(error.toString());
                         });
                       });
                     } else {
                       setState(() {
                         load=false;
                       });
                     }
                   },
                 ),
               )
             ],
           ),
           const SizedBox(height: 200,),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text("Rent Tech",style: GoogleFonts.akayaTelivigala(textStyle: TextStyle(fontSize: 25,color: Colors.black.withValues(alpha: 0.1)),),),
             ],
           ),
         ],
       ),
     ),
   );
  }
}