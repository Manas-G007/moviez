import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moviez/utils/theme_colors.dart';
import 'package:moviez/widgets/my_btn.dart';
import 'package:moviez/widgets/my_input.dart';
import 'package:moviez/widgets/my_text.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key,
  required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController=TextEditingController();
  final TextEditingController _phoneController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _confirmPasswordController=TextEditingController();
  
  bool loadState=false;

  void signUpUser() async{
    
    toggleLoad();
    if(samePassword()){
      if(!credentialEmpty()){
        try{
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(), 
            password: _passwordController.text.trim());

          await FirebaseFirestore.instance.collection('Users').add(
            {
              'username':_usernameController.text.trim(),
              'email':_emailController.text.trim(),
              'phone':_phoneController.text.trim()
            }
          );

        }on FirebaseException catch(e){
          showMessage(e.code);
          toggleLoad();
        }

      }else{
        showMessage('Fill empty fields');
        toggleLoad();
      }
    }else{
      showMessage('Passwords not same');
      toggleLoad();
    }
  }

  void toggleLoad(){
    setState(() {
      loadState=!loadState;
    });
  }

  bool samePassword(){
    bool state=_passwordController.text==_confirmPasswordController.text;
    return state;
  }

  bool credentialEmpty(){
    bool state=_usernameController.text.trim().isEmpty && _emailController.text.trim().isEmpty && _phoneController.text.trim().isEmpty;
    return state;
  }

  void showMessage(String message){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title:Text(message)
        );
      });
  }

  @override
  void dispose(){
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            MyInputText(text: 'Username', controller: _usernameController, hide: false),
            const Gap(20),
            MyInputText(text: 'Phone', controller: _phoneController, hide: false),
            const Gap(20),
            MyInputText(text: 'Email', controller: _emailController, hide: false),
            const Gap(20),
            MyInputText(text: 'Password', controller: _passwordController, hide: true),
            const Gap(20),
            MyInputText(text: 'Confirm password', controller: _confirmPasswordController, hide: true),
            const Gap(40),
            GestureDetector(
              onTap:signUpUser,
              child: MyBtn(text: 'Sign up', load: loadState)),
            const Gap(40),
            GestureDetector(
              onTap:widget.onTap,
              child: const MyText(text: 'Already have an account ? Sign in', size: 16))

        ]),
      ),
    );
  }
}