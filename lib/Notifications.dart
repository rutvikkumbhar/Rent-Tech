import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: const Color(0xffF5EFE6),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/Animations/NoNotification.json",height: 200,width: 200,repeat: true),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Text("No notifications yet. Stay tuned for updates on your orders and offers!",textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black.withValues(alpha: 0.5),fontSize: 17,fontWeight: FontWeight.w700),),
            ),
          ],
        ),
      ),
    );
  }

}