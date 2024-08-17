import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snackBar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widget/Bottom.dart';
import 'package:chat_app/widget/Text_filelde.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
   Login({super.key});
static String id='login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
String? email;

String ?password;

 bool isLoading=false;
GlobalKey<FormState> formKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:isLoading ,
      child: Scaffold(

        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin:   Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                   kcolor1,
                    kcolor2,

                  ]

              )
          ),
          child: Form(
            key:formKey ,
            child: Column(

              children: [
                Spacer(flex: 2,),
            Image.asset(klogo,
            height: 200,),
                Text('Hello App',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontFamily: 'lemon'
                ),),
                Spacer(flex: 1),
                Row(
                  children: [
                    Text('LOGIN',style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500
                    ),),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextFormFiled(
                  obscure:false ,
                  onChanged: (String value){
                    email=value;

                  },
                  hint: 'Enter Email',
                ),
                SizedBox(
                  height: 10,
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

                        await login();
                        Navigator.pushNamed(context, ChatPage.id,arguments: email );

                      } on FirebaseAuthException catch (e){
                        if (e.code =='user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that 6user.');
                        }
                        else{
                          showMassege(context,e.toString());
                        }
                      }
                      catch(e){
                        showMassege(context,'there are error ');
                      }
                      setState(() {
                        isLoading=false;

                      });

                    }



                  },
                  text: 'login',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('dont\'t have an account ? ',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black54
                    ),),
                    GestureDetector(
                      onTap: (){
                       //  Navigator.push(context, MaterialPageRoute(builder: (context){
                       // return   RegisterScreen();
                       //  }));
                        Navigator.pushNamed(context,RegisterScreen.id);
                      },
                      child: Text('Resgister',
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


Future<void> login() async {
  UserCredential user = await FirebaseAuth.instance
      .signInWithEmailAndPassword(
      email: email!, password: password!);
  print(email);
}
}
