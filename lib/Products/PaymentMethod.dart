import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:renttech/Error.dart';
import 'package:renttech/Products/ViewOrder.dart';

import '../BottomBar.dart';

class PaymentMethod extends StatefulWidget {
  String documenet,collection,totalRent,deposite,discount,rentalDuration,startDate,endDate,rent,sellerId;
  PaymentMethod({super.key,
    required this.documenet,
    required this.collection,
    required this.rent,
    required this.totalRent,
    required this.deposite,
    required this.discount,
    required this.rentalDuration,
    required this.startDate,
    required this.endDate,
    required this.sellerId
});
  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {

  final FirebaseAuth _auth=FirebaseAuth.instance;
  bool showPaymentDetails=false;
  bool cod=false;
  bool isOrderConfirmed=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: const Text("Payments"),
        backgroundColor: const Color(0xffF5EFE6),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.2),borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      const Icon(Icons.lock_outline,size: 16,),
                      Text("100% Secure",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black.withValues(alpha: 0.6)),),
                    ],
                  ),
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12),
        child: ListView(
          children: [
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(color: const Color(0XFF3E5879).withValues(alpha: 0.1),borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    showPaymentDetails?Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Price",style: TextStyle(fontSize: 15),),
                            Text("₹${widget.rent}",style: const TextStyle(fontSize: 15),)
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Refundable Deposit",style: TextStyle(fontSize: 15),),
                                Text("(Returned after rental period)",style: TextStyle(fontSize: 13),)
                              ],
                            ),
                            Text("₹${widget.deposite}",style: const TextStyle(fontSize: 15),)
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Discount",style: TextStyle(fontSize: 15),),
                            Text("-₹${widget.discount}",style: const TextStyle(fontSize: 15,color: Color(0xff118B50)),)
                          ],
                        ),
                        const SizedBox(height: 5,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Platform Fee",style: TextStyle(fontSize: 15),),
                            Text("₹3",style: TextStyle(fontSize: 15),)
                          ],
                        ),
                        const SizedBox(height: 5,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery Charges",style: TextStyle(fontSize: 15),),
                            Text("FREE Delivery",style: TextStyle(fontSize: 15,color: Color(0xff118B50)),)
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          height: 3,width: MediaQuery.of(context).size.width,
                          color: Colors.grey.withValues(alpha: 0.1),
                        ),
                        const SizedBox(height: 8,),
                      ],
                    ):const SizedBox(),
                    GestureDetector(
                      child: SizedBox(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text("Total Amount",style: TextStyle(color: Color(0xff213555),fontSize: 16),),
                                Icon(showPaymentDetails?Icons.keyboard_arrow_up_rounded:Icons.keyboard_arrow_down_rounded,color: const Color(0xff213555),size: 25,),
                              ],
                            ),
                            Text("₹${widget.totalRent}",style: const TextStyle(color: Color(0xff213555),fontSize: 17,fontWeight: FontWeight.w600),)
                          ],
                        ),
                      ),
                      onTap: (){
                        showPaymentDetails=showPaymentDetails?false:true;
                        setState(() {});
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 13,),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.red.withValues(alpha: 0.2),),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.red),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text("Currently, only Cash on Delivery (COD) is available. Other payment options will be added soon.",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              height: 2,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 5,),
            ListTile(
              leading: Container(
                height: 40,width: 25,
                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/PaymentIcon/upiIcon.png"),fit: BoxFit.contain)),),
              title: const Text("UPI",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
              subtitle: const Text("Pay by any UPI app",style: TextStyle(color: Color(0xff41B06E)),),
              trailing: const Icon(Icons.keyboard_arrow_down_outlined,size: 27,),
              onTap: (){
                const msg=SnackBar(content: Text("Currently not available, will be added soon."));
                ScaffoldMessenger.of(context).showSnackBar(msg);
              },
            ),
            const SizedBox(height: 5,),
            Container(
              height: 2,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 5,),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.creditCard,size: 19,color: Colors.black.withValues(alpha: 0.6)),
              title: const Text("Credit / Debit / ATM Card",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
              subtitle: Text("Add and secure cards as per RBI guidelines",style: TextStyle(color: Colors.black.withValues(alpha: 0.5))),
              trailing: const Icon(Icons.keyboard_arrow_down_outlined,size: 27,),
              onTap: (){
                const msg=SnackBar(content: Text("Currently not available, will be added soon."));
                ScaffoldMessenger.of(context).showSnackBar(msg);
              },
            ),
            const SizedBox(height: 5,),
            Container(
              height: 2,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 5,),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.buildingColumns,size: 19,color: Colors.black.withValues(alpha: 0.6),),
              title: const Text("Net Banking",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
              trailing: const Icon(Icons.keyboard_arrow_down_outlined,size: 27,),
              onTap: (){
                const msg=SnackBar(content: Text("Currently not available, will be added soon."));
                ScaffoldMessenger.of(context).showSnackBar(msg);
              },
            ),
            const SizedBox(height: 5,),
            Container(
              height: 2,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 5,),
            ListTile(
              leading: Icon(Boxicons.bx_wallet,size: 21,color: Colors.black.withValues(alpha: 0.6),),
              title: const Text("Wallet",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
              trailing: const Icon(Icons.keyboard_arrow_down_outlined,size: 27,),
              onTap: (){
                const msg=SnackBar(content: Text("Currently not available, will be added soon."));
                ScaffoldMessenger.of(context).showSnackBar(msg);
              },
            ),
            const SizedBox(height: 5,),
            Container(
              height: 2,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(color: cod?Colors.grey.withValues(alpha: 0.2):const Color(0xffF5EFE6)),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Boxicons.bx_rupee,size: 21,color: Colors.black.withValues(alpha: 0.6),),
                    title: const Text("Cash on Delivery",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                    trailing: Icon(cod?Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_outlined,size: 27,),
                    onTap: (){
                      setState(() {
                        cod=cod?false:true;
                      });
                    },
                  ),
                  cod?Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(color: const Color(0xffF5EFE6),borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            const Text("Due to handling costs, a nominal fee of ₹5 will be charged (not applied yet)"),
                            const SizedBox(height: 15,),
                            Container(
                              width: 230,height: 50,
                              decoration: BoxDecoration(color: const Color(0xff4F6F52),borderRadius: BorderRadius.circular(5)),
                              child: TextButton(
                                child: const Text("Place Order",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 17)),
                                onPressed: (){
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
                                    builder: (context){
                                      return Container(
                                        height: 230,width: MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(13),
                                              child: Text("Confirm Cash on Delivery Order",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 19),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20,right: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Expanded(child: Text("Pay via UPI or Cash when you receive your order",
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
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(left: 15,right: 15),
                                                      child: Text("Confirm order",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500)),
                                                    ),
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
                                                                  height: isOrderConfirmed?250 :210,
                                                                  child: Column(
                                                                    children: [
                                                                      isOrderConfirmed?Lottie.asset("assets/images/Animations/OrderConfirmation.json",height: 160,width: 160,fit: BoxFit.cover)
                                                                          :Lottie.asset("assets/images/Animations/Loading.json",height: 160,width: 160,fit: BoxFit.cover,),
                                                                      Expanded(
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.only(left: 10,right: 10),
                                                                            child: isOrderConfirmed ?Text("Order Placed",style: GoogleFonts.akayaTelivigala(textStyle: const TextStyle(fontSize: 30,color: Color(0xff1A4D2E),),),textAlign: TextAlign.center)
                                                                                :const Text("Wait, while we confirm your order",style: TextStyle(fontSize: 18,color: Color(0xff6C5B7B),fontWeight: FontWeight.w500),textAlign: TextAlign.center),
                                                                          )),
                                                                      isOrderConfirmed?TextButton(
                                                                        child: const Text("View order"),
                                                                        onPressed: (){
                                                                          Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (context) => BottomBar()),
                                                                                (Route<dynamic> route) => false,);
                                                                          Navigator.push(context, MaterialPageRoute(builder: (builder){
                                                                            return ViewOrder();
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
                                                      CollectionReference order=FirebaseFirestore.instance.collection('Orders');
                                                      CollectionReference userOrder=FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).collection('User_Orders');
                                                      CollectionReference sellerOrder=FirebaseFirestore.instance.collection('Sellers').doc(widget.sellerId.toString()).collection('Seller_Orders');
                                                      DocumentSnapshot pData=await FirebaseFirestore.instance.collection(widget.collection).doc(widget.documenet).get();
                                                      DocumentSnapshot uData=await FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).get();
                                                      final String address="${uData['street']}, Tal:- ${uData['tal']}, City:- ${uData['city']}";
                                                      final String unique=DateTime.now().millisecondsSinceEpoch.toString();
                                                      await order.doc(unique).set({
                                                        'productId' : widget.documenet.toString(),
                                                        'withValues' : widget.collection.toString(),
                                                        'totalRentPrice': widget.totalRent.toString(),
                                                        'rent':widget.rent.toString(),
                                                        'deposite' : widget.deposite.toString(),
                                                        'discount': widget.discount.toString(),
                                                        'rentalDuration' : widget.rentalDuration.toString(),
                                                        'startDate': widget.startDate.toString(),
                                                        'endDate' : widget.endDate.toString(),
                                                        'orderId' : unique.toString(),
                                                        'userName' :uData['name'].toString(),
                                                        'userEmail' :uData['email'].toString(),
                                                        'userPhone' : uData['contact'].toString(),
                                                        'deliveryAddress':address.toString(),
                                                        'userZip':uData['zip'].toString(),
                                                        'pTitle':pData['title'].toString(),
                                                        'pPNG':pData['png'].toString(),
                                                        'pBrand':pData['brand'].toString(),
                                                        'pModel':pData['modelNo'].toString(),
                                                        'paymentStatus': "Pending",
                                                        'paymentMode':"Cash on Delivery",
                                                        'orderStatus': "Not Confirm",
                                                        'viewStatus':"False",
                                                        'timestamp': FieldValue.serverTimestamp(),
                                                        'sellerId':pData['sellerId'].toString()
                                                      }).then((onValue) async {
                                                        await userOrder.doc(unique).set({
                                                          'productId' : widget.documenet.toString(),
                                                          'withValues' : widget.collection.toString(),
                                                          'totalRentPrice': widget.totalRent.toString(),
                                                          'rent':widget.rent.toString(),
                                                          'deposite' : widget.deposite.toString(),
                                                          'discount': widget.discount.toString(),
                                                          'rentalDuration' : widget.rentalDuration.toString(),
                                                          'startDate': widget.startDate.toString(),
                                                          'endDate' : widget.endDate.toString(),
                                                          'orderId' : unique.toString(),
                                                          'userName' :uData['name'].toString(),
                                                          'userEmail' :uData['email'].toString(),
                                                          'userPhone' : uData['contact'].toString(),
                                                          'deliveryAddress':address.toString(),
                                                          'userZip':uData['zip'].toString(),
                                                          'pTitle':pData['title'].toString(),
                                                          'pPNG':pData['png'].toString(),
                                                          'pBrand':pData['brand'].toString(),
                                                          'pModel':pData['modelNo'].toString(),
                                                          'paymentStatus': "Pending",
                                                          'paymentMode':"Cash on Delivery",
                                                          'orderStatus': "Not Confirm",
                                                          'viewStatus':"False",
                                                          'timestamp': FieldValue.serverTimestamp(),
                                                          'sellerId':pData['sellerId'].toString()
                                                        }).then((onValue) async {
                                                          await sellerOrder.doc(unique).set({
                                                            'productId' : widget.documenet.toString(),
                                                            'withValues' : widget.collection.toString(),
                                                            'totalRentPrice': widget.totalRent.toString(),
                                                            'rent':widget.rent.toString(),
                                                            'deposite' : widget.deposite.toString(),
                                                            'discount': widget.discount.toString(),
                                                            'rentalDuration' : widget.rentalDuration.toString(),
                                                            'startDate': widget.startDate.toString(),
                                                            'endDate' : widget.endDate.toString(),
                                                            'orderId' : unique.toString(),
                                                            'userName' :uData['name'].toString(),
                                                            'userEmail' :uData['email'].toString(),
                                                            'userPhone' : uData['contact'].toString(),
                                                            'deliveryAddress':address.toString(),
                                                            'userZip':uData['zip'].toString(),
                                                            'pTitle':pData['title'].toString(),
                                                            'pPNG':pData['png'].toString(),
                                                            'pBrand':pData['brand'].toString(),
                                                            'pModel':pData['modelNo'].toString(),
                                                            'paymentStatus': "Pending",
                                                            'paymentMode':"Cash on Delivery",
                                                            'orderStatus': "Not Confirm",
                                                            'viewStatus':"False",
                                                            'timestamp': FieldValue.serverTimestamp(),
                                                            'sellerId':pData['sellerId'].toString()
                                                          }).then((onValue){
                                                            isOrderConfirmed=true;
                                                            if (updateDialogState != null) {
                                                              updateDialogState!(() {});
                                                            }
                                                          }).onError((error, stackTrace){
                                                            Error().toastMessage(error.toString());
                                                          });
                                                        }).onError((error, stackTrace){
                                                          Error().toastMessage(error.toString());
                                                        });
                                                      }).onError((error, stackTrace){
                                                        Error().toastMessage(error.toString());
                                                      });
                                                    },
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ):const SizedBox(),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Container(
              height: 2,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 50,),
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