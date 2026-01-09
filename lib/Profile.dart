import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:renttech/About.dart';
import 'package:renttech/AccountDeactivate.dart';
import 'package:renttech/EditProfile.dart';
import 'package:renttech/Help.dart';
import 'package:renttech/Products/CanceledOrderes.dart';
import 'package:renttech/Products/PastRentals.dart';
import 'package:renttech/Products/ViewOrder.dart';
import 'package:renttech/ReportIssue.dart';
import 'package:renttech/WelcomePage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth=FirebaseAuth.instance;

  CollectionReference ref=FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: ListView(
          children: [
            StreamBuilder(
              stream: ref.doc(_auth.currentUser!.uid).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> streamSnapshot){
                if(streamSnapshot.connectionState==ConnectionState.waiting){
                  return Center(child: Lottie.asset("assets/images/Animations/Loading.json",repeat: true,height: 100,width: 100,fit: BoxFit.cover),);
                } else if(streamSnapshot.hasError){
                  return const Center(child: Text("Something went wrong"),);
                } else {
                  Map<String, dynamic> data=streamSnapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    children: [
                      const SizedBox(height: 10,),
                      Container(
                        decoration: const BoxDecoration(gradient:LinearGradient(colors: [Color(0xffF5EFE6),Color(0xffE8DFCA)],begin: Alignment.topCenter,end: Alignment.bottomCenter) ,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                height:80,width: 80,
                                decoration: BoxDecoration(image: DecorationImage(image: data['pfpURL']!=null?NetworkImage(data['pfpURL']):const AssetImage("assets/images/pfp.png"),fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(670),),
                              ),
                              const SizedBox(width: 15,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${data['name']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black87.withValues(alpha: 0.7)),),
                                    const SizedBox(height: 5,),
                                    Text("${data['email']}",style:TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.black87.withValues(alpha: 0.7)),),
                                    const SizedBox(height: 5,),],
                                ),
                              ),
                              Container(
                                height: 90,width: 40,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.grey.withValues(alpha: 0.3))),
                                child: IconButton(
                                  icon: const Icon(Icons.edit_outlined,color: Color(0xff4F6F52),),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (builder){
                                      return const EditProfile();
                                    }));
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 13,),
                      (data['street']!=null && data['city']!=null && data['tal']!=null && data['state']!=null && data['zip']!=null)?Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: const Color(0xff4F6F52).withValues(alpha: 0.1),borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Street"),
                              const SizedBox(height: 5,),
                              TextField(
                                decoration: InputDecoration(hintText: "${data['street']}",border: OutlineInputBorder(borderRadius: BorderRadius.circular(25,
                                ),borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.grey.withValues(alpha: 0.1),),
                                readOnly: true,
                              ),
                              const SizedBox(height: 14,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("City"),
                                        const SizedBox(height: 5,),
                                        TextField(
                                          decoration: InputDecoration(hintText: "${data['city']}",border: OutlineInputBorder(borderRadius: BorderRadius.circular(25,
                                          ),borderSide: BorderSide.none),
                                            filled: true,
                                            fillColor: Colors.grey.withValues(alpha: 0.1),),
                                          readOnly: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("Tal"),
                                        const SizedBox(height: 5,),
                                        TextField(
                                          decoration: InputDecoration(hintText: "${data['tal']}",border: OutlineInputBorder(borderRadius: BorderRadius.circular(25,
                                          ),borderSide: BorderSide.none),
                                            filled: true,
                                            fillColor: Colors.grey.withValues(alpha: 0.1),),
                                          readOnly: true,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 14,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("State"),
                                        const SizedBox(height: 5,),
                                        TextField(
                                          decoration: InputDecoration(hintText: "${data['state']}",border: OutlineInputBorder(borderRadius: BorderRadius.circular(25,
                                          ),borderSide: BorderSide.none),
                                            filled: true,
                                            fillColor: Colors.grey.withValues(alpha: 0.1),),
                                          readOnly: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("Zip code"),
                                        const SizedBox(height: 5,),
                                        TextField(
                                          decoration: InputDecoration(hintText: "${data['zip']}",border: OutlineInputBorder(borderRadius: BorderRadius.circular(25,
                                          ),borderSide: BorderSide.none),
                                            filled: true,
                                            fillColor: Colors.grey.withValues(alpha: 0.1),),
                                          readOnly: true,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ):Container(
                        height: 150,width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: const Color(0xff4F6F52).withValues(alpha: 0.1),borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Lottie.asset("assets/images/Animations/Loading.json",height: 90,width: 180,fit: BoxFit.cover ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: Text("No delivery location added. Update your profile to set a delivery address.",
                              style: TextStyle(color: Colors.black.withValues(alpha: 0.6),fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 13,),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: const Color(0xff4F6F52).withValues(alpha: 0.1),borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Current Rentals"),
                    leading: const Icon(Icons.access_time_rounded,size: 20,color: Color(0xff4F6F52),),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff4F6F52),),
                    subtitle: const Text("View your current rented products."),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return const ViewOrder();
                      }));
                    },
                  ),
                  ListTile(
                    title: const Text("Past Rentals"),
                    leading: const Icon(Icons.paste,size: 20,color: Color(0xff4F6F52),),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff4F6F52),),
                    subtitle: const Text("View your previous rented products."),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return const PastRentals();
                      }));
                    },
                  ),
                  ListTile(
                    title: const Text("Canceled Product"),
                    leading: const Icon(Icons.paste,size: 20,color: Color(0xff4F6F52),),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff4F6F52),),
                    subtitle: const Text("View your canceled rented products."),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return const CanceledOrders();
                      }));
                    },
                  ),
                  ListTile(
                    title: const Text("Payment Methods"),
                    leading: const Icon(Icons.payment,size: 20,color: Color(0xff4F6F52),),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff4F6F52),),
                    subtitle: const Text("Saved cards or payment methods."),
                    onTap: (){
                      const msg=SnackBar(content: Text("Currently not available"));
                      ScaffoldMessenger.of(context).showSnackBar(msg);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 13,),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xffE8DFCA),Color(0xffF5EFE6)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Support & Help",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                    ListTile(
                      title: const Text("Customer Support"),
                      leading: const Icon(Boxicons.bx_support,size: 20,color: Color(0xff4F6F52),),
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff4F6F52),),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder){
                          return const Help();
                        }));
                      },
                    ),
                    ListTile(
                      title: const Text("Report an Issue"),
                      leading: const Icon(Icons.question_answer_outlined,size: 20,color: Color(0xff4F6F52),),
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff4F6F52),),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder){
                          return ReportIssue();
                        }));
                      },
                    ),
                    ListTile(
                      title: const Text("Deactivate your account"),
                      leading: const Icon(Icons.highlight_remove,size: 20,color: Color(0xff4F6F52),),
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff4F6F52),),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder){
                          return const DeactivateAccount();
                        }));
                      },
                    ),
                    ListTile(
                      title: const Text("About"),
                      leading: const Icon(Icons.info_outline_rounded,size: 20,color: Color(0xff4F6F52),),
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff4F6F52),),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder){
                          return const About();
                        }));
                      },
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 120,
                          decoration: BoxDecoration(color: const Color(0xff4F6F52),borderRadius: BorderRadius.circular(5)),
                          child: TextButton(
                            child: const Text("Log out",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w500),),
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirm Logout"),
                                    content: SizedBox(
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Lottie.asset("assets/images/Animations/Sad Animation.json",height: 100,width: 100,repeat: true,fit: BoxFit.fill),
                                        ],
                                      ),
                                    ),
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
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Rent Tech",style: GoogleFonts.akayaTelivigala(textStyle: TextStyle(fontSize: 25,color: Colors.black.withValues(alpha: 0.2)),),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}