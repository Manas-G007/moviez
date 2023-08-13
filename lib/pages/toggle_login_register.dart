import 'package:flutter/material.dart';
import 'package:moviez/pages/login_page.dart';
import 'package:moviez/pages/register_page.dart';

class ToggleLoginRegister extends StatefulWidget {
  const ToggleLoginRegister({super.key});

  @override
  State<ToggleLoginRegister> createState() => _ToggleLoginRegisterState();
}

class _ToggleLoginRegisterState extends State<ToggleLoginRegister> {
  bool toggleState=true;

  void togglePage(){
    setState(() {
      toggleState=!toggleState;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(toggleState){
      return LoginPage(
        onTap:togglePage
      );
    }else{
      return RegisterPage(
        onTap:togglePage
      );
    }
  }
}