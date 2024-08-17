import 'package:chat_app/ModelMessge/ModelMessage.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/cupertino.dart';

class chatBuble extends StatelessWidget {
   chatBuble({
    super.key,required this.message
  });
 final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(15),



          decoration: BoxDecoration(

              color: kcolor2,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft:  Radius.circular(30),
                bottomRight:  Radius.circular(30),
              )

          ),
          child:
          Text(message.message,
            style: TextStyle(
                fontSize: 25,

            ),)

      ),
    );
  }
}
class chatBubleForFrined extends StatelessWidget {
  chatBubleForFrined({
    super.key,required this.message
  });
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(15),



          decoration: BoxDecoration(

              color: kcolor1,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft:  Radius.circular(30),
                bottomLeft:  Radius.circular(30),
              )

          ),
          child:
          Text(message.message,
            style: TextStyle(
              fontSize: 25,

            ),)

      ),
    );
  }
}