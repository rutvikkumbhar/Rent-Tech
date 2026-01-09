import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: const Text("About RentTech"),
        backgroundColor: const Color(0xffF5EFE6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Text("The Idea",style: GoogleFonts.alice(fontSize: 22),),
            const SizedBox(height: 5,),
            const Text("RentTech was created to make tech products affordable and accessible through rentals. Instead of buying expensive gadgets, users can rent laptops, smartphones, and more for flexible durations.",
            style: TextStyle(color: Colors.black),textAlign: TextAlign.justify,),
            const SizedBox(height: 10,),
            Container(
              height: 1,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 10,),
            Text("About the App",style: GoogleFonts.alice(fontSize: 22),),
            const SizedBox(height: 5,),
            const Text("● Easy browsing and renting of tech products."),
            const Text("● Flexible rental durations."),
            const Text("● Real-time order tracking & notifications."),
            const Text("● Real-time order tracking & notifications."),
            const Text("● AI chat bot for product recommendations."),
            const SizedBox(height: 10,),
            Container(
              height: 1,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 10,),
            Text("About the Developer",style: GoogleFonts.arima(fontSize: 22,color: Colors.black,fontWeight: FontWeight.w500),),
            const SizedBox(height: 5,),
            const Text("Rutvik Kumbhar, a final-year Computer Engineering student, has independently designed and developed RentTech. His previous projects include:",
              textAlign: TextAlign.justify,),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.2),borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 20,),
                        Image.asset("assets/images/villa.png",fit: BoxFit.contain,),
                        const SizedBox(width: 10,),
                        const Text("Villa",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                        const SizedBox(width: 20,),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.2),borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 20,),
                        Image.asset("assets/images/kido.png",fit: BoxFit.contain,),
                        const SizedBox(width: 10,),
                        const Text("Kido Smart",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                        const SizedBox(width: 20,),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15,),
            Container(
              height: 1,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 10,),
            Text("Future Plans",style: GoogleFonts.alice(fontSize: 22),),
            const SizedBox(height: 5,),
            const Text("● Online payments (UPI, Cards)"),
            const Text("● More product categories)"),
            const Text("● Order tracking & AI improvements and more"),
            const SizedBox(height: 15,),
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
            const SizedBox(height: 8,)
          ],
        ),
      )
    );
  }
}