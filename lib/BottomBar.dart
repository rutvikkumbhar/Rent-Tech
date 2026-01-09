import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:renttech/Products/CanceledOrderes.dart';
import 'package:renttech/Products/PastRentals.dart';
import 'package:renttech/Products/ViewOrder.dart';
import 'AIChat.dart';
import 'About.dart';
import 'Cart.dart';
import 'Categories.dart';
import 'Help.dart';
import 'Home.dart';
import 'Notifications.dart';
import 'Profile.dart';
import 'WelcomePage.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => bottomState();
}

class bottomState extends State<BottomBar> {

  final FirebaseAuth _auth=FirebaseAuth.instance;
   int selectedPage=0 ;
    final List<Widget> module=[
      Home(),
      Categories(),
      const AIChat(),
      Cart(),
      Profile(),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Lottie.asset("assets/images/Animations/DeliveryMan.json",repeat: true,height: 75,width: 75,fit: BoxFit.cover),
            const SizedBox(width: 5,),
            Text("Rent Tech",style: GoogleFonts.akayaTelivigala(textStyle: const TextStyle(fontSize: 28,),),),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffF5EFE6),
        actions: [
          IconButton(
            icon: const Icon(Boxicons.bx_bell,color: Color(0xff1A4D2E),),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder){
                return Notifications();
              }));
            },
          ),
          const SizedBox(width: 10,)
        ],
      ),
        drawer: Drawer(
          width: 280,
          backgroundColor: const Color(0xffF1F0E9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                child: Center(child: Lottie.asset("assets/images/Animations/Welcome.json",fit: BoxFit.contain)),
              ),
              ListTile(
                title: const Text("Current Rentals"),
                leading: const Icon(Boxicons.bx_history,color: Color(0xff4F6F52),),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder){
                    return const ViewOrder();
                  }));
                },
              ),
              ListTile(
                title: const Text("Past Rentals"),
                leading: const Icon(Icons.paste,color: Color(0xff4F6F52),),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder){
                    return const PastRentals();
                  }));
                },
              ),
              ListTile(
                title: const Text("Canceled Products"),
                leading: const Icon(Icons.cancel_outlined,color: Color(0xff4F6F52),),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder){
                    return const CanceledOrders();
                  }));
                },
              ),
              ListTile(
                title: const Text("Help"),
                leading: const Icon(Boxicons.bx_help_circle,color: Color(0xff4F6F52),),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder){
                    return Help();
                  }));
                },
              ),
              ListTile(
                title: const Text("About"),
                leading: const Icon(Boxicons.bx_info_circle,color: Color(0xff4F6F52),),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder){
                    return const About();
                  }));
                },
              ),
              ListTile(
                title: const Text("Log Out"),
                leading: const Icon(Icons.logout_rounded,color: Color(0xff4F6F52),),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey,),
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Logout"),
                        content: const Text("Are you sure you want to log out?"),
                        backgroundColor: const Color(0xffF5EFE6),
                        actions: [
                          Container(
                            height: 44,
                            decoration: BoxDecoration(border: Border.all(color: const Color(0xff4F6F52)),borderRadius: BorderRadius.circular(5)),
                            child: TextButton(
                              child: const Padding(
                                padding: EdgeInsets.only(left: 7,right: 7),
                                child: Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                              ),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(color: const Color(0xff4F6F52),borderRadius: BorderRadius.circular(5)),
                            child: TextButton(
                              child: const Padding(
                                padding: EdgeInsets.only(left: 7,right: 7),
                                child: Text("Log Out",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),),
                              ),
                              onPressed: (){
                                _auth.signOut();
                                Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (context) => WelcomePage()),
                                      (Route<dynamic> route) => false,);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              GestureDetector(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Lottie.asset("assets/images/Animations/Premium.json", height: 44, fit: BoxFit.contain,),
                      ),
                    ),
                    const Icon(Icons.lock, color: Colors.black54, size: 24),
                  ],
                ),
                onTap: () {},
              ),
              const Spacer(),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Thank you for choosing RentTech! Rent smart, rent easy.",textAlign: TextAlign.center,),
                  Text("Developed by Rutvik",textAlign: TextAlign.center,),
                  Text("Version: 1.0.0"),
                ],
              )
            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedPage,
          onTap: (int index){
            setState(() {
              selectedPage=index;
            });
          },
          unselectedItemColor: const Color(0xff4F6F52),
          selectedItemColor: const Color(0xff2C3930),
          showUnselectedLabels: false,
          backgroundColor: const Color(0xffE8DFCA),
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              label: "",
              activeIcon: Icon(Boxicons.bxs_home_alt_2),
              icon: Icon(Boxicons.bx_home_alt_2),
            ),
            BottomNavigationBarItem(
              label: "",
              activeIcon: Icon(Boxicons.bxs_category),
              icon: Icon(Boxicons.bx_category),
            ),
            BottomNavigationBarItem(
              label: "",
              activeIcon: Icon(Boxicons.bxs_message_square_detail),
              icon: Icon(Boxicons.bx_message_square_detail),
            ),
            BottomNavigationBarItem(
              label: "",
              activeIcon: Icon(Boxicons.bxs_cart),
              icon: Icon(Boxicons.bx_cart),
            ),
            BottomNavigationBarItem(
              label: "",
              activeIcon: Icon(Boxicons.bxs_user),
              icon: Icon(Boxicons.bx_user),
            ),
          ],
        ),
      body: module[selectedPage],
    );
  }
}