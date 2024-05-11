import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _messageController.dispose();
  }

  _sendMessage() async
  {
    final enteredMessage = _messageController.text;
    final User? currUser = FirebaseAuth.instance.currentUser;

    if(enteredMessage.trim().isEmpty)
    {
      return;
    }
    FocusScope.of(context).unfocus();
    _messageController.clear();

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currUser!.uid)
        .get();

    await FirebaseFirestore.instance
        .collection('chat')
        .add({
      'text' : enteredMessage,
      'createdAt' : Timestamp.now(),
      'userId' : currUser!.uid,
      'username' : userData.data()!['username'],
      'userImage' : userData.data()!['image_url'],
    });


  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Send a message ...',
              ),
              controller: _messageController,
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(onPressed: _sendMessage,
              icon: Icon(Icons.send),
              color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
