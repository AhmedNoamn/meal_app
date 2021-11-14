import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../models/meal.dart';
import '../screens/meal_detail_screen.dart';

class Mealitem extends StatelessWidget {
  final String id;

  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const Mealitem({
    required this.id,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });

  void selectmeal(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(MealDetialscreen.routename, arguments: id)
        .then((result) => {});
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).splashColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: InkWell(
        onTap: () => selectmeal(context),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
          )),
          margin: EdgeInsets.all(10),
          elevation: 4,
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Hero(
                      tag: id,
                      child: FadeInImage(
                        height: 200,
                        placeholder: AssetImage('assets/images/a2.png'),
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: 300,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      color: Colors.black54,
                      child: Text(
                        lan.getTexts("meal-$id").toString(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: iconColor,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text("$duration " + lan.getTexts("min2").toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.work,
                          color: iconColor,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(lan.getTexts('$complexity').toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: iconColor,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(lan.getTexts('$affordability').toString()),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
