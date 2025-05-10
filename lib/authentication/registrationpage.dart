import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> with TickerProviderStateMixin{
  final _formkey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late AnimationController _logoAnimationController;
  late Animation<double> _logoAnimtion;

  String emailValue = '';
  String passwordValue = '';

  @override
  void initState() {
    super.initState();
    _logoAnimationController = AnimationController(
        duration: Duration(milliseconds: 1100),
        vsync: this,);
    _logoAnimtion = CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.bounceOut);
  }

  Future<UserCredential?> registrationMethod(String email, String password) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered')));
      return userCredential;
    } on FirebaseAuthException catch(e){
      String errorMessage = '';
      if(e.code == 'email-already-i-use'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email already taken')));
      }if(e.code == 'weak-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('passwordis too weak')));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('registration error: ${e.message}')));
      }
    }
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
                  child: Text('REGISTER', style: TextStyle(color: Color(0xFF885A00), fontSize: 30, fontWeight: FontWeight.bold),),
                ),

                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller: emailController,
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
                  controller: usernameController,
                  decoration: InputDecoration(
                      hintText: 'User name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'please enter your username';
                    }
                  },
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Create Password',
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
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: 'confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
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
                    child: Center(child: Text('Register',style: TextStyle(fontSize: 20, color: Colors.white),)),
                  ),
                  onTap: (){
                    if(_formkey.currentState!.validate()){
                      registrationMethod(emailValue, passwordValue);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form submitted')));
                    }
                  },
                ),

                SizedBox(height: 5,),

                RichText(
                  text: TextSpan(
                    text: 'Already have an account?',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(
                        text: ' Login',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                        recognizer: TapGestureRecognizer()..onTap= (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>loginScreen()));
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
