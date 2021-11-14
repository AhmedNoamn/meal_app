import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/filterscreen.dart';
import '../screens/theme_screen.dart';

class Maindrawer extends StatelessWidget {
  Widget buildlisttile(
      String title, IconData icon, Function() tabhandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
        color: Theme.of(ctx).splashColor,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(ctx).textTheme.bodyText1!.color,
            fontSize: 25,
            fontWeight: FontWeight.w600,
            fontFamily: 'RobotoCondensed'),
      ),
      onTap: tabhandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment:
                  lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                lan.getTexts('drawer_name').toString(),
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildlisttile(
                lan.getTexts('drawer_item1').toString(), Icons.restaurant_sharp,
                () {
              Navigator.of(context).pushReplacementNamed('/');
            }, context),
            buildlisttile(
                lan.getTexts('drawer_item2').toString(), Icons.settings, () {
              Navigator.of(context)
                  .pushReplacementNamed(Filterscreen.routename);
            }, context),
            buildlisttile(
                lan.getTexts('drawer_item3').toString(), Icons.color_lens_sharp,
                () {
              Navigator.of(context).pushReplacementNamed(ThemeScreen.routename);
            }, context),
            Divider(
              height: 10,
              color: Colors.black54,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(top: 20, right: 20),
              child: Text(
                lan.getTexts('drawer_switch_title').toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: lan.isEn ? 0 : 20,
                  right: lan.isEn ? 20 : 0,
                  bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(lan.getTexts('drawer_switch_item2').toString(),
                      style: Theme.of(context).textTheme.headline6),
                  Switch(
                    value: lan.isEn,
                    onChanged: (newValue) {
                      Provider.of<LanguageProvider>(context, listen: false)
                          .changeLan(newValue);
                      Navigator.of(context).pop();
                    },
                    activeColor: Theme.of(context).colorScheme.secondary,
                    inactiveTrackColor:
                        Provider.of<ThemeProvider>(context, listen: true).tm ==
                                ThemeMode.light
                            ? null
                            : Colors.black,
                  ),
                  Text(lan.getTexts('drawer_switch_item1').toString(),
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
            ),
            Divider(
              height: 10,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
