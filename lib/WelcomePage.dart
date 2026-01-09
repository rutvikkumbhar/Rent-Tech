import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:renttech/Login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 140,),
              Container(
                child: Lottie.asset("assets/images/Animations/Welcome.json",repeat: true,height: 230,width: 320,fit: BoxFit.cover),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50,right: 50),
                child: Column(
                  children: [
                    const Text("RentTech: Smart Rentals for Smarter Living",textAlign: TextAlign.center,
                        style: TextStyle( color: Colors.black,fontWeight: FontWeight.w800,fontSize: 22,)),
                    const SizedBox(height: 9,),
                    Text("Get the latest tech, no high price tag.",textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black.withValues(alpha: 0.7),fontWeight: FontWeight.w700,fontSize: 17),),
                    Text("Rent, enjoy, and upgrade effortlessly!",textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black.withValues(alpha: 0.7),fontWeight: FontWeight.w700,fontSize: 17),),
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              Card(
                elevation: 4,color: const Color(0xff4F6F52),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width-40,
                  child: TextButton(
                    child: const Padding(
                      padding: EdgeInsets.only(top: 6,bottom: 6),
                      child: Text("Continue",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500),),
                    ),
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder){
                        return const Login();
                      }));
                    },
                  ),
                ),
              ),
              const SizedBox(height: 90,)
            ],
          )
        ],
      ),
    );
  }
}