import 'package:flutter/material.dart';
import 'package:meal_food/widgets/maindrawer.dart';

class Filterscreen extends StatefulWidget {
  static const routename = '/filters';

  final Function savefilter;
  final Map<String, bool> currentfilter;

  const Filterscreen(this.currentfilter, this.savefilter);

  @override
  _FilterscreenState createState() => _FilterscreenState();
}

class _FilterscreenState extends State<Filterscreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  @override
  initState() {
    _isGlutenFree = widget.currentfilter['gluten'];
    _isLactoseFree = widget.currentfilter['lactose'];
    _isVegan = widget.currentfilter['vegan'];
    _isVegetarian = widget.currentfilter['vegetarian'];
    super.initState();
  }

  Widget buildswitchlisttile(String title, String description,
      bool currentvalue, Function updatevalue) {
    return SwitchListTile(
        title: Text(title),
        value: currentvalue,
        subtitle: Text(description),
        onChanged: updatevalue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Filter"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final Map<String, bool> selectedfilter = {
                  'gluten': _isGlutenFree,
                  'lactose': _isLactoseFree,
                  'vegan': _isVegan,
                  'vegetarian': _isVegetarian,
                };
                widget.savefilter(selectedfilter);
              })
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              "Adjust Your Meal Selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildswitchlisttile(
                    "Gluten Free",
                    "Only Include Gluten-Free Meals",
                    _isGlutenFree, (newvalue) {
                  setState(() {
                    _isGlutenFree = newvalue;
                  });
                }),
                buildswitchlisttile(
                    "Lactose Free",
                    "Only Iclude Lactose-Free Meals",
                    _isLactoseFree, (newvalue) {
                  setState(() {
                    _isLactoseFree = newvalue;
                  });
                }),
                buildswitchlisttile("Vegetarian",
                    "Only Include Vegetarian Meals", _isVegetarian, (newvalue) {
                  setState(() {
                    _isVegetarian = newvalue;
                  });
                }),
                buildswitchlisttile(
                    "Vegan", "Only Include Vegan Meals", _isVegan, (newvalue) {
                  setState(() {
                    _isVegan = newvalue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
      drawer: Maindrawer(),
    );
  }
}
