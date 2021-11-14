import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availablemeal = DUMMY_MEALS;
  List<Meal> favoritesmeal = [];
  List<String> prefsMealId = [];
  List<Category> availableCategory = DUMMY_CATEGORIES;

  void setfilter() async {
    availablemeal = DUMMY_MEALS.where((meal) {
      if (filters['gluten']! && !meal.isGlutenFree) {
        return false;
      }

      if (filters['lactose']! && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan']! && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    List<Category> ac = [];
    availablemeal.forEach((meal) {
      meal.categories.forEach((cateId) {
        DUMMY_CATEGORIES.forEach((cate) {
          if (cate.id == cateId) {
            if (!ac.any((cate) => cate.id == cateId)) ac.add(cate);
          }
        });
      });
    });
    availableCategory = ac;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten', filters['gluten']!);
    prefs.setBool('lactose', filters['lactose']!);
    prefs.setBool('vegetarian', filters['vegetarian']!);
    prefs.setBool('vegan', filters['vegan']!);
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['lactose'] = prefs.getBool('lactose') ?? false;
    filters['vegetarian'] = prefs.getBool('vegetarian') ?? false;
    filters['vegan'] = prefs.getBool('vegan') ?? false;

    prefsMealId = prefs.getStringList('prefsMealId') ?? [];

    for (var mealid in prefsMealId) {
      final existingIndex =
          favoritesmeal.indexWhere((meal) => meal.id == mealid);
      if (existingIndex < 0) {
        favoritesmeal.firstWhere((meal) => meal.id == mealid);
      }
    }
    List<Meal> fm = [];
    favoritesmeal.forEach((favMeals) {
      availablemeal.forEach((avMeals) {
        if (favMeals.id == avMeals.id) fm.add(favMeals);
      });
    });
    favoritesmeal = fm;
    notifyListeners();
  }

  bool isMealFavourites = false;
  void togglefavouries(String mealid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingindex = favoritesmeal.indexWhere((meal) => meal.id == mealid);
    if (existingindex >= 0) {
      favoritesmeal.removeAt(existingindex);
      prefsMealId.remove(mealid);
    } else {
      favoritesmeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealid));
      prefsMealId.add(mealid);
    }

    notifyListeners();
    prefs.setStringList('prefsMealId', prefsMealId);
  }

  bool isFavouries(String mealid) {
    return favoritesmeal.any((meal) => meal.id == mealid);
  }
}
