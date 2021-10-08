import 'package:flutter/material.dart';
import 'package:meal_food/models/meal.dart';
import '../widgets/category_meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routename = 'category_meal';

  final List<Meal> availablemeal;
  CategoryMealsScreen(this.availablemeal);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categorytitle;
  List<Meal> displayedmeal;
  // ignore: unused_element
  void _removeitem(String mealid) {
    setState(() {
      displayedmeal.removeWhere((meal) => meal.id == mealid);
    });
  }

  @override
  void didChangeDependencies() {
    final routearg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryid = routearg['id'];
    categorytitle = routearg['title'];
    displayedmeal = widget.availablemeal.where((meal) {
      return meal.categories.contains(categoryid);
    }).toList();
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categorytitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return Mealitem(
            id: displayedmeal[index].id,
            imageUrl: displayedmeal[index].imageUrl,
            title: displayedmeal[index].title,
            duration: displayedmeal[index].duration,
            complexity: displayedmeal[index].complexity,
            affordability: displayedmeal[index].affordability,
          );
        },
        itemCount: displayedmeal.length,
      ),
    );
  }
}
