import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:renttech/CloudinaryService.dart';
import 'package:renttech/Login.dart';
import 'package:renttech/Error.dart';
import 'package:renttech/Success.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  File? image;
  String? imageURl;
  bool pass=true;
  bool load=false;
  final _key=GlobalKey<FormState>();
  final nameController=TextEditingController();
  final contactController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  final FirebaseAuth _auth=FirebaseAuth.instance;
  CollectionReference ref=FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          backgroundColor: const Color(0xffF5EFE6),
          body: ListView(
            children: [
              Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40,),
                    Text("Welcome",style: GoogleFonts.amita(fontSize: 35,color: const Color(0xff1A4D2E)),),
                    const SizedBox(height: 5,),
                    Text("Sign up to get started",style: GoogleFonts.audiowide(fontWeight: FontWeight.w100,color: const Color(0xff4F6F52).withValues(alpha: 0.8))),
                    GestureDetector(
                      child: Lottie.asset("assets/images/Animations/AddProfilePhoto.json",repeat: true,height: 150,width: 150,fit: BoxFit.cover),
                      onTap: () async {
                        final pickedImage =await  ImagePicker().pickImage(source: ImageSource.gallery);
                        image=File(pickedImage!.path.toString());
                        if(image!=null){
                           imageURl=await CloudinaryService().uploadImage(image!);
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(labelText: "Name",prefixIcon: const Icon(Icons.person_outline_rounded,color: Color(0xff4F6F52)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                          floatingLabelStyle: const TextStyle(color: Colors.black),),
                        controller: nameController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter valid name!";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Contact",prefixIcon: const Icon(Icons.call_outlined,color: Color(0xff4F6F52) ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                          floatingLabelStyle: const TextStyle(color: Colors.black),),
                        controller: contactController,
                        validator: (value){
                          if(value!.isEmpty || value.length!=10){
                            return "Enter valid number!";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: "Email",prefixIcon: const Icon(Icons.alternate_email_outlined,color: Color(0xff4F6F52) ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                          floatingLabelStyle: const TextStyle(color: Colors.black),),
                        controller: emailController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter valid email!";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: pass?true:false,
                        decoration: InputDecoration(labelText: "Password",prefixIcon: const Icon(Icons.security_outlined,color: Color(0xff4F6F52)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
                            floatingLabelStyle: const TextStyle(color: Colors.black),
                          suffixIcon: IconButton(
                              icon: pass?const FaIcon(FontAwesomeIcons.eyeSlash,size: 21,color: Color(0xff118B50),):const FaIcon(FontAwesomeIcons.eye,size: 21,color: Color(0xffE52020),),
                              onPressed: (){
                                setState(() {
                                  pass=pass?false:true;
                                });
                              }),
                        ),
                        controller: passwordController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter valid password!";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Container(
                      width: 250,height: 55,
                      decoration: BoxDecoration(color: const Color(0xff2C3930),borderRadius: BorderRadius.circular(5)),
                      child: TextButton(
                        child:load?const CircularProgressIndicator(color: Colors.white,) :Text("Sign Up",style: GoogleFonts.audiowide(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 18)),
                        onPressed: () async {
                          setState(() {
                            load=true;
                          });
                          if(_key.currentState!.validate()){
                            await _auth.createUserWithEmailAndPassword(
                              email: emailController.text.toString(),
                              password: passwordController.text.toString(),
                            ).then((onValue) async {
                              await ref.doc(_auth.currentUser!.uid).set({
                                'name':nameController.text.toString(),
                                'contact':contactController.text.toString(),
                                'email':emailController.text.toString(),
                                'password':passwordController.text.toString(),
                                'pfpURL':imageURl?.toString(),
                                'street':null,
                                'city':null,
                                'tal':null,
                                'state':null,
                                'zip':null,
                                'role':'user'
                              }).then((onValue){
                                Success().toastMessage("Account Created Successfully");
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder){
                                  return const Login();
                                }));
                              });
                            }).onError((stackTrace, error){
                              setState(() {
                                load=false;
                              });
                              Error().toastMessage(error.toString());
                            });
                          } else {
                            setState(() {
                              load=false;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ",style: GoogleFonts.audiowide(color: const Color(0xff1A4D2E).withValues(alpha: 0.7),fontSize: 13,fontWeight: FontWeight.w400),),
                        GestureDetector(
                          child: Text(" Log in.",style: GoogleFonts.audiowide(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.blue)),
                          onTap: (){
                            Navigator.pop(context, MaterialPageRoute(builder: (builder){
                              return const Login();
                            }));
                          },
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
  }
}