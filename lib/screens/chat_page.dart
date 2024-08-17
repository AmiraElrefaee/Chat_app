

import 'package:chat_app/ModelMessge/ModelMessage.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/widget/chatBuble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChatPage extends StatefulWidget {

   ChatPage({super.key});
 static String id='chatPage';


  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controler=ScrollController();
TextEditingController controller= TextEditingController();

   CollectionReference messages = FirebaseFirestore.instance.collection(kmessageCollection);

 var data;

  @override
  Widget build(BuildContext context) {
   var email= ModalRoute.of(context)!.settings.arguments ;

    return StreamBuilder<QuerySnapshot>(
      stream:messages.orderBy(ktime,descending:true).snapshots(),
      builder: (context,snapshot){
      // print(  snapshot.data!.docs[0]['messages']);
       if(snapshot.hasData){
         List<Message>messafeList=[];
         for(int i=0;i<snapshot.data!.docs.length;i++){
           messafeList.add(Message.fromjson(snapshot.data!.docs[i]));
         }
      return  Scaffold(

          appBar: AppBar(
            automaticallyImplyLeading: false,
            shadowColor: kcolor1,
            // foregroundColor: kcolor1,
            backgroundColor: kcolor2,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png',
                  height: 70,),
                Text('chat',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontFamily: 'lemon'
                  ),),
              ],
            ),
            centerTitle: true,

          ),

          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                        fit:BoxFit.fill
                )
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controler,
                    itemCount: messafeList.length,

                      itemBuilder:(context,index){

                        return messafeList[index].id==email ? chatBuble(

                          message:messafeList[index] ,
                        ): chatBubleForFrined(message: messafeList[index]);

                      }

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(

                    style: TextStyle(
                      fontSize: 23,
                    ),
                    controller: controller,
                    onChanged:( value ){
                      data=value;
                      // messages.add({'messages': value});
                      // controller.clear();
                    } ,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey,
                        hintText: 'send massege',
                        hintStyle: TextStyle(
                            fontSize: 20
                        ),
                        suffixIcon: Container(
                          width: 50,
                          decoration: BoxDecoration(

                            // color: Colors.amber,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: IconButton(icon: Icon(Icons.send,

                            size: 35,),
                            onPressed: () {
                              messages.add({'messages': data,
                                ktime:DateTime.now(),
                                'id':email
                              });
                              controller.clear();
                              _controler.animateTo(
                                  0,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            },),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),

                          borderSide: BorderSide(
                              color: kcolor2,
                              width:5
                          ),
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
       else
         {
           return ModalProgressHUD(
             inAsyncCall:true ,
             child: Scaffold(

             ),
           );
         }
      },

    );
  }
}


