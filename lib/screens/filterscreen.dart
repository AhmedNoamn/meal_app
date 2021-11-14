import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/maindrawer.dart';
import '../providers/meal_provider..dart';

// ignore: must_be_immutable
class Filterscreen extends StatefulWidget {
  static const routename = '/filters';
  bool fromOnBoarding;
  Filterscreen({this.fromOnBoarding = false});

  @override
  _FilterscreenState createState() => _FilterscreenState();
}

class _FilterscreenState extends State<Filterscreen> {
  Widget buildswitchlisttile(String title, String description,
      bool currentvalue, Function(bool) updatevalue) {
    return SwitchListTile(
      inactiveTrackColor: Colors.black,
      title: Text(title),
      value: currentvalue,
      subtitle: Text(description),
      onChanged: updatevalue,
      activeColor: Theme.of(context).colorScheme.secondary,
      inactiveThumbColor:
          Provider.of<ThemeProvider>(context, listen: true).tm ==
                  ThemeMode.light
              ? null
              : Colors.white54,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentfilter =
        Provider.of<MealProvider>(context, listen: true).filters;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              title: widget.fromOnBoarding
                  ? null
                  : Text((lan.getTexts('filters_appBar_title')).toString()),
              backgroundColor: widget.fromOnBoarding
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).colorScheme.primary,
              elevation: widget.fromOnBoarding ? 0 : 5,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    (lan.getTexts('filters_screen_title')).toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                buildswitchlisttile(
                    lan.getTexts('Gluten-free').toString(),
                    lan.getTexts('Gluten-free-sub').toString(),
                    currentfilter['gluten']!, (newvalue) {
                  setState(() {
                    currentfilter['gluten'] = newvalue;
                  });
                }),
                buildswitchlisttile(
                    lan.getTexts('Lactose-free').toString(),
                    lan.getTexts('Lactose-free_sub').toString(),
                    currentfilter['lactose']!, (newvalue) {
                  setState(() {
                    currentfilter['lactose'] = newvalue;
                  });
                }),
                buildswitchlisttile(
                    lan.getTexts('Vegetarian').toString(),
                    lan.getTexts('Vegetarian-sub').toString(),
                    currentfilter['vegetarian']!, (newvalue) {
                  setState(() {
                    currentfilter['vegetarian'] = newvalue;
                  });
                }),
                buildswitchlisttile(
                    lan.getTexts('Vegan').toString(),
                    lan.getTexts('Vegan-sub').toString(),
                    currentfilter['vegan']!, (newvalue) {
                  setState(() {
                    currentfilter['vegan'] = newvalue;
                  });
                }),
                SizedBox(
                  height: widget.fromOnBoarding ? 80 : 10,
                ),
                FloatingActionButton(
                    elevation: 3,
                    child: Icon(Icons.save),
                    onPressed: () {
                      Provider.of<MealProvider>(context, listen: false)
                          .setfilter();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        width: 150,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        content: Text("           Saved"),
                      ));
                    }),
              ]),
            ),
          ],
        ),
        drawer: widget.fromOnBoarding ? null : Maindrawer(),
      ),
    );
  }
}
