import 'package:flutter/material.dart';

class TransporteScreen extends StatelessWidget {
  const TransporteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 65.0,),
          Image(
            image: AssetImage("images/566499.png"),
            width: 120.0,
            height: 120.0,
            alignment:Alignment.center,
          ),
        ],
      ),
    );
  }
}
