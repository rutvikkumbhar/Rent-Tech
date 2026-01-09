import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:renttech/Products/OrderPage.dart';
import 'package:renttech/Products/ProductInfo.dart';

class Cart extends StatelessWidget {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('Users');

  Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      body:
      Padding(
        padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
        child: StreamBuilder(
          stream: collectionReference.doc(_auth.currentUser!.uid).collection('Cart').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
            if(streamSnapshot.connectionState == ConnectionState.waiting){
              return Center(child: Lottie.asset("assets/images/Animations/Loading.json",repeat: true,height: 100,width: 100,fit: BoxFit.cover),);
            } else if(streamSnapshot.hasError) {
              return const Center(child: Text("Something went wrong"),);
            } else if(!streamSnapshot.hasData || streamSnapshot.data!.docs.isEmpty){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/images/Animations/EmptyCart.json",height: 200,width: 200,repeat: true),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Text("Cart is empty, just like your love life.",textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black.withValues(alpha: 0.5),fontSize: 17,fontWeight: FontWeight.w700),),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (itemBuilder, index){
                  DocumentSnapshot data=streamSnapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder){
                          return ProductInfo(collection: data['pType'], document: data['pID']);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Card(
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(color: const Color(0xffE8DFCA),borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 100,width: 100,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: const Color(0xff4F6F52).withValues(alpha: 0.4)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(data['png'],fit: BoxFit.contain,),
                                    ),),
                                  const SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${data['title']}",
                                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),),
                                        Row(
                                          children: [
                                            Text("₹ ${int.parse(data['rentPerMonth'])-1299}/mo",
                                              style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                            const SizedBox(width: 10,),
                                            Text("₹ ${data['rentPerMonth']}/mo",
                                              style: TextStyle(color: Colors.red.withValues(alpha: 0.5),fontSize: 12,decoration: TextDecoration.lineThrough),),
                                          ],
                                        ),
                                        Card(
                                          elevation: 3,
                                          child: Container(
                                            height: 37,
                                            decoration: BoxDecoration(color: const Color(0xff4F6F52),borderRadius: BorderRadius.circular(5)),
                                            child: TextButton(
                                              child: const Text("Rent now",style: TextStyle(color: Colors.white,fontSize: 16),),
                                              onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (builder){
                                                  return OrderPage(collection: data['pType'], document: data.id);
                                                }));
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                   width: 43,height: 90,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.grey.withValues(alpha: 0.2))),
                                    child: IconButton(
                                      icon: FaIcon(FontAwesomeIcons.trashCan,size: 18,color: Colors.black.withValues(alpha: 0.7)),
                                      onPressed: (){
                                        CollectionReference cart=collectionReference.doc(_auth.currentUser!.uid).collection('Cart');
                                        cart.doc(data.id).delete();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              );
            }
          },
        ),
      ),
    );
  }
}