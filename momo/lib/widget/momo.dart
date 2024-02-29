
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momo/widget/momodexuat.dart';
import 'package:momo/widget/seach.dart';
import 'package:momo/widget/service.dart';
class MoMo extends StatefulWidget {
  @override
  _MoMoState createState() => _MoMoState();
}

class _MoMoState extends State<MoMo> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 200,
            child:
            Image.asset('assets/img/img1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Container(
          //   height: 100,
          //   padding: EdgeInsets.symmetric(horizontal: 5),
          //   margin: EdgeInsets.symmetric(horizontal: 15),
          //   decoration: BoxDecoration(
          //       color: Colors.grey,
          //       borderRadius: BorderRadius.all(Radius.circular(30))
          //   ),
          // ),
          Container(
            child: Service(),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Text("MoMo đề xuất", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
          ),
          MoMoDeXuat(),


        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        showSelectedLabels: true, // Hiển thị nhãn của mục đã chọn
        showUnselectedLabels: true, // Hiển thị nhãn của các mục không được chọn
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'MoMo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_membership),
            label: 'Ưu đãi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'QR Ngân hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Lịch sử GD',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tôi',
          ),
        ],
      ),
    );
  }
}
