import 'package:demo/resources/auth_methos.dart';
import 'package:demo/responsive/mobile_screen.dart';
import 'package:demo/responsive/responsive_layout.dart';
import 'package:demo/responsive/web_screen.dart';
import 'package:demo/screens/signup_screen.dart';
import 'package:demo/untils/colors.dart';
import 'package:demo/untils/utils.dart';
import 'package:demo/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "succesfull") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>ResponsiveLayout(
        mobileScreenLayout: const MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      )));
    } else {
      showSnackBar(context, res);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup(){
    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(),
                      flex: 1,
                    ),
                    //svg image
                    SizedBox(
                      height: 64,
                    ),

                    //text field email
                    TextFieldInput(
                        textEditingController: _emailController,
                        hintText: "Enter your email",
                        textInputType: TextInputType.emailAddress),
                    //text field pass
                    SizedBox(
                      height: 24,
                    ),
                    TextFieldInput(
                      textEditingController: _passwordController,
                      hintText: "Enter your password",
                      textInputType: TextInputType.visiblePassword,
                      isPass: true,
                    ),
                    SizedBox(
                      height: 24,
                    ),

                    //bottom log in
                    InkWell(
                      onTap: loginUser,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            color: blueColor),
                        child: Text("Log in"),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Flexible(
                      child: Container(),
                      flex: 2,
                    ),

                    //transition to signing up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text("Don't have an account? "),
                          padding: EdgeInsets.symmetric(vertical: 8),
                        ),
                        GestureDetector(
                          onTap:navigateToSignup,
                          child: Container(
                            child: Text(
                              "Sign up",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8),
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

//1.59.36
