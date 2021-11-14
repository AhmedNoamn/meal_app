import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../dummy_data.dart';
import '../providers/language_provider.dart';
import '../providers/meal_provider..dart';

class MealDetialscreen extends StatelessWidget {
  static const routename = '/meal_detail';

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    final mealid = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealid);
    var accentColor = Theme.of(context).colorScheme.secondary;

    Widget buildtitle(BuildContext context, String text) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      );
    }

    Widget buildcontainer(Widget child) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          height: isLandScape ? dh * 0.5 : dh * 0.30,
          width: isLandScape ? (dw * 0.5 - 30) : dw,
          child: child);
    }

    List<String> liINgredientsli =
        lan.getTexts('ingredients-$mealid') as List<String>;
    var liINgredients = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(liINgredientsli[index],
              style: TextStyle(
                color: useWhiteForeground(accentColor)
                    ? Colors.white
                    : Colors.black,
              )),
        ),
      ),
      itemCount: liINgredientsli.length,
    );

    List<String> liStepsli = lan.getTexts('steps-$mealid') as List<String>;
    var liSteps = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text("${index + 1}"),
            ),
            title: Text(
              liStepsli[index],
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(),
        ],
      ),
      itemCount: liStepsli.length,
    );

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                title: Text((lan.getTexts('meal-$mealid')).toString()),
                background: Hero(
                  tag: mealid,
                  child: InteractiveViewer(
                    child: FadeInImage(
                        placeholder: AssetImage('assets/images/a2.png'),
                        image: NetworkImage(selectedMeal.imageUrl),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                if (isLandScape)
                  Row(
                    children: [
                      Column(
                        children: [
                          buildtitle(
                              context, lan.getTexts('Ingredients').toString()),
                          buildcontainer(liINgredients),
                        ],
                      ),
                      Column(children: [
                        buildtitle(context, lan.getTexts('Steps').toString()),
                        buildcontainer(liSteps),
                      ]),
                    ],
                  ),
                if (!isLandScape)
                  buildtitle(context, lan.getTexts('Ingredients').toString()),
                if (!isLandScape) buildcontainer(liINgredients),
                if (!isLandScape)
                  buildtitle(context, lan.getTexts('Steps').toString()),
                if (!isLandScape) buildcontainer(liSteps),
              ]),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .togglefavouries(mealid),
          child: Icon(Provider.of<MealProvider>(context, listen: true)
                  .isFavouries(mealid)
              ? Icons.star
              : Icons.star_border),
        ),
      ),
    );
  }
}
