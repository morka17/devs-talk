import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:devs_talk/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// firestore instance
final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = '/chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
final _auth = FirebaseAuth.instance;

TextEditingController messageController = TextEditingController();
ScrollController scrollController = ScrollController();
  
  Future<void> callback()async{
    if(messageController.text.length >0){
      await _fireStore.collection('messages').add({
       'text':messageController.text,
       'from':loggedInUser.email,
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  String messageText;
  String messageSender;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {}
  }

//  void getMessages()async{
//    final messages = await _fireStore.collection('messages').getDocuments();
//      for (var message in messages.documents){
//      print(message);
//      }
//  }
  void messageStream() async {
    await for (var snapshot in _fireStore.collection('messages').snapshots()) {
      for (var message in snapshot.documents) {
        print(message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:Hero(
          tag: 'logo',
          child:Container(
            height: 40.0,
            child: Image.asset('images/logo2.png'),
          ),
        ),
        title: Text('Devs Chat'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              _auth.signOut();
              Navigator.pop(context);
            },          
          ),
        ],
      ),
      body:SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child:StreamBuilder<QuerySnapshot>(
                stream: _fireStore.collection('message').snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                       child: CircularProgressIndicator(
                         backgroundColor: Colors.lightBlueAccent,
                       ),
                    );
                  }
      
                    List<DocumentSnapshot> docs = snapshot.data.documents;

                    List<Widget> messages = docs.map((docs)=>Message(
                     from: docs.data['from'] ?? loggedInUser.email, 
                     text: docs.data['text'],
                     me: loggedInUser.email == docs.data['from'],
                     
                    )).toList();

                    return Expanded(
                      child: ListView(
                      controller: scrollController,
                      children:messages,
                     ),
                    );
                    
                  
                }
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => callback(),
                      controller: messageController,
                       decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  SendButton(
                    text: 'Send',
                    callback: callback,
                  ),
                ],
              ),
            ),
          ],
        ),
      ) ,
    );
  }
}

class Message extends StatelessWidget {
 const Message({this.from , this.me ,this.text});

  final String from;
  final String text;
  final bool me;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: 
        me?CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            from,
              style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
               ),
          ),
          Material(
            color: me?Colors.blue:Colors.teal ,
            borderRadius: me
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30.0)),
            elevation: 6.0,
            child:Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(text),
            ) ,
            ),
        ],
      ),
      
    );
  }
}

class SendButton extends StatelessWidget {

  const SendButton({ this.text,this.callback});

  final String text;
  final Function callback;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.lightBlue,
      onPressed: callback,
      child: Text(text,
      style: kSendButtonTextStyle,
      ),
    );
  }
}


















































































































   