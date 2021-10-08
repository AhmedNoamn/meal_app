import 'package:flutter/material.dart';
import 'package:meal_food/dummy_data.dart';
import 'package:meal_food/models/meal.dart';
import 'package:meal_food/screens/filterscreen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screem.dart';
import './screens/meal_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availablemeal = DUMMY_MEALS;
  List<Meal> _favoritesmeal = [];

  void _setfilter(Map<String, bool> _filterdata) {
    setState(() {
      _filters = _filterdata;
      _availablemeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }

        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _togglefavouries(String mealid) {
    final existingindex = _favoritesmeal.indexWhere((meal) => meal.id == mealid);
    if (existingindex >= 0) {
      setState(() {
        _favoritesmeal.removeAt(existingindex);
      });
    } else {
      setState(() {
        _favoritesmeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealid));
      });
    }
  }

  bool _ismealfavorites(String id) {
    return _favoritesmeal.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Flutter ',
      theme: ThemeData(
        //primarySwatch: Colors.pink,
        primaryColor: Colors.red,
        accentColor: Colors.amber[300],
        canvasColor: Color.fromRGBO(252, 240, 231, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(25, 54, 54, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(25, 54, 54, 1),
              ),
              headline6: TextStyle(
                  fontFamily: 'RobooCondensed',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
      ),
      // home: MyHomePage(),

      routes: {
        '/': (context) => TabsScreen(_favoritesmeal),
        CategoryMealsScreen.routename: (context) =>
            CategoryMealsScreen(_availablemeal),
        MealDetialscreen.routename: (context) =>
            MealDetialscreen(_togglefavouries, _ismealfavorites),
        Filterscreen.routename: (context) => Filterscreen(_filters, _setfilter),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mama Food"),
      ),
      body: null,
    );
  }
}
