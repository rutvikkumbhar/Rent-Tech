import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:lottie/lottie.dart';
import 'package:renttech/EditProfile.dart';
import 'package:renttech/Products/PaymentMethod.dart';
import 'package:renttech/Products/Rating.dart';
import 'package:intl/intl.dart';
import 'package:renttech/Error.dart';

class OrderPage extends StatefulWidget {
  String collection,document;
  OrderPage({super.key, required this.collection, required this.document});
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  final FirebaseAuth _auth=FirebaseAuth.instance;
  bool isLocationAdded=false;
  int rentPerMonth=0;
  String? sellerId;
  int depo=0;
  int discount=0;
  DateTime? startDate;
  DateTime? endDate;
  bool loading=false;

  double totalRent(int rent_per_month,int duration){
    double rent=((rent_per_month/30)*duration);
    return rent;
  }

  bool isDurationAdded(){
    if(startDate!=null && endDate!=null){
      return true;
    } else {
      return false;
    }
  }
  double totalAmount(double totalrent, int deposite, double discount, int platformFee, int deliveryCharge){
    double temp=totalrent+deposite+platformFee+deliveryCharge;
    double total=temp-discount;
    return total;

  }
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;
          if (endDate != null && endDate!.isBefore(startDate!)) {
            endDate = null;
          }
        } else {
          endDate = pickedDate;
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: const Text("Order Details"),
        backgroundColor: const Color(0xffF5EFE6),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12),
        child: ListView(
          children: [
            const Text("Order Summary",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
            const SizedBox(height: 5,),
            Card(
              elevation: 1,
              child: Container(
                height: 50,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                  child: Lottie.asset("assets/images/Animations/TrackOrderAnimation.json")),
            ),
            const SizedBox(height: 10,),
            Container(
              height: 6,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Deliver to:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: const Color(0xff4F6F52).withValues(alpha:  0.3))),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Text("Change"),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder){
                      return EditProfile();
                    }));
                  },
                )
              ],
            ),
            const SizedBox(height: 10,),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> streamSnapshot){
                if(streamSnapshot.connectionState==ConnectionState.waiting){
                  return Center(child: Lottie.asset("assets/images/Animations/Loading.json",height: 100,width: 100),);
                } else if(streamSnapshot.hasError){
                  return const Center(child: Text("Something went wrong!"),);
                } else {
                  Map<String, dynamic> data=streamSnapshot.data!.data() as Map<String, dynamic>;
                  if(data['city']==null || data['state']==null || data['street']==null || data['zip']==null){
                    isLocationAdded=false;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/images/Animations/DeliveryLoading.json",repeat: true,height:60,width: 60,fit: BoxFit.cover),
                        const SizedBox(height: 7,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Text("Please add your address to proceed with the purchase.",
                            style: TextStyle(color: Colors.black.withValues(alpha:  0.6),fontWeight: FontWeight.w500,fontSize: 16),),
                        )
                      ],
                    );
                  } else {
                    isLocationAdded=true;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${data['name']}",style: const TextStyle(fontSize: 15),),
                        const SizedBox(height: 4,),
                        Text("${data['street']}, Tal:- ${data['tal']}, ${data['city']} Distrit"),
                        Text("PIN: ${data['zip']}"),
                        const SizedBox(height: 4,),
                        Text("Contact: +91 ${data['contact']}"),
                      ],
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 10,),
            Container(
              height: 6,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 10,),
            const Text("Product info",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
            const SizedBox(height: 10,),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection(widget.collection).doc(widget.document).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> streamSnapshot){
                if(streamSnapshot.connectionState == ConnectionState.waiting){
                  return Center(child: Lottie.asset("assets/images/Animations/Loading.json",height: 100,width: 100),);
                } else if(streamSnapshot.hasError){
                  return const Center(child: Text("Something went wrong!"),);
                } else {
                  Map<String, dynamic> data=streamSnapshot.data!.data() as Map<String, dynamic>;
                  rentPerMonth=int.parse(data['rentPerMonth']);
                  depo=int.parse(data['securityDeposite']);
                  discount=int.parse(data['discount']);
                  sellerId=data['sellerId'].toString();
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 90,width: 90,
                        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data['png']))),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['title'].toString().length>45?"${data['title'].toString().substring(0,45)}...":data['title'],
                              style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 17),),
                            Text("${data['brand']}"),
                            Row(
                              children: [
                                Rating().rating("${data['rating']}"),
                                const SizedBox(width: 5,),
                                Text("${data['rating']}.0",style: const TextStyle(fontSize: 15),),
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                const Icon(Icons.arrow_downward_sharp,size:22,color: Color(0xff118B50),),
                                Text("${data['discount']}%",style: const TextStyle(color: Color(0xff118B50),fontSize: 17,fontWeight: FontWeight.w500),),
                                const SizedBox(width: 10,),
                                Text(
                                  "₹${(int.parse(data['rentPerMonth']) - (int.parse(data['rentPerMonth']) * (double.parse(data['discount']) / 100))).toStringAsFixed(2)}/mo",
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),                                const SizedBox(width: 10,),
                                Text("₹${data['rentPerMonth']}/mo",style: const TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.w500,decoration: TextDecoration.lineThrough),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 10,),
            Container(
              height: 6,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha:  0.1),
            ),
            const SizedBox(height: 10,),
            const Text("Rental Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
            const SizedBox(height: 10,),
            ListTile(
              title: Text("Start Date: ${startDate != null ? DateFormat('yyyy-MM-dd').format(startDate!) : 'Select'}"),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context, true),
            ),
            ListTile(
              title: Text("End Date: ${endDate != null ? DateFormat('yyyy-MM-dd').format(endDate!) : 'Select'}"),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context, false),
            ),
            if (startDate != null && endDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Duration: ${endDate!.difference(startDate!).inDays} days",
                      style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 17),
                    ),
                    Text("Rent: ₹${(totalRent(rentPerMonth,endDate!.difference(startDate!).inDays.toInt())).toStringAsFixed(2)}",style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 17),),
                  ],
                ),
              ),
            const SizedBox(height: 10,),
            Container(
              height: 6,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha:  0.1),
            ),
            const SizedBox(height: 10,),
            const Text("Price Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
            const SizedBox(height: 10,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Price",style: TextStyle(fontSize: 15),),
                    Text("₹${(totalRent(rentPerMonth,startDate!=null && endDate!=null?endDate!.difference(startDate!).inDays:0)).toStringAsFixed(2)}",style: const TextStyle(fontSize: 15),)
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Refundable Deposite",style: TextStyle(fontSize: 15),),
                        Text("(Returned after rental period)",style: TextStyle(fontSize: 13),)
                      ],
                    ),
                    Text("₹$depo",style: const TextStyle(fontSize: 15),)
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Discount",style: TextStyle(fontSize: 15),),
                    Text("-₹${(totalRent(rentPerMonth,startDate!=null && endDate!=null?endDate!.difference(startDate!).inDays:0)*(double.parse("0.$discount"))).toStringAsFixed(2)}",style: const TextStyle(fontSize: 15,color: Color(0xff118B50)),)
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
                  color: Colors.grey.withValues(alpha:  0.1),
                ),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Amount",style: TextStyle(fontSize: 15),),
                    Text("₹${(totalAmount(totalRent(rentPerMonth,startDate!=null && endDate!=null?endDate!.difference(startDate!).inDays:0),
                        depo,
                        totalRent(rentPerMonth,startDate!=null && endDate!=null?endDate!.difference(startDate!).inDays:0)*(double.parse("0.$discount")),
                        3,
                        0)).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 15),)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.2),borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40,right: 40,top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Boxicons.bxs_check_shield,color: Colors.grey,size: 37,),
                        const SizedBox(width: 17,),
                        Expanded(child: Text("Safe and secure payments. Easy returns. 100% Authentic products.",
                        style: TextStyle(color: Colors.black.withValues(alpha: 0.6),fontWeight: FontWeight.w500,fontSize: 14),))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                    child: Text("By continuing with the order, you confirm that you are above 18 years of age, and you agree to the RentTech's Terms of Use and Privacy Policy.",
                    style: TextStyle(color: Colors.black.withValues(alpha: 0.6),),textAlign: TextAlign.justify,),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(color: const Color(0xffE8DFCA),borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("₹${(totalAmount(totalRent(rentPerMonth,startDate!=null && endDate!=null?endDate!.difference(startDate!).inDays:0),
                        depo,
                        totalRent(rentPerMonth,startDate!=null && endDate!=null?endDate!.difference(startDate!).inDays:0)*(double.parse("0.$discount")),
                        3,
                        0)).toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 19),),
                    Container(
                      width: 200,height: 50,
                      decoration: BoxDecoration(color: const Color(0xff4F6F52),borderRadius: BorderRadius.circular(5)),
                      child: TextButton(
                        child:loading? const CircularProgressIndicator(color: Colors.white,):const Text("Continue",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 19),),
                        onPressed: (){
                          setState(() {
                            loading=true;
                          });
                          if(isLocationAdded && isDurationAdded()){
                            String totalrent=(totalAmount(totalRent(rentPerMonth,startDate!=null && endDate!=null?endDate!.difference(startDate!).inDays:0),
                                depo,
                                totalRent(rentPerMonth,startDate!=null && endDate!=null?endDate!.difference(startDate!).inDays:0)*(double.parse("0.$discount")),
                                3,
                                0)).toStringAsFixed(2);
                            String dis=(totalRent(rentPerMonth,startDate!=null && endDate!=null?endDate!.difference(startDate!).inDays:0)*(double.parse("0.$discount"))).toStringAsFixed(2);
                            Navigator.push(context, MaterialPageRoute(builder: (builder){
                              return PaymentMethod(
                                  documenet: widget.document,
                                  collection: widget.collection,
                                  rent: (totalRent(rentPerMonth,endDate!.difference(startDate!).inDays.toInt())).toStringAsFixed(2),
                                  totalRent: totalrent,
                                  deposite: depo.toString(),
                                  discount: dis,
                                  sellerId: sellerId.toString(),
                                  rentalDuration: (endDate!.difference(startDate!).inDays).toString(),
                                  startDate: DateFormat('yyyy-MM-dd').format(startDate!).toString(),
                                  endDate: DateFormat('yyyy-MM-dd').format(endDate!).toString());
                            }));
                            loading=false;
                          } else {
                            setState(() {
                              loading=false;
                            });
                            if(!isLocationAdded && !isDurationAdded()){
                              Error().toastMessage("Add delivery location and Rental duration.");
                            } else if(!isLocationAdded){
                              Error().toastMessage("Add an delivery location");
                            } else if(!isDurationAdded()){
                              Error().toastMessage("Add an rental duration");
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}