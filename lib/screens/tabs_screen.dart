import 'package:flutter/material.dart';
import 'package:meal_food/models/meal.dart';
import 'package:meal_food/screens/category_screen.dart';
import 'package:meal_food/screens/favoritesscreen.dart';
import 'package:meal_food/widgets/maindrawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoritesmeal;

  TabsScreen(this.favoritesmeal);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _page;
  void initState() {
    _page = [
      {
        'page': Categoriesscreen(),
        'title': 'Categories',
      },
      {'page': FavoritesScreen(widget.favoritesmeal), 'title': 'Favorites'}
    ];
    super.initState();
  }

  int _selectpageindex = 0;
  void _selectpage(int value) {
    setState(() {
      _selectpageindex = value;
    });
  }

  Color bl = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page[_selectpageindex]['title']),
      ),
      body: _page[_selectpageindex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _selectpage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category_outlined,
              color: bl,
            ),
            // ignore: deprecated_member_use
            title: Text(
              "Category",
              style: TextStyle(color: bl),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star_border,
              color: bl,
            ),
            // ignore: deprecated_member_use
            title: Text(
              "Favorites",
              style: TextStyle(color: bl),
            ),
          ),
        ],
      ),
      drawer: Maindrawer(),
    );
  }
}
