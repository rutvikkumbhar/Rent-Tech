import 'package:flutter/material.dart';
import 'package:renttech/Products/ProdustList.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset("assets/images/LaptopStock-removebg-preview.png"),
                            ),
                          ),
                        ),
                        Text("Laptops",style: TextStyle(color: Colors.black.withValues(alpha: 0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Laptops",);
                      }));
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Image.asset("assets/images/images-removebg-preview (1).png"),
                            ),
                          ),
                        ),
                        Text("Smartphones",style: TextStyle(color: Colors.black.withValues(alpha: 0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Smartphones");
                      }));
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset("assets/images/cameraStock.png"),
                            ),
                          ),
                        ),
                        Text("Cameras",style: TextStyle(color: Colors.black.withValues(alpha: 0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Cameras");
                      }));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                           elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset("assets/images/headphoneStock.png"),
                            ),
                          ),
                        ),
                        Text("Headphones",style: TextStyle(color: Colors.black.withValues(alpha: 0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                      return ProductList(collection: "Headphones");
                      }));
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset("assets/images/ProjectorStock_-removebg-preview.png"),
                            ),
                          ),
                        ),
                        Text("Projectors",style: TextStyle(color: Colors.black.withValues(alpha: 0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Projectors");
                      }));
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset("assets/images/SmartwatchStock-removebg-preview.png"),
                            ),
                          ),
                        ),
                        Text("Smartwatches",style: TextStyle(color: Colors.black.withValues(alpha: 0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Smartwatches");
                      }));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset("assets/images/ConsoleStock.png"),
                            ),
                          ),
                        ),
                        Text("Controllers",style: TextStyle(color: Colors.black.withValues(alpha: 0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Controllers");
                      }));
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset("assets/images/VRheadset.png"),
                            ),
                          ),
                        ),
                        Text("VR Headset",style: TextStyle(color: Colors.black.withValues(alpha: 0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "VR_Headsets");
                      }));
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset("assets/images/Drones.png"),
                            ),
                          ),
                        ),
                        Text("Drones",style: TextStyle(color: Colors.black.withValues(alpha: 0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Drones");
                      }));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset("assets/images/Tablet.png"),
                            ),
                          ),
                        ),
                        Text("Tablets",style: TextStyle(color: Colors.black.withValues(alpha: 0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Tablets");
                      }));
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset("assets/images/Speakers.png"),
                            ),
                          ),
                        ),
                        Text("Speakers",style: TextStyle(color: Colors.black.withValues(alpha: 0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Speakers");
                      }));
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset("assets/images/Printers.png"),
                            ),
                          ),
                        ),
                        Text("Printers",style: TextStyle(color: Colors.black.withValues(alpha: 0.8),fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return ProductList(collection: "Printers");
                      }));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}