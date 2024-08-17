import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snackBar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/widget/Bottom.dart';
import 'package:chat_app/widget/Text_filelde.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class RegisterScreen extends StatefulWidget {
   RegisterScreen({super.key});
 static String id ='register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 String? email;

 String ?password;

 String ?name1;

 String ?name2;

 bool isLoading =false;

 GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(

        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin:   Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kcolor1,
                    kcolor2

                  ]

              )
          ),
          child: Form(
            key:formKey ,
            child: ListView(

                children: [
                 SizedBox(
                   height: 70,
                 ),
                  Image.asset('assets/images/chat.png',
                  height: 180,),

                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hello App',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontFamily: 'lemon'
                        ),),
                    ],
                  ),
                  SizedBox(
                    height: 85,
                  ),
                  Row(
                    children: [
                      Text('REGISTER',style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500
                      ),),
                    ],
                  ),

                  CustomTextFormFiled
                    (obscure: false,
                    onChanged: (String value){
                      name1=value;
                    },
                    hint: 'first name',
                  ),
                  CustomTextFormFiled(
                    obscure: false,
                    onChanged: (String value){
                      name2=value;
                    },
                    hint: 'last name',
                  ),
                  CustomTextFormFiled(
                    obscure: false,
                    onChanged: (String value){
                      email=value;
                    },
                    hint: 'Enter Email',
                  ),

                  CustomTextFormFiled(
                    obscure: true,
                    onChanged: (String value){
                      password=value;
                    },
                    hint: 'password',
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  CustomBotton(
                    onTap: ()async{

                       if (formKey.currentState!.validate()) {


                         setState(() {
                           isLoading=true;
                         });
                         try {
                           print(3);
                           await register();
                           Navigator.pushNamed(context, ChatPage.id);
                         }
                         on FirebaseAuthException  catch (e) {
                           print('2');
                           if (e.code == 'weak-password') {
                             showMassege(context,'The password provided is too weak.');
                             // print('The password provided is too weak.');
                           } else if (e.code == 'email-already-in-use') {
                             showMassege(context,'The account already exists for that email.');
                             // print('The account already exists for that email.');
                           }
                           else{
                             showMassege(context,'rewrite this information');
                           }
                         }
                         catch(e){
                           showMassege(context,'there are error ');
                           print(e);

                         }
                         setState(() {
                           isLoading=false;

                         });

                       }



                    },
                    text: 'Register',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('already have account ?  ',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black54
                        ),),
                      GestureDetector(
                        onTap: (){
                          // Navigator.pushNamed(context, 'login');
                          Navigator.pop(context);
                        },
                        child: Text('login',
                          style: TextStyle(
                              fontSize: 22,
                              color: Color(0xff2A4459)
                          ),),
                      )
                    ],
                  ),
                  Spacer(flex: 3,)
                ]
            ),
          ),
        ),
      ),
    );
  }



  Future<void> register() async {
      UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email!, password: password!);
    print(user.user!.displayName);
  }
}
