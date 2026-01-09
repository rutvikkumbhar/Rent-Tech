import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'BottomBar.dart';
import 'SignUp.dart';
import 'package:renttech/Error.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FirebaseAuth _auth=FirebaseAuth.instance;
  final emailController=TextEditingController();
  final passController=TextEditingController();
  bool pass=true;
  bool loading=false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30,),
                Container(
                  child: Lottie.asset("assets/images/Animations/LoginAnimation.json",repeat: true,height: 220,width: 220,fit: BoxFit.cover),
                ),
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email",prefixIcon: const Icon(Icons.alternate_email_rounded,color: Color(0xff4F6F52),),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
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
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: pass?true:false,
                    decoration: InputDecoration(labelText: "Password",prefixIcon: const Icon(Icons.security_outlined,color: Color(0xff4F6F52)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Color(0xff1A4D2E))),
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
                    controller: passController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter valid password!";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 25,),
                Container(
                  width: 250,height: 55,
                  decoration: BoxDecoration(color: const Color(0xff2C3930),borderRadius: BorderRadius.circular(5)),
                  child: TextButton(
                    child: loading?const CircularProgressIndicator(color: Colors.white,):Text("Log In",style: GoogleFonts.audiowide(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 18)),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          loading=true;
                        });
                        await _auth.signInWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passController.text.toString()).then((onValue) async {
                              DocumentSnapshot data=await FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).get();
                              if(data.exists){
                                if(data['role']=="user") {
                                  Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (context) => const BottomBar()),
                                        (Route<dynamic> route) => false,);
                                } else {
                                  _auth.signOut();
                                  setState(() {
                                    loading=false;
                                    Error().toastMessage("Seller can't Log In here!");
                                  });
                                }
                              } else {
                                _auth.signOut();
                                setState(() {
                                  loading=false;
                                  Error().toastMessage("User data not found!");
                                });
                              }

                        }).onError((error, stackTrace){
                          setState(() {
                            loading=false;
                          });
                          Error().toastMessage(error.toString());
                        });
                      } else {
                        setState(() {
                          loading=false;
                        });
                      }
                    },
                  ),
                ),
               const SizedBox(height: 8,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("Don't have any account? ",style: GoogleFonts.audiowide(color: const Color(0xff1A4D2E).withValues(alpha: 0.7),fontSize: 13,fontWeight: FontWeight.w400),),
                   GestureDetector(
                       child: Text("sign up.",style: GoogleFonts.audiowide(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.blue)),
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (builder){
                       return SignUp();
                     }));
                   },
                   ),
                 ],
               ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}