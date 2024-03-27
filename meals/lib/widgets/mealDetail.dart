import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meals/widgets/video.dart';

class MealDetail extends StatelessWidget {
  final dynamic meal;
  const MealDetail({Key? key, required this.meal}) : super(key: key);

  String extractYouTubeVideoId(String url) {
    RegExp regExp = RegExp(
      r'^https?:\/\/(?:www\.)?youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=|\S*?[?&]list=)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
      multiLine: false,
    );

    Match? match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1).toString();
    } else {
      return "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          // flexibleSpace: Image(
          //   image: AssetImage('assets/images/food_login.jpg'),
          //   fit: BoxFit.cover,
          // ),
          backgroundColor: Color.fromRGBO(120, 120, 120, 0.7),
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(meal['strMeal'],style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),)
              ],
            ),
          ),
        ),
        //backgroundColor: Color(0xFF232227),
        body: Container(
          padding: EdgeInsets.only(left: 15,right: 15),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.white,
            //       spreadRadius: 1,
            //       blurRadius: 2,
            //       offset: Offset(0, 1),
            //     ),
            //   ],
            // ),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 210,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(meal['strMealThumb']), // Đường dẫn đến ảnh của bạn
                            fit: BoxFit.cover, // Căn ảnh để nó phù hợp với kích thước của Container
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: (){
                              String videoID = extractYouTubeVideoId(meal['strYoutube']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => VideoInstructions(videoId: videoID)),
                              );
                            },
                            tooltip: "Play",
                            icon: Icon(Icons.play_circle_outline),
                            iconSize: 65,
                            color: Color.fromRGBO(60, 60, 60, 1),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Ingredients:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      _buildIngredientList(meal),
                      SizedBox(height: 20),
                      Text(
                        'Instructions:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        meal['strInstructions'],
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      // Text(
                      //   'Glass Type:',
                      //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(height: 10),
                      // Text(
                      //   meal['strGlass'],
                      //   style: TextStyle(fontSize: 16),
                      // ),
                    ],
                  ),
                ))));
  }

  Widget _buildIngredientList(meal) {
    List<Widget> ingredientWidgets = [];

    for (var i = 1; i <= 15; i++) {
      var ingredientKey = 'strIngredient$i';
      var measureKey = 'strMeasure$i';
      var ingredient = meal[ingredientKey];
      var measure = meal[measureKey];

      if (ingredient != null && ingredient.isNotEmpty) {
        var ingredientText =
            measure != null ? '$measure $ingredient' : ingredient;
        ingredientWidgets.add(
          Text(
            '• $ingredientText',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        );
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredientWidgets,
    );
  }
}
