import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;

  final Color color;

  CategoryItem(this.id, this.color);

  void selectcategory(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(CategoryMealsScreen.routename, arguments: {'id': id});
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: () => selectcategory(context),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Text(
            (lan.getTexts('cat-$id')).toString(),
            style: Theme.of(context).textTheme.headline6,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.3),
                color.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
    );
  }
}
