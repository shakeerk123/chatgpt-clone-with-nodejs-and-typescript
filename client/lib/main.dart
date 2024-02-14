import 'package:client/app/utils/theme.dart';
import 'package:client/app/views/on_boarding.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: OnbaordingPage(),
    );
  }
}