import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moviez/utils/theme_colors.dart';
import 'package:moviez/widgets/my_btn.dart';
import 'package:moviez/widgets/my_input.dart';
import 'package:moviez/widgets/my_text.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key,
  required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  bool loadState=false;

  void signInUser() async{
    toggleLoad();
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text);
    }on FirebaseAuthException catch(e){
      
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            title:Text(e.code)
          );
        });

        toggleLoad();
    }
    
  }

  void toggleLoad(){
    setState(() {
      loadState=!loadState;
    });
  }
  
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.darkColor,
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MyText(text: 'Moviez', size: 35),
            const Gap(40),
            MyInputText(text: 'Email', controller: _emailController, hide: false),
            const Gap(20),
            MyInputText(text: 'Password', controller: _passwordController, hide: true),
            const Gap(40),
            GestureDetector(
              onTap:signInUser,
              child: MyBtn(text: 'Sign in', load: loadState)),
            const Gap(40),
            GestureDetector(
              onTap:widget.onTap,
              child: const MyText(text: 'New to this ? Create Account', size: 16))

        ]),
      ),
    );
  }
}