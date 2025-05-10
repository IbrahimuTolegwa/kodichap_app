import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kodichap/authentication/registrationpage.dart';
import 'package:kodichap/screens/homepage.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String emailValue = '';
  String passwordValue = '';

  Future<void> loginFunction(String email, String password) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Welcome back')));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => homepage()));
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred.';
      if (e.code == 'user-not-found') {
        errorMessage = 'User not found';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'Network error, please try again later.';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Check if the user is already logged in
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is already logged in, go to homepage
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homepage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                    child: Image.asset('assets/images/logo.png', width: 200,)),
                SizedBox(
                  height: 10,
                ),

                Container(
                  child: Text('LOGIN', style: TextStyle(color: Color(0xFF885A00), fontSize: 30, fontWeight: FontWeight.bold),),
                ),

                SizedBox(
                  height: 20,
                ),


                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),

                  onChanged: (value){
                    setState(() {
                      emailValue = value;
                    });
                  },

                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'please enter your email';
                    }if(!value.contains('@')){
                      return 'enter valid email';
                    }
                  },
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: 'Enter Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),

                  onChanged: (value){
                    setState(() {
                      passwordValue = value;
                    });
                  },

                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'please enter your password';
                    }
                  },
                ),
                SizedBox(height: 10),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF885A00),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text('Login',style: TextStyle(fontSize: 20, color: Colors.white),)),
                  ),
                  onTap: (){
                    if(_formkey.currentState!.validate()){
                      loginFunction(emailValue, passwordValue);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form submitted')));
                    }
                  },
                ),

                SizedBox(height: 5,),

                RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(
                              text: ' Register',
                              style: TextStyle(color: Colors.blue, fontSize: 16),
                              recognizer: TapGestureRecognizer()..onTap= (){
                              }
                          )
                        ]
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
