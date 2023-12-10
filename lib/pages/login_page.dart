import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snackbar.dart';
import '../widgets/Custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'chat_page.dart';
import 'register_pag.dart';
class LoginPage extends StatefulWidget {
   LoginPage({super.key});
  static String id='LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   bool isLoading=false;

   GlobalKey<FormState> formKey=GlobalKey();
String? email,password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 75,),
                Image.asset(kLogo ,height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 75,),
                Row(
                  children: const [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  onChangerd: (data){
                    email=data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  obscureText: true,
                  onChangerd: (data){
                    password=data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Login',
                  onTap: ()async{
                    if (formKey.currentState!.validate()) {
                      isLoading=true;
                      setState(() {

                      });
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatPage.id,arguments: email);

                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          showSnackBar(context,'User Not Found');
                        } else if (ex.code == 'wrong-password') {
                          showSnackBar(context,'Wrong password');
                        }

                      }catch(ex){
                        showSnackBar(context, 'there was an error');
                      }
                      isLoading=false;
                      setState(() {

                      });
                    }else{

                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'dont have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id,);
                      },
                      child: const Text(
                        ' Sign Up',
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    )
                  ],
                ),
               // const SizedBox(height: 75,),


              ],
            ),
          ),
        ),
      ),
    );
  }
   Future<void> loginUser()async{
     UserCredential user = await FirebaseAuth.instance
         .signInWithEmailAndPassword(
         email: email!, password: password!);
   }


}
