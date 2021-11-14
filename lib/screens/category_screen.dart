import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/meal_provider..dart';
import '../widgets/category_item.dart';

class Categoriesscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: GridView(
            padding: EdgeInsets.all(25),
            children: Provider.of<MealProvider>(context)
                .availableCategory //DUMMY_CATEGORIES
                .map((catdata) => CategoryItem(
                      catdata.id,
                      catdata.color,
                    ))
                .toList(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            )),
      ),
    );
  }
}
