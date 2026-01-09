import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renttech/Error.dart';

import 'CloudinaryService.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final FirebaseAuth _auth=FirebaseAuth.instance;
  CollectionReference update=FirebaseFirestore.instance.collection('Users');
  String? name,contact,email,pfp;
  String? street,city,tal,state,zip;
  File? image;
  String? imageURl;
  bool loading=false;

  final nameController=TextEditingController();
  final contactController=TextEditingController();
  final streetController=TextEditingController();
  final cityController=TextEditingController();
  final talController=TextEditingController();
  final stateController=TextEditingController();
  final zipController=TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<void> getData() async {
    FirebaseAuth auth=FirebaseAuth.instance;
    DocumentSnapshot data=await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser!.uid).get();
    setState(() {
      name=data['name'];
      contact=data['contact'];
      email=data['email'];
      pfp=data['pfpURL'];
      street=data['street'];
      city=data['city'];
      tal=data['tal'];
      state=data['state'];
      zip=data['zip'];
      imageURl=data['pfpURL'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: const Text("Update Profile"),
        backgroundColor: const Color(0xffF5EFE6),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25,right: 25),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,width: 100,
                  decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.black.withValues(alpha: 0.2)),
                  image: DecorationImage(image: pfp!=null?NetworkImage(pfp!):const AssetImage("assets/images/pfp.png"),fit: BoxFit.cover)),
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70,top: 70),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle,border: Border.all(color: Colors.grey.withValues(alpha: 0.8))),
                          child: const Icon(Icons.edit_outlined,size: 18,color: Color(0xff4F6F52),)),
                    ),
                    onTap: () async {
                      final pickedImage =await  ImagePicker().pickImage(source: ImageSource.gallery);
                      image=File(pickedImage!.path.toString());
                      if(image!=null){
                        imageURl=await CloudinaryService().uploadImage(image!);
                        await FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).update({
                          'pfpURL':imageURl.toString(),
                        }).then((value) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile photo updated")));
                        },).onError((error, stackTrace){
                          Error().toastMessage(error.toString());
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            const Text("Personal Information",style: TextStyle(fontSize: 16,color: Colors.black),),
            const SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(hintText: "$name",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.6),),
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.2),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(20)),
              prefixIcon: const Icon(Boxicons.bx_user,size: 23,color: Color(0xff4F6F52),)),
              controller: nameController,
            ),
            const SizedBox(height: 15,),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "+91 $contact",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
                filled: true,
                fillColor: Colors.grey.withValues(alpha: 0.2),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(20)),
                  prefixIcon: const Icon(Icons.call,size: 23,color: Color(0xff4F6F52),)),
              controller: contactController,
            ),
            const SizedBox(height: 15,),
            TextFormField(
              keyboardType: TextInputType.name,
              readOnly: true,
              decoration: InputDecoration(hintText: "$email",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.2),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(20)),
                  prefixIcon: const Icon(Icons.alternate_email_rounded,size: 23,color: Color(0xff4F6F52),)),
            ),
            const SizedBox(height: 20,),
            const Text("Delivery Address",style: TextStyle(fontSize: 16,color: Colors.black),),
            const SizedBox(height: 15,),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(labelText: "Street",hintText: street ?? "",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
                filled: true,
                fillColor: Colors.grey.withValues(alpha: 0.2),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(20)),),
              controller: streetController,
            ),
            const SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: "City",hintText: city ?? "",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
                      filled: true,
                      fillColor: Colors.grey.withValues(alpha: 0.2),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(20)),),
                    controller: cityController,
                  ),
                ),
                const SizedBox(width: 15,),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: "Tal",hintText: tal ?? "",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
                      filled: true,
                      fillColor: Colors.grey.withValues(alpha: 0.2),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(20)),),
                    controller: talController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: "State",hintText: state ?? "",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
                      filled: true,
                      fillColor: Colors.grey.withValues(alpha: 0.2),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(20)),),
                    controller: stateController,
                  ),
                ),
                const SizedBox(width: 15,),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "ZIP",hintText: zip ?? "",hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
                      filled: true,
                      fillColor: Colors.grey.withValues(alpha: 0.2),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(20)),),
                    controller: zipController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.grey)),
                  child: TextButton(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Text("Cancel",style: TextStyle(fontSize: 16,color: Colors.black.withValues(alpha: 0.8),fontWeight: FontWeight.w600),),
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  height: 45,
                  decoration: BoxDecoration(color: const Color(0xff4F6F52),borderRadius: BorderRadius.circular(5)),
                  child: TextButton(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: loading? const CircularProgressIndicator(color: Colors.white,):const Text("Update",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),),
                    ),
                    onPressed: () async {
                      setState(() {
                        loading=true;
                      });
                      if(nameController.text.isEmpty && contactController.text.isEmpty && streetController.text.isEmpty
                          && cityController.text.isEmpty && talController.text.isEmpty && stateController.text.isEmpty && zipController.text.isEmpty){
                        setState(() {
                          const msg=SnackBar(content: Text("No changes has been done!"));
                          ScaffoldMessenger.of(context).showSnackBar(msg);
                          loading=false;
                          Navigator.pop(context);
                          return;
                        });
                      } else {
                          if((contactController.text.isNotEmpty&& contactController.text.length!=10) && (zipController.text.isNotEmpty&& zipController.text.length!=6)){
                            setState(() {
                              loading=false;
                              Error().toastMessage("Invalid Contact and ZIP");
                              return;
                            });
                          } else if(zipController.text.isNotEmpty&& zipController.text.length!=6){
                            setState(() {
                              loading=false;
                              Error().toastMessage("Invalid ZIP Code");
                              return;
                            });
                          } else if(contactController.text.isNotEmpty&& contactController.text.length!=10){
                            setState(() {
                              loading=false;
                              Error().toastMessage("Invalid Contact Number");
                              return;
                            });
                          } else {
                            await update.doc(_auth.currentUser!.uid).update({
                              'name': nameController.text.isEmpty?name:nameController.text.toString(),
                              'contact':contactController.text.isEmpty? contact:contactController.text.toString(),
                              'street': streetController.text.isEmpty? street:streetController.text.toString(),
                              'city': cityController.text.isEmpty?city: cityController.text.toString(),
                              'tal':talController.text.isEmpty? tal:talController.text.toString(),
                              'state':stateController.text.isEmpty?state :stateController.text.toString(),
                              'zip':zipController.text.isEmpty?zip :zipController.text.toString()
                            }).then((onValue){
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile Updated")));
                            });
                          }
                          }
                      }
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}