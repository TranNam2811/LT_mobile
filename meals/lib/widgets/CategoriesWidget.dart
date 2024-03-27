import 'package:flutter/material.dart';
import 'package:meals/widgets/Meals.dart';
import 'package:meals/widgets/my_favourite.dart';

class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryButton(
            image: "assets/images/video.png",
            label: "Videos",
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => videoCocktail()),
              // );

            },
          ),
          _buildCategoryButton(
            image: "assets/images/love.png",
            label: "Favorite",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => myFavourite()),
              );

            },
          ),
          _buildCategoryButton(
            image: "assets/images/meals.png",
            label: "All Meal",
            onPressed: () {
              // Xử lý khi nút được nhấn
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Meals()),
              );

            },
          ),
          _buildCategoryButton(
            image: "assets/images/more.png",
            label: "More",
            onPressed: () {
              // Xử lý khi nút được nhấn

            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton({required String image, required String label, required VoidCallback onPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13),
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Image.asset(
                image,
                width: 60,
                height: 60,
              ),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
