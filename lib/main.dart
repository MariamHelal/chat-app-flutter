import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_pag.dart';
import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id:(context)=>RegisterPage(),
        ChatPage.id:(context)=>ChatPage(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: 'LoginPage',
    );
  }
}
