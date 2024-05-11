import 'package:chat_application/widgets/chat_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/new_message.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          IconButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.exit_to_app,
          ),
            color: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ChatMessage(),
          ),
          NewMessage()
        ],
      ),
    );
  }
}
