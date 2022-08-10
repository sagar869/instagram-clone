import 'package:demo/providers/provider.dart';
import 'package:demo/responsive/mobile_screen.dart';
import 'package:demo/responsive/responsive_layout.dart';
import 'package:demo/responsive/web_screen.dart';
import 'package:demo/screens/login_screen.dart';
import 'package:demo/screens/signup_screen.dart';
import 'package:demo/untils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyChelhmCVXTBHTwZK90vqGUBrctSSA7umo",
            authDomain: "demo1-88325.firebaseapp.com",
            databaseURL: "https://demo1-88325-default-rtdb.firebaseio.com",
            projectId: "demo1-88325",
            storageBucket: "demo1-88325.appspot.com",
            messagingSenderId: "160304836012",
            appId: "1:160304836012:web:41870bb99ac9215ce3de09",
            measurementId: "G-200DVH18M5"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DemoApp',
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                    mobileScreenLayout: const MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
              return const LoginScreen();
            },
          )),
    );
  }
}


//5.36 for followers
// profile karna h 6.0 se