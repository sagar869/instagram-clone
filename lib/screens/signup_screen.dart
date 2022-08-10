import 'dart:typed_data';

import 'package:demo/resources/auth_methos.dart';
import 'package:demo/responsive/mobile_screen.dart';
import 'package:demo/responsive/responsive_layout.dart';
import 'package:demo/responsive/web_screen.dart';
import 'package:demo/screens/login_screen.dart';
import 'package:demo/untils/colors.dart';
import 'package:demo/untils/utils.dart';
import 'package:demo/widgets/text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  void signUpUser()async{
    setState(() {
      _isLoading= true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        userName: _usernameController.text,
        file: _image!);

    setState(() {
      _isLoading= false;
    });
    if(res != "successfull"){
      showSnackBar(context, res);
    }else{
      Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ResponsiveLayout(
        mobileScreenLayout: const MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      )));

    }
  }
  
  void navigateToLogin(){
    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:_isLoading ? const Center(child: CircularProgressIndicator(color: primaryColor,),): Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              //svg image
              const SizedBox(
                height: 64,
              ),
              //circuler widget to accept and show our selected file
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 60, backgroundImage: MemoryImage(_image!))
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1651283409451-ade0edda54fb?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=830"),
                        ),
                  Positioned(
                      bottom: -8,
                      left: 75,
                      child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo)))
                ],
              ),
              const SizedBox(
                height: 24,
              ),

              //text fireld username
              TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: "Enter your name",
                  textInputType: TextInputType.text),

              const SizedBox(
                height: 24,
              ),
              //text field email
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: "Enter your email",
                  textInputType: TextInputType.emailAddress),
              //text field pass
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Enter your password",
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),

              //bottom log in
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: blueColor),
                  child: const Text("Sign up"),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),

              //transition to signing up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Already have an account! "),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap:navigateToLogin,
                    child: Container(
                      child: const Text(
                        "Log in",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
