import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Maintenance extends StatelessWidget {
  const Maintenance({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: const Color(0xffF1F0E9),
     body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Lottie.asset("assets/images/Animations/Maintenance.json",repeat: true),
         Padding(
           padding: const EdgeInsets.only(left: 25,right: 25),
           child: Text("RentTech is under maintenance. We'll be back soon!",textAlign: TextAlign.center,
             style: TextStyle(color: Colors.black.withValues(alpha: 0.5),fontSize: 17,fontWeight: FontWeight.w700),),
         ),
       ],
     ),
   );
  }
}