import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meals/widgets/mealDetail.dart';
//import 'cocktailDetail.dart';

class MealListWidget extends StatelessWidget {
  Future<List<dynamic>> fetchMeals() async {
    List<dynamic> meals = [];
    for (int response1 = 0; response1 <= 4; response1++) {
      final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        meals.add(jsonData['meals'][0]);
      } else {
        throw Exception('Failed to load meals');
      }
    }
    return meals;
  }
  @override
  Widget build(BuildContext context) {
    return   FutureBuilder(
        future: fetchMeals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingIndicator();
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<dynamic> meals = snapshot.data as List<dynamic>;
              return  SizedBox(
                height: 300,
                child: ListView.builder(
                  // shrinkWrap: true, // Add this line
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    var meal = meals[index];
                    return _buildMealTile(meal, context);
                  },
                ),
              );
            }
          }
        },
      );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildMealTile(dynamic meal, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MealDetail(meal: meal,)),
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
            title: Text(
                meal['strMeal'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
          ),
        ),
      )

    );
  }

  Widget _buildIngredientList(meal) {
    List<Widget> ingredientWidgets = [];
    for (var i = 1; i <= 3; i++) {
      var ingredientKey = 'strIngredient$i';
      var measureKey = 'strMeasure$i';
      var ingredient = meal[ingredientKey];
      var measure = meal[measureKey];

      if (ingredient != null && ingredient.isNotEmpty) {
        var ingredientText = measure != null ? '$measure $ingredient' : ingredient;
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

