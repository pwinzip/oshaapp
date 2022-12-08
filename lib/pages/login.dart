import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';
import 'register.dart';
import 'user_home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    pageInitialization();
  }

  void pageInitialization() async {
    FlutterNativeSplash.remove();
    // Verify User logged in
    // Check in SharedPreferences
    final SharedPreferences prefs = await _prefs;
    if (prefs.containsKey('uid')) {
      // go to user_home
      print(prefs.getString('uid'));
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const UserHomePage(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  logo(),
                  const SizedBox(height: 8),
                  email(),
                  const SizedBox(height: 12),
                  password(),
                  const SizedBox(height: 18),
                  loginBtn(),
                  const SizedBox(height: 18),
                  actionBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Image.asset(
        "assets/images/logo_app.LSI.png",
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.25,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget email() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: "ระบุอีเมล์",
          contentPadding: EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget password() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: passController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "ระบุรหัสผ่าน",
          contentPadding: EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget loginBtn() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF42B48B)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          )),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            User? user = await AuthService.signInWithEmail(
                email: emailController.text, password: passController.text);
            if (!mounted) return;
            if (user != null) {
              final SharedPreferences prefs = await _prefs;
              prefs.setString('uid', user.uid);
              // get user info from user collection in firestore

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const UserHomePage(),
              ));
            }
          }
        },
        child: const Text('เข้าสู่ระบบ'),
      ),
    );
  }

  Widget actionBtn() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          registBtn(),
          forgotPassBtn(),
        ],
      ),
    );
  }

  Widget registBtn() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            foregroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 39, 49, 34)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              side: const BorderSide(color: Color.fromARGB(255, 39, 49, 34)),
              borderRadius: BorderRadius.circular(16),
            )),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                ));
          },
          child: const Text("สมัครสมาชิก")),
    );
  }

  Widget forgotPassBtn() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 35, 91, 7)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            )),
          ),
          onPressed: () {},
          child: const Text("ลืมรหัสผ่าน")),
    );
  }
}
