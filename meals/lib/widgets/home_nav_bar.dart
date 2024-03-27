import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:meals/widgets/CameraScreen.dart';
import 'package:meals/widgets/ImageAnalyzer.dart';
import 'package:meals/widgets/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meals/widgets/my_favourite.dart';
import 'package:meals/widgets/home.dart';
class HomeNavBar extends StatefulWidget {
  const HomeNavBar({super.key});
  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<HomeNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index >= 0 && index < 5) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return Home();
      case 1:
        return myFavourite();
      case 2:
        return Center(
          child: Text('School Content'),
        );
      case 3:
        return Center(
          child: Text('School Content'),
        );
      case 4:
        return Center(
          child: Text('School Content'),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double fullWidth = MediaQuery.of(context).size.width;
    final ImagePicker _imagePicker = ImagePicker();
    Future<void> _pickImage() async {
      final pickedFile = await _imagePicker.pickImage(
          source: ImageSource.gallery);

      if (pickedFile != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ImageAnalyzer(imagePath: pickedFile.path);
          },
        );
      }
    }
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      //
      // ),
      body: Center(
        child: _buildContent(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                _onItemTapped(0);
              },
              child: Icon(
                Icons.home,
                color: Colors.white,
                size: 35,
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                _onItemTapped(1);
              },
              child: Icon(
                Icons.favorite_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 100,
                        width: size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CameraScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(fullWidth, 50),
                                  elevation: 0, // Remove shadow
                                ),
                                child: Text("Chụp ảnh")),
                            ElevatedButton(
                                onPressed: _pickImage,
                                style: ElevatedButton.styleFrom(
                                  elevation: 0, // Remove shadow
                                  minimumSize: Size(fullWidth, 50),
                                ),
                                child: Text("Chọn ảnh từ thư viện")),
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color(0xFFEFB322),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 8,
                      )
                    ]),
                child: Icon(
                  CupertinoIcons.camera,
                  color: Colors.white,
                ),
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                _onItemTapped(2);
              },
              child: Icon(
                Icons.video_camera_back_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            ////////////////////////////////////////////////////////////////
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 370,
                          maxWidth: 450,
                        ),
                        child: AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Tài khoản",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          content: Column(
                            children: [
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 5),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 30,
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nhóm 10",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "LTUD&DD",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 5),
                                leading: Icon(Icons.logout),
                                title: Text("Đăng xuất"),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyLogin()));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
