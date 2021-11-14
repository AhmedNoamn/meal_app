import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/meal_provider..dart';
import '../widgets/category_meal.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var dw = MediaQuery.of(context).size.width;

    final List<Meal> favoritesmeal =
        Provider.of<MealProvider>(context, listen: true).favoritesmeal;

    if (favoritesmeal.isEmpty) {
      return Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Center(
          child: Text((lan.getTexts('favorites_text')).toString()),
        ),
      );
    } else {
      return Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: dw <= 400 ? 400 : 500,
            childAspectRatio: isLandScape ? dw / (dw * 0.8) : dw / (dw * 0.79),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (ctx, index) {
            return Mealitem(
              id: favoritesmeal[index].id,
              imageUrl: favoritesmeal[index].imageUrl,
              duration: favoritesmeal[index].duration,
              complexity: favoritesmeal[index].complexity,
              affordability: favoritesmeal[index].affordability,
            );
          },
          itemCount: favoritesmeal.length,
        ),
      );
    }
  }
}
