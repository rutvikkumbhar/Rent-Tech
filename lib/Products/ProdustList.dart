import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:renttech/Products/ProductInfo.dart';
import 'package:renttech/Products/Rating.dart';

class ProductList extends StatefulWidget {

  String collection;
   ProductList({super.key, required  this.collection});
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: const Color(0xffF5EFE6),
     appBar: AppBar(
       title: const Text("Products "),
       backgroundColor: const Color(0xffF5EFE6),
     ),
     body: StreamBuilder(
       stream: FirebaseFirestore.instance.collection(widget.collection.toString()).snapshots(),
       builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
         if(streamSnapshot.connectionState==ConnectionState.waiting){
           return const Center(child: CircularProgressIndicator(color: Color(0xff1A4D2E),),);
         } else if(streamSnapshot.hasError){
           return const Center(child: Text("Something went wrong"));
         } else if(streamSnapshot.hasData==false || streamSnapshot.data!.docs.isEmpty ){
           return Center(child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Lottie.asset("assets/images/Animations/OutOfStock.json",height: 200,width: 200,repeat: true),
               const SizedBox(height: 10,),
               Padding(
                 padding: const EdgeInsets.only(left: 15,right: 15),
                 child: Text("Oops! No products available in this category right now. Please check back later.",textAlign: TextAlign.center,
                   style: TextStyle(color: Colors.black.withValues(alpha: 0.5),fontSize: 17,fontWeight: FontWeight.w700),),
               ),
               const SizedBox(height: 80,),
             ],
           ),);
         } else {
           return ListView.builder(
             itemCount: streamSnapshot.data!.docs.length,
             itemBuilder: (itemBuilder, index){
               DocumentSnapshot data=streamSnapshot.data!.docs[index];
               return Padding(
                 padding: const EdgeInsets.fromLTRB(7, 5, 7, 5),
                 child: GestureDetector(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (builder){
                       return ProductInfo(collection: widget.collection, document: data.id);
                     }));
                     CollectionReference ref=FirebaseFirestore.instance.collection('Users');
                     CollectionReference reference=ref.doc(_auth.currentUser!.uid).collection('Recently_Visited');
                     reference.doc('Recent_Visited_Product').set(data.data());
                   },
                   child: Card(
                     elevation: 1,
                     child: Container(
                       decoration: BoxDecoration(color: const Color(0xffE8DFCA).withValues(alpha: 0.9),borderRadius: BorderRadius.circular(5)),
                       child: Padding(
                         padding: const EdgeInsets.all(8),
                         child: Row(
                           children: [
                             Container(
                               height: 110,width: 110,
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey.withValues(alpha: 0.3)),
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Image.network(data['png'],fit: BoxFit.contain,),
                               ),
                             ),
                             const SizedBox(width: 10,),
                             Expanded(
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text("${data['title'].toString().length>70?"${data['title'].toString().substring(0,70)}...":data['title']}",
                                     style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),),
                                   const SizedBox(height: 2,),
                                   Rating().rating(data['rating']),
                                   const SizedBox(height: 2,),
                                   Row(
                                     children: [
                                       Text(
                                         "₹${(int.parse(data['rentPerMonth']) - (int.parse(data['rentPerMonth']) * (double.parse(data['discount']) / 100))).toStringAsFixed(2)}/mo",
                                         style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                                       const SizedBox(width: 10,),
                                       Text("₹${data['rentPerMonth']}/mo",
                                         style: TextStyle(color: Colors.red.withValues(alpha: 0.5),fontSize: 12,decoration: TextDecoration.lineThrough),),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                             const SizedBox(width: 5,),
                             Container(
                               height: 110,width: 43,
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.grey.withValues(alpha: 0.2))),
                               child: IconButton(
                                 icon: FaIcon(FontAwesomeIcons.heart,size: 20,color: Colors.black.withValues(alpha: 0.7)),
                                 onPressed: (){
                                   Map<String, dynamic> doc=data.data() as Map<String, dynamic>;
                                   CollectionReference collectionReference=FirebaseFirestore.instance.collection('Users');
                                   CollectionReference ref=collectionReference.doc(_auth.currentUser!.uid).collection('Cart');
                                   ref.doc(data.id).set(doc);
                                   const msg=SnackBar(content: Text("Added to Cart"));
                                   ScaffoldMessenger.of(context).showSnackBar(msg);
                                 },
                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
               );
             },
           );
         }
       },
     ),
   );
  }
}