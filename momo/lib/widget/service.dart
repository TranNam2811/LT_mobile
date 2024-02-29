import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
class Service extends StatelessWidget {
  const Service({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row (
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Expanded(
                      child:  TextButton(
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/img/icon/ct.png', width: 50),
                            Text('Chuyển tiền', style: TextStyle(fontSize: 10, color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child:  TextButton(
                        onPressed: () {},
                        child: Column(
                          children: [
                            Image.asset('assets/img/icon/ctnh.png', width: 50),
                            Text('Chuyển tiền ngân hàng',  style: TextStyle(fontSize: 10,color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child:  TextButton(
                        onPressed: () {},
                        child: Column(
                          children: [
                            Image.asset('assets/img/icon/tthd.png', width: 50),
                            Text('Thanh toán hóa đơn', style: TextStyle(fontSize: 10,color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child:  TextButton(
                        onPressed: () {},
                        child: Column(
                          children: [
                            Image.asset('assets/img/icon/ntdt.png', width: 50),
                            Text('Nạp tiền điện thoại', style: TextStyle(fontSize: 10,color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
            ]
           ),
            Row (
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child:  TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Image.asset('assets/img/icon/data4g.png', width: 50),
                          Text('Data 3G/4G', style: TextStyle(fontSize: 10,color: Colors.black),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child:  TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Image.asset('assets/img/icon/ttt.png', width: 50),
                          Text('Túi thần tài', style: TextStyle(fontSize: 10,color: Colors.black),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child:  TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Image.asset('assets/img/icon/vtss.png', width: 50),
                          Text('Ví trả sau', style: TextStyle(fontSize: 10,color: Colors.black),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child:  TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Image.asset('assets/img/icon/ttkv.png', width: 50),
                          Text('Thanh toan khoản vay', style: TextStyle(fontSize: 10,color: Colors.black),),
                        ],
                      ),
                    ),
                  ),
                ]
            ),
            Row (
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child:  TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Image.asset('assets/img/icon/dl.png', width: 50),
                          Text('Du lich - Đi lại', style: TextStyle(fontSize: 10,color: Colors.black),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child:  TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Image.asset('assets/img/icon/xp.png', width: 50),
                          Text('Mua vé xem phim', style: TextStyle(fontSize: 10,color: Colors.black),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child:  TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Image.asset('assets/img/icon/hdmomo.png', width: 50),
                          Text('Heo Đất MoMo', style: TextStyle(fontSize: 10,color: Colors.black),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child:  TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Image.asset('assets/img/icon/xemthem.png', width: 50),
                          Text('Xem them dịch vụ', style: TextStyle(fontSize: 10,color: Colors.black),),
                        ],
                      ),
                    ),
                  ),
                ]
            ),
          ]
        ),
      ),
    );
  }
}
