import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MoMoDeXuat extends StatelessWidget {
  const MoMoDeXuat({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for(int i = 1; i < 8; i++)
          Container(
            child: TextButton(
              onPressed: () {},
              child: Column(
                children: [
                  Image.asset('assets/img/momodexuat/$i.png', width: 60),
                  Text("Lắc Xì 2024", style: TextStyle(fontSize: 13,color: Colors.black),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
