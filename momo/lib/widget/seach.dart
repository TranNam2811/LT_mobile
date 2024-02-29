import 'package:flutter/material.dart';
class Seacher extends StatelessWidget {
  const Seacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
         Column(
           children: [
             Container(
               margin: EdgeInsets.only(top: 15, left: 15),
               height: 40,
               width: 300,
               decoration: BoxDecoration(
                 color: Colors.grey,
                 borderRadius: BorderRadius.circular(18),
               ),
               child: Container(
                 height: 40,
                 child: TextFormField(
                   decoration: InputDecoration(
                     prefixIcon: Icon(Icons.search),
                     labelText: "tim kiem",
                   ),
                 ),
               ),
             ),
           ],
         ),
         // Column(
         //   children: [
         //     Container(
         //       padding: EdgeInsets.all(16.0),
         //       decoration: BoxDecoration(
         //         color: Colors.blue, // Màu nền của biểu tượng
         //         shape: BoxShape.circle, // Hình dạng là hình tròn
         //       ),
         //       child: Icon(Icons.home,
         //         color: Colors.white, // Màu của biểu tượng
         //         size:30, // Kích thước của biểu tượng
         //       )
         //     ),
         //   ],
         // )

        ]
      ),


    );
  }
}



