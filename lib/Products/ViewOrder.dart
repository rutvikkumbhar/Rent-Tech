import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:renttech/Products/CanceledOrderes.dart';
import 'package:renttech/Products/ProductInfo.dart';
import 'package:renttech/Error.dart';
import '../BottomBar.dart';

class ViewOrder extends StatefulWidget {
  const ViewOrder({super.key});

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {

  final FirebaseAuth _auth=FirebaseAuth.instance;
  bool viewStatus=false;
  bool isOrderDeleted=false;

  int getRemainingDays(String endDateString) {
    DateTime endDate = DateTime.parse(endDateString);
    DateTime today = DateTime.now();
    int daysLeft = endDate.difference(today).inDays;
    return daysLeft > 0 ? daysLeft : 0;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: const Text("Your Orders"),
        backgroundColor: const Color(0xffF5EFE6),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 5,),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).collection('User_Orders').orderBy('orderId',descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
            if(streamSnapshot.connectionState == ConnectionState.waiting){
              return Center(child: Lottie.asset("assets/images/Animations/Loading.json",height: 120,width: 120,repeat: true,fit: BoxFit.cover),);
            } else if(streamSnapshot.hasError){
              return const Center(child: Text("Something went wrong!"),);
            } else if(!streamSnapshot.hasData || streamSnapshot.data!.docs.isEmpty){
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/images/Animations/EmptyCart.json",height: 200,width: 200,repeat: true),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Text("No orders yet. Rent your favorite products now!",textAlign: TextAlign.center,
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
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.2),borderRadius: BorderRadius.circular(5),),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 90,width: 90,
                                    decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.3),image: DecorationImage(image: NetworkImage(data['pPNG']),fit: BoxFit.contain),
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  const SizedBox(width: 12,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${data['pTitle'].toString().length>45?"${data['pTitle'].toString().substring(0,45)}...":data['pTitle']}",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87.withValues(alpha: 0.7)),),
                                        Text("${data['pBrand']}"),
                                        Text("Order ID ${data['orderId']}")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (builder){
                                return ProductInfo(collection: data['pType'].toString(), document: data['productId']);
                              }));
                            },
                          ),
                          AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: data['viewStatus']=="True"?Curves.easeIn:Curves.easeOut,
                              height: data['viewStatus']=="True"?270:0, width: MediaQuery.of(context).size.width,
                              child: data['viewStatus']=="True"?Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 6,),
                                    Row(
                                      children: [
                                        Icon(data['orderStatus']=="Confirmed" ||data['orderStatus']=="Shipped" || data['orderStatus']=="Out for Delivery" || data['orderStatus']=="Delivered" ? Icons.check_circle_rounded:Icons.circle_rounded,size: 19,color
                                            : data['orderStatus']=="Confirmed" ||data['orderStatus']=="Shipped" || data['orderStatus']=="Out for Delivery" || data['orderStatus']=="Delivered"?const Color(0xff1DB954):Colors.grey),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: data['orderStatus']=="Confirmed" ||data['orderStatus']=="Shipped" || data['orderStatus']=="Out for Delivery" || data['orderStatus']=="Delivered"?const Color(0xff1DB954):Colors.grey.withValues(alpha: 0.5),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: data['orderStatus']=="Shipped" || data['orderStatus']=="Out for Delivery" || data['orderStatus']=="Delivered"?const Color(0xff1DB954):Colors.grey.withValues(alpha: 0.5),
                                          ),
                                        ),
                                        Icon(data['orderStatus']=="Shipped" || data['orderStatus']=="Out for Delivery" || data['orderStatus']=="Delivered"? Icons.check_circle_rounded:Icons.circle_rounded,size: 19,color
                                            : data['orderStatus']=="Shipped" || data['orderStatus']=="Out for Delivery" || data['orderStatus']=="Delivered"?const Color(0xff1DB954):Colors.grey),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: data['orderStatus']=="Shipped" || data['orderStatus']=="Out for Delivery" || data['orderStatus']=="Delivered"?const Color(0xff1DB954):Colors.grey.withValues(alpha: 0.5),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: data['orderStatus']=="Out for Delivery" || data['orderStatus']=="Delivered"?const Color(0xff1DB954):Colors.grey.withValues(alpha: 0.5),
                                          ),
                                        ),
                                        Icon(data['orderStatus']=="Out for Delivery" || data['orderStatus']=="Delivered" ? Icons.check_circle_rounded:Icons.circle_rounded,size: 19,color
                                            : data['orderStatus']=="Out for Delivery" || data['orderStatus']=="Delivered"?const Color(0xff1DB954):Colors.grey),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: data['orderStatus']=="Out for Delivery" || data['orderStatus']=="Delivered"?const Color(0xff1DB954):Colors.grey.withValues(alpha: 0.5),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: data['orderStatus']=="Delivered"?const Color(0xff1DB954):Colors.grey.withValues(alpha: 0.5),
                                          ),
                                        ),
                                        Icon(data['orderStatus']=="Delivered"? Icons.check_circle_rounded:Icons.circle_rounded,size: 19,color: data['orderStatus']=="Delivered"?const Color(0xff1DB954):Colors.grey),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Expanded(child: Text("Confirmed",),),
                                        Expanded(child: Text("Shipped",textAlign: TextAlign.center,)),
                                        Expanded(child: Text("Out for Delivery",textAlign: TextAlign.center,)),
                                        Expanded(child: Text("Delivered",textAlign: TextAlign.end,)),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        const Text("Order Status: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                        Text("${data['orderStatus']}",style: const TextStyle(color: Color(0xff344CB7),fontWeight: FontWeight.w600),)
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text("From:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                            const SizedBox(width: 5,),
                                            Text("${data['startDate']}",style: const TextStyle(color: Color(0xff3D8D7A),fontSize: 15,fontWeight: FontWeight.w600),),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text("To:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                            const SizedBox(width: 5,),
                                            Text("${data['endDate']}",style: const TextStyle(color: Color(0xff3D8D7A),fontSize: 15,fontWeight: FontWeight.w600),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        const Text("Days left: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                        data['orderStatus']=="Delivered"? Text("${getRemainingDays(data['endDate'])}",style: const TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 15),):const Text("Not started"),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    const Text("Payment",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 3,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Mode: ${data['paymentMode']}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                                        Text("Status: ${data['paymentStatus']}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Container(
                                      height: 1,width: MediaQuery.of(context).size.width,
                                      color: Colors.grey.withValues(alpha: 0.1),
                                    ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.black.withValues(alpha: 0.2))),
                                          child: TextButton(
                                            child: Text("Cancel order",style: TextStyle(color: Colors.red.withValues(alpha: 0.8),fontWeight: FontWeight.w600,fontSize: 16),),
                                            onPressed: (){
                                              showModalBottomSheet(
                                                context: context,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                builder: (context){
                                                  return SizedBox(
                                                    height: 270,width: MediaQuery.of(context).size.width,
                                                    child:Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets.all(13),
                                                          child: Text("Are you sure you want to cancel this order?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 19),),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20,right: 20),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Expanded(child: Text("Canceled orders will still be visible in the 'Order History' section from the home page drawer.",
                                                                style: TextStyle(fontSize: 16,color: Color(0xff6C5B7B),fontWeight: FontWeight.w500),)),
                                                              SizedBox(
                                                                width: 150,
                                                                child: Lottie.asset("assets/images/Animations/DeliveryLoading.json",repeat: true,fit: BoxFit.cover),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 1,width: MediaQuery.of(context).size.width,
                                                          color: Colors.grey.withValues(alpha: 0.2),
                                                        ),
                                                        const SizedBox(height: 15,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Container(
                                                              height: 45,
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.grey.withValues(alpha: 0.3))),
                                                              child: TextButton(
                                                                child: const Padding(
                                                                  padding: EdgeInsets.only(left: 15,right: 15),
                                                                  child: Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w500),),
                                                                ),
                                                                onPressed: (){
                                                                  Navigator.pop(context);
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              height:45,
                                                              decoration: BoxDecoration(color: const Color(0xff4F6F52),borderRadius: BorderRadius.circular(5)),
                                                              child: TextButton(
                                                                child: const Text("Confirm",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500)),
                                                                onPressed: () async {
                                                                  Navigator.pop(context);
                                                                  void Function(void Function())? updateDialogState;
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (context){
                                                                        return StatefulBuilder(
                                                                          builder: (context, setState){
                                                                            updateDialogState = setState;
                                                                            return AlertDialog(
                                                                              content: SizedBox(
                                                                                height: isOrderDeleted?250 :210,
                                                                                child: Column(
                                                                                  children: [
                                                                                    isOrderDeleted?Lottie.asset("assets/images/Animations/DeletedOrder.json",height: 160,width: 160,fit: BoxFit.cover)
                                                                                        :Lottie.asset("assets/images/Animations/Loading.json",height: 160,width: 160,fit: BoxFit.cover,),
                                                                                    Expanded(
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                                                                          child: isOrderDeleted ?Text("Order Canceled",style: GoogleFonts.akayaTelivigala(textStyle: const TextStyle(fontSize: 30,color: Color(0xff1A4D2E),),),textAlign: TextAlign.center)
                                                                                              :const Text("Wait, while we cancel your order",style: TextStyle(fontSize: 18,color: Color(0xff6C5B7B),fontWeight: FontWeight.w500),textAlign: TextAlign.center),
                                                                                        )),
                                                                                    isOrderDeleted?TextButton(
                                                                                      child: const Text("View history"),
                                                                                      onPressed: (){
                                                                                        Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (context) => const BottomBar()),
                                                                                              (Route<dynamic> route) => false,);
                                                                                        Navigator.push(context, MaterialPageRoute(builder: (builder){return const CanceledOrders();
                                                                                        }));
                                                                                      },
                                                                                    ):const SizedBox(),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      }
                                                                  );
                                                                  Map<String, dynamic> docData=data.data() as Map<String, dynamic>;
                                                                  final String unique=DateTime.now().millisecondsSinceEpoch.toString();
                                                                  await FirebaseFirestore.instance.collection('Canceled Orders').doc(unique).set(docData);
                                                                  await FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).collection('Canceled Orders').doc(unique).set(docData);
                                                                  await FirebaseFirestore.instance.collection('Orders').doc(data['orderId']).delete();
                                                                  await FirebaseFirestore.instance.collection('Sellers').doc(docData['sellerId']).collection('Canceled Orders').doc(unique).set(docData);
                                                                  await FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).collection('User_Orders').doc(data['orderId']).delete().then((onValue){
                                                                    isOrderDeleted=true;
                                                                    if (updateDialogState != null) {
                                                                      updateDialogState!(() {});
                                                                    }
                                                                  }).onError((error, stackTrace){
                                                                    Error().toastMessage(error.toString());
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Text("₹${data['totalRentPrice']}",style: TextStyle(color: Colors.black.withValues(alpha: 0.7),fontSize: 16,fontWeight: FontWeight.w600),),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ):const SizedBox()
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10,bottom: 5),
                            child: GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text("View Status",style: TextStyle(color: Color(0xff213555),fontSize: 16),),
                                  Icon(data['viewStatus']=="True"?Icons.keyboard_arrow_up_rounded :Icons.keyboard_arrow_down_rounded,color: const Color(0xff213555),size: 26,),
                                ],
                              ),
                              onTap: (){
                                setState(() async {
                                  await FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).collection('User_Orders').doc(data['orderId']).update({
                                    'viewStatus':data['viewStatus']=="True"?"False":"True",
                                  });
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}