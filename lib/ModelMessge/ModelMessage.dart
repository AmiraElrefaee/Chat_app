import 'package:chat_app/ModelMessge/ModelMessage.dart';
import 'package:chat_app/constants.dart';

class  Message{
  final String message;
  final String id;
  String n='null';
Message(this.message,this.id);
factory Message.fromjson(jsondata){
return Message(jsondata['messages']??'error',jsondata['id']??'error'
);
}
}