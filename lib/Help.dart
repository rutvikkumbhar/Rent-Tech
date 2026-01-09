import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: const Text("Help"),
        backgroundColor: const Color(0xffF5EFE6),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text("About RentTech",style: GoogleFonts.alice(fontSize: 23),),
            const SizedBox(height: 5,),
            const Text("Welcome to RentTech, your go-to platform for renting tech products with ease. Whether you need a laptop, smartphone, gaming console, or other electronics, RentTech offers a seamless renting experience with flexible durations and affordable pricing.",
            style: TextStyle(color: Colors.black),textAlign: TextAlign.justify,),
            const SizedBox(height: 15),
            Container(
              height: 1,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 15,),
            Text("How Can We Help You?",style: GoogleFonts.alice(fontSize: 23),),
            const SizedBox(height: 10,),
            Text("1. How to Rent a Product?",
              style: TextStyle(fontSize: 17,color: Colors.black.withValues(alpha: 0.8)),),
            const SizedBox(height: 6,),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("-Browse through available categories on the Home Page."),
                  Text("-Select the product you want and view its detailed information."),
                  Text("-Click on \"Rent Now\" fill in your rental duration & delivery details, and proceed to checkout."),
                  Text("-Your order will be processed, and you can track it under \"My Orders\"."),
                ],
              ),
            ),
            const SizedBox(height: 13,),
            Text("2. How is the Rent Price & Deposit Calculated?",
              style: TextStyle(fontSize: 17,color: Colors.black.withValues(alpha: 0.8)),),
            const SizedBox(height: 6,),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("-The rent price is based on the product’s original cost and rental duration."),
                  Text("-A fully refundable deposit is required and will be returned after successful product return."),
                  Text("-Delivery charges may apply based on location."),
                ],
              ),
            ),
            const SizedBox(height: 13,),
            Text("3. What Payment Options Are Available?",
              style: TextStyle(fontSize: 17,color: Colors.black.withValues(alpha: 0.8)),),
            const SizedBox(height: 6,),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Currently, Cash on Delivery (COD) is the only available option."),
                  Text("Online payment methods (UPI, Cards) will be added soon."),
                ],
              ),
            ),
            const SizedBox(height: 13,),
            Text("4. What Happens If I Don’t Return the Product on Time?",
              style: TextStyle(fontSize: 17,color: Colors.black.withValues(alpha: 0.8)),),
            const SizedBox(height: 6,),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("-Late returns may result in extra rental charges."),
                  Text("-If a product is damaged or lost, the refundable deposit may be adjusted accordingly."),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              height: 1,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 10,),
            Text("Need Assistance?",style: GoogleFonts.alice(fontSize: 23),),
            const SizedBox(height: 8,),
            const ListTile(
              title: Row(
                children: [
                  Text("Email: "),
                  Text("rutvik.work.hub@gmail.com",style: TextStyle(color: Colors.blueAccent),)
                ],
              ),
              leading: Icon(Icons.email_outlined,color: Color(0xff1A4D2E),size: 22,),
            ),
            const ListTile(
              title: Text("Call: +91 96991 69711"),
              leading: Icon(Icons.call_outlined,color: Color(0xff1A4D2E),size: 22,),
            ),
            const ListTile(
              title: Text("Support Hours: Mon-Sat, 9 AM - 7 PM"),
              leading: Icon(Icons.access_time_rounded,color: Color(0xff1A4D2E),size: 22,),
            ),
            const SizedBox(height: 8,),
            Text("Rent Smart, Rent Easy – RentTech!",style: GoogleFonts.akayaTelivigala(textStyle: const TextStyle(fontSize: 22,),color: Colors.black.withValues(alpha: 0.4)),textAlign: TextAlign.center,),
            const SizedBox(height: 8,),
          ],
        ),
      )
    );
  }
}