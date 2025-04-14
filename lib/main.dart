import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kodichap/screens/homepage.dart';

void main(){
  runApp(kodichap());
}

class kodichap extends StatelessWidget {
  const kodichap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: splashscreen(),
    );
  }
}

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> with TickerProviderStateMixin{
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _fadeController;

  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _logoController = AnimationController(duration: Duration(milliseconds: 1500)
      ,vsync: this,);
    _logoAnimation = CurvedAnimation(
        parent: _logoController,
        curve: Curves.bounceOut);

    _textController = AnimationController(duration: Duration(milliseconds: 1500)
      ,vsync: this,);
    _textAnimation = CurvedAnimation(
        parent: _logoController,
        curve: Curves.bounceOut);

    _fadeController = AnimationController(duration: Duration(milliseconds: 1500)
      ,vsync: this,);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);
    
    _logoController.forward().then((_){
      _textController.forward().then((_){
        _fadeController.forward();
      });
    });
    
    Timer(Duration(seconds: 5), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => homepage()));
    });
  }
  
  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
                scale: _logoAnimation,
            child: Image.asset('assets/images/logo.png', width: 200,)),

            SizedBox( height: 10,),

            ScaleTransition(scale: _textAnimation,
            child: Text('kodichap',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),),),

            SizedBox(height: 10,),

            FadeTransition(
                opacity: _fadeAnimation,
                child: Text('pata nyums ysko sasa',
                style: TextStyle(fontSize: 16,
                color: Colors.brown),)),
          ],
        ),
      ),
    );
  }
}