import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class myFavourite extends StatefulWidget {
  const myFavourite({super.key});
  @override
  State<myFavourite> createState() => _favouriteListState();
}

class _favouriteListState extends State<myFavourite> {
  Future<List<dynamic>> fetchMeals() async {
    List<dynamic> cocktails = [];
    for (int response1 = 0; response1 <= 4; response1++) {
      final response = await http.get(
          Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/random.php'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        cocktails.add(jsonData['meals'][0]);
      } else {
        throw Exception('Failed to load meals');
      }
    }
    return cocktails;
  }

  void _removeCocktailFromFirestore(String x) {
    FirebaseFirestore.instance
        .collection('meals')
        .doc(x)
        .delete()
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Meal removed Favourite')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove meal: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          flexibleSpace: Image(
            image: AssetImage('assets/images/food_login.jpg'),
            fit: BoxFit.cover,
          ),
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('My Favourite Meals',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Colors.red),)
                ],
              ),
          ),
        ),
        backgroundColor: Color(0xFF232227),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('meals').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No cocktails found'),
              );
            }
            // setState(() {});
            return ListView(
              children: snapshot.data!.docs.map((document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return Dismissible(
                  key: Key(document.id),
                  onDismissed: (direction) {
                    // Xóa ghi chú khi người dùng vuốt để xóa
                    setState(() {
                      _removeCocktailFromFirestore(document.id);
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        data['strMeal'],
                        style: TextStyle(fontSize: 20),
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(data['strMealThumb']),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => CocktailDetails(
                        //             meal: data,
                        //           )),
                        // );
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}
