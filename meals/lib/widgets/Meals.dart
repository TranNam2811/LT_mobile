import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meals/widgets/mealDetail.dart';

class Meals extends StatefulWidget {
  @override
  _MealsState createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  List<dynamic> meals = [];
  Set<dynamic> favorites = Set<dynamic>();
  late http.Client httpClient;

  @override
  void initState() {
    super.initState();
    httpClient = http.Client();
    fetchMeals();
  }

  @override
  void dispose() {
    httpClient.close(); // Đóng client khi không còn cần thiết nữa
    super.dispose();
  }

  Future<void> fetchMeals() async {
    Set<String> seenMealNames = Set<String>();
    for(int response1 = 0; response1 <= 100; response1++) {
      final response = await httpClient.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        var drinkName = jsonData['meals'][0]['strMeal'];
        if (!seenMealNames.contains(drinkName)) {
          seenMealNames.add(drinkName);
          if (mounted) { // Kiểm tra trước khi gọi setState()
            setState(() {
              meals.add(jsonData['meals'][0]);
            });
          }
        }
      } else {
        throw Exception('Failed to load meals');
      }
    }
  }

  void _addMealToFirestore(dynamic meal) {
    FirebaseFirestore.instance.collection('meals').add({
      'strMeal': meal['strMeal'],
      'strMealThumb': meal['strMealThumb'],
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Meal added to favourite Meal')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add meal: $error')),
      );
    });
  }

  void _removeMealFromFirestore(dynamic meal) {
    FirebaseFirestore.instance.collection('meals').where('strMeal', isEqualTo: meal['strMeal']).get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('meal removed from Firestore')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove meal: $error')),
      );
    });
  }
  Future<bool> _checkMealExists(String mealName) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('meals')
        .where('strMeal', isEqualTo: mealName)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    meals.sort((a, b) => a['strMeal'].compareTo(b['strMeal']));
    Color heartColor = Colors.red;
    return Scaffold(
      appBar: AppBar(
        title: Text('All Meal', textAlign: TextAlign.center),
      ),
      backgroundColor: Colors.black,
      body:  ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                var meal = meals[index];
                bool isFavorite = favorites.contains(meal);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MealDetail(meal: meal)),
                      );
                    },
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
                      child: ListTile(
                        title: Text(meal['strMeal']),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            meal['strMealThumb'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        subtitle: _buildIngredientList(meal),
                        trailing: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: heartColor,
                          ),
                          onPressed: () async {
                            isFavorite = await _checkMealExists(meal['strMeal']);
                            setState(() {
                              if (isFavorite) {
                                favorites.remove(meal);
                                _removeMealFromFirestore(meal);
                              } else {
                                favorites.add(meal);
                                _addMealToFirestore(meal);
                              }
                              heartColor = isFavorite ? Colors.white : Colors.red;
                            });
                            isFavorite = !isFavorite;
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),


    );
  }

  Widget _buildIngredientList(meal) {
    List<Widget> ingredientWidgets = [];
    for (var i = 1; i <= 15; i++) {
      var ingredientKey = 'strIngredient$i';
      var measureKey = 'strMeasure$i';
      var ingredient = meal[ingredientKey];
      var measure = meal[measureKey];

      if (ingredient != null && ingredient.isNotEmpty) {
        var ingredientText = measure != null ? '$measure $ingredient' : ingredient;
        ingredientWidgets.add(
          Text(
            ingredientText,
            style: TextStyle(
              fontSize: 12,
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



