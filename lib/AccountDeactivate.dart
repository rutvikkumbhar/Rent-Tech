import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Error.dart';

class DeactivateAccount extends StatefulWidget {
  const DeactivateAccount({super.key});

  @override
  State<DeactivateAccount> createState() => _DeactivateAccountState();
}

class _DeactivateAccountState extends State<DeactivateAccount> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  CollectionReference ref=FirebaseFirestore.instance.collection('Delete Account Request');
  final _key=GlobalKey<FormState>();
  final titleController=TextEditingController();
  final desController=TextEditingController();
  bool load=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5EFE6),
        title: const Text("Delete Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
        child: ListView(
          children: [
            Text("To delete your RentTech account, please provide your email and the reason for deletion. This helps us improve our services.",
              style: TextStyle(fontSize: 15,color: Colors.black.withValues(alpha: 0.6),fontWeight: FontWeight.w600),textAlign: TextAlign.justify,),
            const SizedBox(height: 15,),
            Form(
                key: _key,
                child: Column(children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Email",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.5)),border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff4F6F52)))),
                    controller: titleController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Email is required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    decoration: InputDecoration(hintText: "Reason",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.5)),border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff4F6F52)))),
                    controller: desController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Reason is required";
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
                      child: load?const CircularProgressIndicator(color: Colors.white,) :const Text("Send",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),),
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
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request submitted")));
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
            const SizedBox(height: 20,),
            Text("⚠ Note: Once deleted, your account cannot be recovered.",
            style: TextStyle(fontSize: 16,color: Colors.red.withValues(alpha: 0.5),fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
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