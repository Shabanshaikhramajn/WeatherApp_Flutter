import 'package:flutter/material.dart';

class Shaban extends StatelessWidget {
  const Shaban({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.fromLTRB(0, 10 , 0 , 10),
      child: Align(
                alignment:Alignment.centerLeft ,
                 child: Text('Hourly forecast', 
                 style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                 
                 ),
                 ),
      
      ),
    );


  }
}




// c329a56a3b1c3b5e3d59eac140994e13

// https://api.openweathermap.org/data/2.5/weather?q=delhi&appid=c329a56a3b1c3b5e3d59eac140994e13