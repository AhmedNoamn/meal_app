import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/maindrawer.dart';

// ignore: must_be_immutable
class ThemeScreen extends StatelessWidget {
  static const routename = '/themes';
  bool fromOnBoarding;
  ThemeScreen({this.fromOnBoarding = false});

  Widget buildRadiolistTile(
      ThemeMode themeVal, String txt, IconData? icon, BuildContext ctx) {
    return RadioListTile(
      secondary: Icon(
        icon,
        color: Theme.of(ctx).splashColor,
      ),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(ctx, listen: true).tm,
      onChanged: (newThemeVal) => Provider.of<ThemeProvider>(ctx, listen: false)
          .themeModeChange(newThemeVal),
      title: Text(txt),
      activeColor:Theme.of(ctx).colorScheme.secondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              title: fromOnBoarding
                  ? null
                  : Text(lan.getTexts('theme_appBar_title').toString()),
              backgroundColor: fromOnBoarding
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).colorScheme.primary,
              elevation: fromOnBoarding ? 0 : 5,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    lan.getTexts('theme_screen_title').toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    lan.getTexts('theme_mode_title').toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                buildRadiolistTile(
                    ThemeMode.system,
                    lan.getTexts('System_default_theme').toString(),
                    null,
                    context),
                buildRadiolistTile(
                    ThemeMode.light,
                    lan.getTexts('light_theme').toString(),
                    Icons.wb_sunny_sharp,
                    context),
                buildRadiolistTile(
                    ThemeMode.dark,
                    lan.getTexts('dark_theme').toString(),
                    Icons.nights_stay_sharp,
                    context),
                buildListTile(context, "Primary"),
                buildListTile(context, "Accent"),
                SizedBox(
                  height: fromOnBoarding ? 80 : 0,
                )
              ]),
            )
          ],
        ),
        drawer: fromOnBoarding ? null : Maindrawer(),
      ),
    );
  }

  ListTile buildListTile(BuildContext context, String txt) {
    var primaryColor = Provider.of<ThemeProvider>(context).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;
    return ListTile(
      title: Text(
        "Choose Your $txt Color",
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor: txt == "Primary" ? primaryColor : accentColor,
      ),
      onTap: () async {
        return await showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                elevation: 4,
                titlePadding: EdgeInsets.all(0.0),
                contentPadding: EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: txt == "Primary"
                        ? Provider.of<ThemeProvider>(ctx, listen: true)
                            .primaryColor
                        : Provider.of<ThemeProvider>(ctx, listen: true)
                            .accentColor,
                    onColorChanged: (newColor) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .onChanged(newColor, txt == "Primary" ? 1 : 2),
                    colorPickerWidth: 300,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: false,
                    displayThumbColor: true,
                    showLabel: false,
                  ),
                ),
              );
            });
      },
    );
  }
}
