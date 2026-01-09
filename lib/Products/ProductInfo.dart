import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renttech/EditProfile.dart';
import 'package:renttech/Products/OrderPage.dart';
import 'package:renttech/Products/Rating.dart';
import 'ProdustList.dart';

class ProductInfo extends StatefulWidget {
  String collection,document;
  ProductInfo({super.key, required this.collection, required this.document});
  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {

  final FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: const Text("Product info"),
        backgroundColor: const Color(0xffF5EFE6),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff4F6F52),
        child: const Icon(Icons.local_shipping_outlined,color: Colors.white,size: 30,),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder){
            return OrderPage(collection: widget.collection, document: widget.document);
          }));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(widget.collection).doc(widget.document).snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> streamSnapshot) {
            if(streamSnapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(color: Color(0xff4F6F52),),);
            } else if(streamSnapshot.hasError){
              return const Center(child: Text("Something went wrong"),);
            } else {
              Map<String, dynamic> data=streamSnapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  const SizedBox(height: 10,),
                  Text("${data['title']}"),
                  const SizedBox(height: 15,),
                  Container(
                    height: 190,width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.1),borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            height: 190,width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data['png']),fit: BoxFit.contain)),
                          ),
                          Container(
                            height: 190,width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data['image2']),fit: BoxFit.contain)),
                          ),
                          Container(
                            height: 190,width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data['image3']),fit: BoxFit.contain)),
                          ),
                          Container(
                            height: 190,width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data['image4']),fit: BoxFit.contain)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Text("${data['brand']}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                  Text("${data['title']}",style: const TextStyle(fontSize: 14),),
                  Text("Model ${data['modelNo']}",style: const TextStyle(fontSize: 14),),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Rating().rating("${data['rating']}"),
                      const SizedBox(width: 5,),
                      Text("${data['rating']}",style: const TextStyle(color: Color(0xff1A4D2E),fontSize: 15,fontWeight: FontWeight.w400),)
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      const Icon(Icons.arrow_downward_sharp,size:22,color: Color(0xff118B50),),
                      Text("${data['discount']}%",style: const TextStyle(color: Color(0xff118B50),fontSize: 18,fontWeight: FontWeight.w500),),
                      const SizedBox(width: 10,),
                      Text("₹${(int.parse(data['rentPerMonth']) - (int.parse(data['rentPerMonth']) * (double.parse(data['discount']) / 100))).toStringAsFixed(2)}/mo",
                        style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                      const SizedBox(width: 10,),
                      Text("₹${data['rentPerMonth']}/mo",style: const TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w500,decoration: TextDecoration.lineThrough),),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    height: 6,width: MediaQuery.of(context).size.width,
                    color: Colors.grey.withValues(alpha: 0.1),
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text("Delivery location",style: TextStyle(fontSize: 15),),
                          const SizedBox(width: 10,),
                          FutureBuilder(
                            future: FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).get(),
                            builder: (context, snapshot) {
                              if(snapshot.connectionState==ConnectionState.waiting){
                                return const Center(child: CircularProgressIndicator(),);
                              } else if(snapshot.hasError){
                                return const Center(child: Text("Error"),);
                              } else {
                                Map<String, dynamic> docData=snapshot.data!.data() as Map<String, dynamic>;
                                return Text("${docData['zip'] ?? "000000"}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.blueAccent),);
                              }
                            }
                          )
                        ],
                      ),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: const Color(0xff4F6F52).withValues(alpha: 0.3))),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Text("Change"),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder){
                            return const EditProfile();
                          }));
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.local_shipping_outlined, size: 28,color: Color(0xff4F6F52),),
                      const SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text("FREE Delivery",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Color(0xff118B50)),),
                              const SizedBox(width: 5,),
                              Text("₹${(int.parse(data['rentPerMonth']))*(double.parse("0.010"))}",style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.black.withValues(alpha: 0.4)),),
                              const SizedBox(width: 5,),
                              const Text("●"),
                              const SizedBox(width: 5,),
                              const Text("Deliver by",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
                          ),
                          const Text("23 Feb, Sunday",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    height: 6,width: MediaQuery.of(context).size.width,
                    color: Colors.grey.withValues(alpha: 0.1),
                  ),
                  const SizedBox(height: 15,),
                  GestureDetector(
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("All Offers & Coupons"),
                        Icon(Icons.keyboard_arrow_right_rounded,color: Color(0xff4F6F52),)
                      ],
                    ),
                    onTap: (){
                      const msg=SnackBar(content: Text("Currently not available"));
                      ScaffoldMessenger.of(context).showSnackBar(msg);
                    },
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    height: 6,width: MediaQuery.of(context).size.width,
                    color: Colors.grey.withValues(alpha: 0.1),
                  ),
                  const SizedBox(height: 15,),
                  const Text("Description",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 5,),
                  Text("${data['description']}"),
                  const SizedBox(height: 20,),
                  const Text("Technical specification",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 5,),
                  Card(
                    elevation: 1,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.1),borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("${data['key1']}"),
                                  subtitle: Text("${data['key1value']}"),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("${data['key2']}"),
                                  subtitle: Text("${data['key2value']}"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("${data['key3']}"),
                                  subtitle: Text("${data['key3value']}"),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("${data['key4']}"),
                                  subtitle: Text("${data['key4value']}"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("${data['key5']}"),
                                  subtitle: Text("${data['key5value']}"),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("${data['key6']}"),
                                  subtitle: Text("${data['key6value']}"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("${data['key7']}"),
                                  subtitle: Text("${data['key7value']}"),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("${data['key8']}"),
                                  subtitle: Text("${data['key8value']}"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("${data['key9']}"),
                                  subtitle: Text("${data['key9value']}"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text("Accessories",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                  Text("${data['accessories']}"),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Condition",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                          Text("${data['condition']}"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("Security deposit",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                          Text("₹${data['securityDeposite']}",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    height: 6,width: MediaQuery.of(context).size.width,
                    color: Colors.grey.withValues(alpha: 0.1),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Similar products",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 21),),
                      Row(
                        children: [
                          Text("See all",style: TextStyle(color: Colors.black.withValues(alpha: 0.5),fontSize: 15),),
                          const SizedBox(width: 7,),
                          GestureDetector(
                            child: Container(
                                decoration: BoxDecoration(color:  const Color(0xff4F6F52).withValues(alpha:  0.4),borderRadius: BorderRadius.circular(50),),
                                child: const Icon(Icons.keyboard_arrow_right_rounded,size: 20,)),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (builder){
                                return ProductList(collection:widget.collection);
                              }));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 220,
                    decoration: const BoxDecoration(),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection(widget.collection).snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                        if(streamSnapshot.hasError){
                          return const Center(child: Text("Something went wrong!"),);
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (itemBuilder, index){
                              DocumentSnapshot data=streamSnapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (builder){
                                    return ProductInfo(collection: data['pType'], document: data.id);
                                  }));
                                },
                                child: SizedBox(
                                  width: 120,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 100,width: 100,
                                          decoration: BoxDecoration(color: const Color(0xff4F6F52).withValues(alpha: 0.4),borderRadius: BorderRadius.circular(15)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Image.network(data['png'],fit: BoxFit.contain,),
                                          ),
                                        ),
                                        const SizedBox(height: 7,),
                                        Text("${data['title'].toString().length>23?"${data['title'].toString().substring(0,23)}...":data['title']}",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 13),),
                                        Text("₹${(int.parse(data['rentPerMonth']) - (int.parse(data['rentPerMonth']) * (double.parse(data['discount']) / 100))).toStringAsFixed(2)}/mo",
                                          style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                                        Text("₹ ${data['rentPerMonth']}/mo",style: TextStyle(color: Colors.red.withValues(alpha: 0.5),fontSize: 12,decoration: TextDecoration.lineThrough),)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 5,width: MediaQuery.of(context).size.width,
                    color: Colors.grey.withValues(alpha: 0.1),
                  ),
                  const SizedBox(height: 15,),
                  const Text("Top Review",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                            height: 50,width: 50,
                            decoration: BoxDecoration(color: const Color(0xffE8DFCA),borderRadius: BorderRadius.circular(50)),
                            child: const Icon(Icons.person,color: Color(0xff4F6F52),)),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text("RentTech user"),
                          subtitle: Text("${data['topReview']}"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    height: 6,width: MediaQuery.of(context).size.width,
                    color: Colors.grey.withValues(alpha: 0.1),
                  ),
                  const SizedBox(height: 15,),
                ],
              );
            }
          }
        ),
      ),
    );
  }
}