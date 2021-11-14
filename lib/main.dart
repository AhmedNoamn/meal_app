import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './providers/language_provider.dart';
import './providers/meal_provider..dart';
import './providers/theme_provider.dart';
import './screens/filterscreen.dart';
import './screens/on_boarding_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/theme_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget homeScreen =
      prefs.getBool('watched') ?? false ? TabsScreen() : OnBoardingScreen();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MealProvider>(
        create: (ctx) => MealProvider(),
      ),
      ChangeNotifierProvider(
        create: (ctx) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (ctx) => LanguageProvider(),
      )
    ],
    child: MyApp(homeScreen),
  ));
}

class MyApp extends StatelessWidget {
  final Widget mainScreen;
  MyApp(this.mainScreen);
  @override
  Widget build(BuildContext context) {
    var primaryColor = Provider.of<ThemeProvider>(context).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;
    var tm = Provider.of<ThemeProvider>(context).tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Flutter ',

      themeMode: tm,
      theme: ThemeData(
        cardColor: Color.fromRGBO(232, 226, 225, 1),
        splashColor: Colors.black54,
        shadowColor: Colors.white54,
        canvasColor: Color.fromRGBO(232, 226, 225, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.black,
              ),
              headline6: TextStyle(
                  color: Colors.black,
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor)
            .copyWith(secondary: accentColor),
      ),
      darkTheme: ThemeData(
        cardColor: Color.fromRGBO(14, 22, 33, 1),
        splashColor: Colors.white70,
        shadowColor: Colors.black54,
        unselectedWidgetColor: Colors.white60,
        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.white54,
              ),
              headline6: TextStyle(
                  color: Colors.white54,
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor)
            .copyWith(secondary: accentColor),
      ),
      // home: MyHomePage(),

      routes: {
        '/': (context) => mainScreen,
        TabsScreen.routename: (context) => TabsScreen(),
        CategoryMealsScreen.routename: (context) => CategoryMealsScreen(),
        MealDetialscreen.routename: (context) => MealDetialscreen(),
        Filterscreen.routename: (context) => Filterscreen(),
        ThemeScreen.routename: (context) => ThemeScreen(),
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
        title: Text("YU MMY"),
      ),
      body: null,
    );
  }
}
