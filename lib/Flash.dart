import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renttech/Maintenance.dart';
import 'package:renttech/WelcomePage.dart';
import 'BottomBar.dart';

class Flash extends StatefulWidget {
  const Flash({super.key});

  @override
  State<Flash> createState() => _FlashState();
}

class _FlashState extends State<Flash> {
CollectionReference ref=FirebaseFirestore.instance.collection('Maintenance');
  @override
  void initState()  {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    Timer(const Duration(seconds: 2),() async {
      DocumentSnapshot data=await ref.doc('maintenance').get();
      if(data['mode']!="on"){
        if(user!=null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder){
            return const BottomBar();
          }));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return const WelcomePage();
          },),);
        }
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return const Maintenance();
        },),);
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8DFCA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,width: 100,
              decoration: BoxDecoration(image: const DecorationImage(image: AssetImage("assets/images/renttechlogo.png"),fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(50)),
            ),
            Text("Rent Tech",style: GoogleFonts.akayaTelivigala(textStyle: TextStyle(fontSize: 25,color: Colors.black.withValues(alpha: 0.6)),),),
          ],
        ),
      ),
    );
  }
}