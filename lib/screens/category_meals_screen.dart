import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../providers/language_provider.dart';
import '../widgets/category_meal.dart';
import '../providers/meal_provider..dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routename = '/category_meal';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryid = "";
  List<Meal> displayedmeal = <Meal>[];
  // ignore: unused_element
  void _removeitem(String mealid) {
    setState(() {
      displayedmeal.removeWhere((meal) => meal.id == mealid);
    });
  }

  @override
  void didChangeDependencies() {
    final List<Meal> availablemeal =
        Provider.of<MealProvider>(context, listen: true).availablemeal;
    final routearg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryid = routearg['id']!;

    displayedmeal = availablemeal.where((meal) {
      return meal.categories.contains(categoryid);
    }).toList();
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(lan.getTexts('cat-$categoryid').toString())),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: dw <= 400 ? 400 : 500,
            childAspectRatio: isLandScape ? dw / (dw * 0.85) : dw / (dw * 0.82),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (ctx, index) {
            return Mealitem(
              id: displayedmeal[index].id,
              imageUrl: displayedmeal[index].imageUrl,
              duration: displayedmeal[index].duration,
              complexity: displayedmeal[index].complexity,
              affordability: displayedmeal[index].affordability,
            );
          },
          itemCount: displayedmeal.length,
        ),
      ),
    );
  }
}
