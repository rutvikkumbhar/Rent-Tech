import 'package:flutter/material.dart';

class AiInfo extends StatelessWidget {
  const AiInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: const Text("RentTech AI"),
        backgroundColor: const Color(0xffF5EFE6),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15 ),
        child: ListView(
          children: [
            const Text("🚀 Meet RentTech AI – Powered by Google Gemini 1.5 Flash",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87,),),
            const SizedBox(height: 10),
            Container(
              height: 1,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 10),
            const Text("RentTech AI is built using Google Gemini 1.5 Flash, delivering fast, intelligent, and real-time responses.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54,),),
            const SizedBox(height: 15),
            const Text("✨ Features:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black,),),
            const SizedBox(height: 5),
            const Text(
              "✅ Get Instant Answers\n"
                  "✅ Personalized Product Recommendations\n"
                  "✅ 24/7 Tech Assistance",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87,),),
            const SizedBox(height: 15),
            Container(
              height: 1,width: MediaQuery.of(context).size.width,
              color: Colors.grey.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 10),
            const Text("💡 How It Works?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black,),),
            const SizedBox(height: 5),
            const Text("Simply type your question, and our AI will instantly respond!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87,),),
            const SizedBox(height: 20,),
            const Text("💬 How RentTech AI Works",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(10),),
              child: const Text("What is RentTech AI?", style: TextStyle(fontSize: 16, color: Colors.black)),
            ),

            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10),),
              child: const Text("RentTech AI is powered by Google Gemini 1.5 Flash, designed to help users find and rent tech products easily.",
                style: TextStyle(fontSize: 16, color: Colors.black),),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(10),),
              child: const Text("How can I rent a product?", style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10),),
              child: const Text("Simply browse the available products, select the rental duration, and proceed with the checkout process.",
                style: TextStyle(fontSize: 16, color: Colors.black),),
            ),
          ],
        ),
      )
    );
  }

}