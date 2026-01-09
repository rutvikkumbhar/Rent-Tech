import 'dart:async';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:renttech/EditProfile.dart';
import 'package:renttech/Products/ProductInfo.dart';
import 'AiInfo.dart';
import 'Products/ProdustList.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final FirebaseAuth _auth=FirebaseAuth.instance;
  final PageController _pageController = PageController(viewportFraction: 0.85);
  bool isAdded=false;
  String? collection;
  String? userAddress;
  int currentPage = 0;
  List<String> images = [
    'assets/images/laptop1.png',
    'assets/images/laptop2.jpg',
    'assets/images/laptop3.jpg',
    'assets/images/sale4.png',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    fetchUserAddress();
  }

  void fetchUserAddress() async {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).get();
      setState(() {
        userAddress = userData['city']+" "+userData['zip'];
      });
  }
  void _startAutoSlide() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (currentPage + 1) % images.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() {
          currentPage = nextPage;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView(
          children: [
            SizedBox(
              height: 50,
              child: TextField(
                keyboardType: TextInputType.text,
                readOnly: true,
                decoration: InputDecoration(hintText: "Search for products...",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.5)),fillColor: const Color(0xffF8F5E9),filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search_rounded),
                    onPressed: (){

                    },
                  ),
              ),),
            ),
            const SizedBox(height: 14,),
            Container(
              height: 180,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: currentPage == index ? 0 : 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                          boxShadow: const [ BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 2),],
                          image: DecorationImage( image: AssetImage(images[index]), fit: BoxFit.fill,),
                        ),
                      );
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          images.length,
                              (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: currentPage == index ? 12 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPage == index ? Colors.white : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,)
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(height: 1,width: 100,color: Colors.black87,),
                Text("Top Picks",style: GoogleFonts.audiowide(),),
                Container(height: 1,width: 100,color: Colors.black87,),
              ],
            ),
            const SizedBox(height: 5,),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70,width: 70,
                          child: Card(
                            elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              child: const Padding(
                                padding: EdgeInsets.all(13),
                                child: Icon(Boxicons.bx_mobile_alt,size: 28,),
                              )
                          ),
                        ),
                        const SizedBox(height: 5,),
                        const Text("Phones",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Smartphones");
                      }));
                    },
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 70,width: 70,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              child: const Padding(
                                padding: EdgeInsets.all(13),
                                child: Icon(Boxicons.bx_laptop,size: 28,),
                              ),
                            )
                        ),
                        const SizedBox(height: 5,),
                        const Text("Laptops",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Laptops",);
                      }));
                    },
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 70,width: 70,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              child: const Padding(
                                padding: EdgeInsets.all(11),
                                child: Icon(Boxicons.bxs_watch_alt,size: 28,),
                              ),
                            )
                        ),
                        const SizedBox(height: 5,),
                        const Text("Smartwatch",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Smartwatches");
                      }));
                    },
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 70,width: 70,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              child: const Padding(
                                padding: EdgeInsets.all(13),
                                child: Icon(Boxicons.bx_headphone,size: 28,),
                              ),
                            )
                        ),
                        const SizedBox(height: 5,),
                        const Text("Headphones",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Headphones");
                      }));
                    },
                  ),
                  const SizedBox(width: 20,),
                  GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 70,width: 70,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(Boxicons.bx_camera,size: 28,),
                              ),
                            )
                        ),
                        const SizedBox(height: 5,),
                        const Text("Cameras",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Cameras");
                      }));
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Flash sale",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 22),),
                   const SizedBox(width: 10,),
                    Container(
                      decoration: BoxDecoration(color: const Color(0xffA9C46C),borderRadius: BorderRadius.circular(3)),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                        child: Text("10 days left",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("See all",style: TextStyle(color: Colors.black.withValues(alpha: 0.5),fontSize: 15),),
                    const SizedBox(width: 7,),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(color:  const Color(0xff4F6F52).withValues(alpha: 0.4),borderRadius: BorderRadius.circular(50),),
                          child: const Icon(Icons.keyboard_arrow_right_rounded,size: 20,)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder){
                          return ProductList(collection: "Laptops");
                        }));
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 220,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Laptops').snapshots(),
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
                                  Text("${data['title'].toString().length>23?"${data['title'].toString().substring(0,23)}...":data['title']}",
                                    style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 13),),
                                  Text(
                                    "₹${(int.parse(data['rentPerMonth']) - (int.parse(data['rentPerMonth']) * (double.parse(data['discount']) / 100))).toStringAsFixed(2)}/mo",
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                  ),
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
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Users").doc(_auth.currentUser!.uid).collection('Recently_Visited').doc('Recent_Visited_Product').snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> streamSnapshot){
                if(streamSnapshot.hasError){
                  return const Center(child: Text("Something went wrong"),);
                } else if(!streamSnapshot.hasData || !streamSnapshot.data!.exists){
                  return const Center(child: SizedBox());
                } else {
                  Map<String, dynamic> data=streamSnapshot.data!.data() as Map<String, dynamic>;
                  isAdded=true;
                  collection=data['pType'].toString();
                  return Column(
                    children: [
                      GestureDetector(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Recently Visited",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 21),),
                          ],
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder){
                            return ProductInfo(collection: data['pType'].toString(), document: data['pID'].toString());
                          }));
                        },
                      ),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        child: Container(
                          height:190,
                          decoration: BoxDecoration(image: const DecorationImage(image: AssetImage("assets/images/recent_background.jpg"),fit: BoxFit.fill,filterQuality: FilterQuality.high),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 3, spreadRadius: 2),
                            ],),
                          child: Container(
                            height: 210,
                            decoration: BoxDecoration(gradient:LinearGradient(colors: [Colors.black.withValues(alpha: 0.9),Colors.transparent],begin: Alignment.centerLeft,end: Alignment.centerRight),
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15))),
                            child: Stack(children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 170,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${data['brand']}",style: const TextStyle(color: Colors.white,fontSize: 20),),
                                          const SizedBox(height: 5),
                                          Text(data['title'].toString().length>50?"${data['title'].toString().substring(0,50)}...":data['title'],style: const TextStyle(color: Colors.white),),
                                          const Spacer(),
                                          const Text("Rented by",style: TextStyle(color: Colors.white),),
                                          const Row(
                                            children: [
                                              Text("200+ Users",style: TextStyle(color: Colors.white,fontSize: 17),),
                                              SizedBox(width: 10,),
                                              Icon(Icons.local_fire_department,color: Colors.orangeAccent,)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 160,
                                          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data['png']))),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("₹${(int.parse(data['rentPerMonth']) - (int.parse(data['rentPerMonth']) * (double.parse(data['discount']) / 100))).toStringAsFixed(2)}/mo",
                                              style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),),
                                            const SizedBox(width: 10,),
                                            const FaIcon(FontAwesomeIcons.sackDollar,size:18,color: Colors.greenAccent,)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder){
                            return ProductInfo(collection: data['pType'], document: data['pID']);
                          }));
                        },
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        height: 5,width: MediaQuery.of(context).size.width,
                        color: Colors.grey.withValues(alpha: 0.1),
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${isAdded?"Similar":"New"} products",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 21),),
                Row(
                  children: [
                    Text("See all",style: TextStyle(color: Colors.black.withValues(alpha: 0.5),fontSize: 15),),
                    const SizedBox(width: 7,),
                    GestureDetector(
                      child: Container(
                          decoration: BoxDecoration(color:  const Color(0xff4F6F52).withValues(alpha: 0.4),borderRadius: BorderRadius.circular(50),),
                          child: const Icon(Icons.keyboard_arrow_right_rounded,size: 20,)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder){
                          return ProductList(collection: collection==null?"Smartphones":collection.toString());
                        }));
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 210,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection(collection==null?'Smartphones':collection.toString()).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                  if(streamSnapshot.connectionState== ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  } else if(streamSnapshot.hasError){
                    return const Center(child: Text("Something went wrong!"),);
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (itemBuilder, index){
                        DocumentSnapshot data=streamSnapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (builder){
                              return ProductInfo(collection: data['pType'], document: data.id);
                            }));
                          },
                          child: SizedBox(
                            width: 140,
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
                                  Text("₹${(int.parse(data['rentPerMonth']) - (int.parse(data['rentPerMonth']) * (double.parse(data['discount']) / 100))).toStringAsFixed(2)}/mo"
                                      ,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
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
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder){
                  return const AiInfo();
                }));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: const Color(0xffADB2D4).withValues(alpha: 0.9),borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Lottie.asset("assets/images/Animations/AI.json",width: 180),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("AI Chat is Here!",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black,)),
                          const Text("Need quick answers? Our AI-powered chat-bot is now available!",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87,),),
                          Text("Tap to start chatting or learn more!",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueAccent.withValues(alpha: 0.8),)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xffF5EFE6), // Light background
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 3, spreadRadius: 2),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, color: Colors.red, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: userAddress != null && userAddress!.isNotEmpty
                        ? Text("📍 Delivery Address:\n$userAddress",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87), maxLines: 2, overflow: TextOverflow.ellipsis,)
                        : const Text("⚠ No delivery address found.\nTap to add an address.",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xff4F6F52)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return const EditProfile();
                      }));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              height: 245,
              decoration: BoxDecoration(image: const DecorationImage(image: AssetImage("assets/images/trending_background.jpg"),fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Row(
                        children: [
                          Text("Trending now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),),
                          SizedBox(width: 5,),
                          Icon(Icons.local_fire_department,color: Colors.orangeAccent,size: 28,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: SizedBox(
                        height: 180,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('Laptops').snapshots(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                                if(streamSnapshot.connectionState==ConnectionState.waiting){
                                  return const Center(child: CircularProgressIndicator(),);
                                } else if(streamSnapshot.hasError){
                                  return const Center(child: Text("Something went wrong"),);
                                } else if(!streamSnapshot.hasData || streamSnapshot.data!.docs.isEmpty){
                                  return Center(child: Lottie.asset("assets/images/Animations/Loading.json",repeat:  true),);
                                } else {
                                  DocumentSnapshot data=streamSnapshot.data!.docs[1];
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                                        return ProductInfo(collection: data['pType'], document: data.id);
                                      }));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,width: 150,
                                          decoration: BoxDecoration(color: const Color(0xffE4B1F0).withValues(alpha: 0.9),borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(20))),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(),
                                              SizedBox(
                                                height: 90,width: 90,
                                                  child: Image.network("${data['png']}")),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Text("${data['brand']}",style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 30,width: 150,
                                          decoration: const BoxDecoration(color: Colors.black,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Rating().rating("3")
                                              Text("Just ₹${(int.parse(data['rentPerMonth']) - (int.parse(data['rentPerMonth']) * (double.parse(data['discount']) / 100))).toStringAsFixed(2)}/mo",
                                                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(width: 15,),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('Smartphones').snapshots(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                                if(streamSnapshot.connectionState==ConnectionState.waiting){
                                  return const Center(child: CircularProgressIndicator(),);
                                } else if(streamSnapshot.hasError){
                                  return const Center(child: Text("Something went wrong"),);
                                } else if(!streamSnapshot.hasData || streamSnapshot.data!.docs.isEmpty){
                                  return Center(child: Lottie.asset("assets/images/Animations/Loading.json",repeat:  true),);
                                } else {
                                  DocumentSnapshot data=streamSnapshot.data!.docs[1];
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                                        return ProductInfo(collection: data['pType'], document: data.id);
                                      }));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,width: 150,
                                          decoration: BoxDecoration(color: const Color(0xffE4B1F0).withValues(alpha: 0.9),borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(20))),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(),
                                              SizedBox(
                                                  height: 90,width: 90,
                                                  child: Image.network("${data['png']}")),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Text("${data['brand']}",style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 30,width: 150,
                                          decoration: const BoxDecoration(color: Colors.black,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Rating().rating("3")
                                              Text("Just ₹${data['rentPerMonth']}/mo",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(width: 15,),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('Cameras').snapshots(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                                if(streamSnapshot.connectionState==ConnectionState.waiting){
                                  return const Center(child: CircularProgressIndicator(),);
                                } else if(streamSnapshot.hasError){
                                  return const Center(child: Text("Something went wrong"),);
                                } else if(!streamSnapshot.hasData || streamSnapshot.data!.docs.isEmpty){
                                  return Center(child: Lottie.asset("assets/images/Animations/Loading.json",repeat:  true),);
                                } else {
                                  DocumentSnapshot data=streamSnapshot.data!.docs[1];
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                                        return ProductInfo(collection: data['pType'], document: data.id);
                                      }));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,width: 150,
                                          decoration: BoxDecoration(color: const Color(0xffE4B1F0).withValues(alpha: 0.9),borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(20))),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(),
                                              SizedBox(
                                                  height: 90,width: 90,
                                                  child: Image.network("${data['png']}")),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Text("${data['brand']}",style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 30,width: 150,
                                          decoration: const BoxDecoration(color: Colors.black,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Rating().rating("3")
                                              Text("Just ₹${data['rentPerMonth']}/mo",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(width: 15,),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('Headphones').snapshots(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                                if(streamSnapshot.connectionState==ConnectionState.waiting){
                                  return const Center(child: CircularProgressIndicator(),);
                                } else if(streamSnapshot.hasError){
                                  return const Center(child: Text("Something went wrong"),);
                                } else if(!streamSnapshot.hasData || streamSnapshot.data!.docs.isEmpty){
                                  return Center(child: Lottie.asset("assets/images/Animations/Loading.json",repeat:  true),);
                                } else {
                                  DocumentSnapshot data=streamSnapshot.data!.docs[1];
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                                        return ProductInfo(collection: data['pType'], document: data.id);
                                      }));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,width: 150,
                                          decoration: BoxDecoration(color: const Color(0xffE4B1F0).withValues(alpha: 0.9),borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(20))),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(),
                                              SizedBox(
                                                  height: 90,width: 90,
                                                  child: Image.network("${data['png']}")),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Text("${data['brand']}",style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 30,width: 150,
                                          decoration: const BoxDecoration(color: Colors.black,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Rating().rating("3")
                                              Text("Just ₹${data['rentPerMonth']}/mo",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(width: 15,),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('Smartwatches').snapshots(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                                if(streamSnapshot.connectionState==ConnectionState.waiting){
                                  return const Center(child: CircularProgressIndicator(),);
                                } else if(streamSnapshot.hasError){
                                  return const Center(child: Text("Something went wrong"),);
                                } else if(!streamSnapshot.hasData || streamSnapshot.data!.docs.isEmpty){
                                  return Center(child: Lottie.asset("assets/images/Animations/Loading.json",repeat:  true),);
                                } else {
                                  DocumentSnapshot data=streamSnapshot.data!.docs[1];
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                                        return ProductInfo(collection: data['pType'], document: data.id);
                                      }));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,width: 150,
                                          decoration: BoxDecoration(color: const Color(0xffE4B1F0).withValues(alpha: 0.9),borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(20))),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(),
                                              SizedBox(
                                                  height: 90,width: 90,
                                                  child: Image.network("${data['png']}")),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Text("${data['brand']}",style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 30,width: 150,
                                          decoration: const BoxDecoration(color: Colors.black,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Rating().rating("3")
                                              Text("Just ₹${data['rentPerMonth']}/mo",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(width: 15,),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Rent Tech",style: GoogleFonts.akayaTelivigala(textStyle: TextStyle(fontSize: 25,color: Colors.black.withValues(alpha: 0.2)),),),
              ],
            ),
          ]
        ),
      )
    );
  }
}