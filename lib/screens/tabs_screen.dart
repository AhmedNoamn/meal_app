import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import './category_screen.dart';
import './favoritesscreen.dart';
import '../widgets/maindrawer.dart';
import '../providers/meal_provider..dart';

class TabsScreen extends StatefulWidget {
  static const routename = '/tabs';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectpageindex = 0;
  List<Map<String, Object>> _page = <Map<String, Object>>[];

  void initState() {
    Provider.of<MealProvider>(context, listen: false).getData();
    Provider.of<ThemeProvider>(context, listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context, listen: false).getThemeColors();
    Provider.of<LanguageProvider>(context, listen: false).getLan();

    super.initState();
  }

  void _selectpage(int value) {
    setState(() {
      _selectpageindex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    _page = [
      {
        'page': Categoriesscreen(),
        'title': lan.getTexts('categories'),
      },
      {'page': FavoritesScreen(), 'title': lan.getTexts('your_favorites')}
    ];
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text((_page[_selectpageindex]['title']).toString()),
        ),
        body: _page[_selectpageindex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onTap: _selectpage,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category_sharp,
              ),
              label: lan.getTexts('categories').toString(),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.star_sharp,
              ),
              label: lan.getTexts('your_favorites').toString(),
            ),
          ],
        ),
        drawer: Maindrawer(),
      ),
    );
  }
}
