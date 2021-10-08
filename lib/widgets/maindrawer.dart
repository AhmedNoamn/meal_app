import 'package:flutter/material.dart';
import 'package:meal_food/screens/filterscreen.dart';

class Maindrawer extends StatelessWidget {
  Widget buildlisttile(String title, IconData icon, Function tabhandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            fontFamily: 'RobotoCondensed'),
      ),
      onTap: tabhandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              "Coocking Up",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildlisttile("MEAL", Icons.restaurant_sharp, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildlisttile("Filter", Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(Filterscreen.routename);
          }),
        ],
      ),
    );
  }
}
