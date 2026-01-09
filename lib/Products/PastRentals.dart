import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'ProductInfo.dart';

class PastRentals extends StatefulWidget {
  const PastRentals({super.key});
  @override
  State<PastRentals> createState() => _PastRentalsState();
}

class _PastRentalsState extends State<PastRentals> {
  final FirebaseAuth _auth=FirebaseAuth.instance;

  CollectionReference ref=FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: const Text("Past Rentals"),
        backgroundColor: const Color(0xffF5EFE6),
      ),
      body: StreamBuilder(
        stream: ref.doc(_auth.currentUser!.uid).collection('User_Orders').where('orderStatus', isEqualTo: "Returned").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.connectionState==ConnectionState.waiting){
            return Center(child: Lottie.asset("assets/images/Animations/Loading.json",height: 120,width: 120,repeat: true,fit: BoxFit.cover),);
          } else if(streamSnapshot.hasError){
            return const Center(child: Text("Something went wrong"),);
          } else if(!streamSnapshot.hasData || streamSnapshot.data!.docs.isEmpty){
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/images/Animations/OutOfStock.json",height: 200,width: 200,repeat: true),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Text("You haven’t rented any products yet. Explore our collection and start renting today!",textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black.withValues(alpha: 0.5),fontSize: 17,fontWeight: FontWeight.w700),),
                ),
              ],
            ));
          } else {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (itemBuilder, index){
                DocumentSnapshot data=streamSnapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.1),borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 90,width: 90,
                              decoration: BoxDecoration(image: const DecorationImage(image: AssetImage("assets/images/LaptopStock-removebg-preview.png"),fit: BoxFit.contain),
                                  color: Colors.grey.withValues(alpha: 0.3),borderRadius: BorderRadius.circular(5)),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${data['pTitle']}",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  Text("${data['pBrand']}"),
                                  const Row(
                                    children: [
                                      Text("Order Status:"),
                                      SizedBox(width: 10,),
                                      Text("Returned",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductInfo(collection: data['pType'], document: data['productId']);
                      }));
                    },
                  ),
                );
              },
            );
          }
        },
      )
    );
  }
}