import 'package:delimeals/dummy_data.dart';
import 'package:delimeals/models/meal.dart';
import 'package:delimeals/screens/filters.dart';
import 'package:delimeals/screens/meals_details.dart';
import 'package:delimeals/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

import 'screens/categories_screen.dart';
import 'screens/category_meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filteredData) {
    setState(() {
      _filters = filteredData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex = _favouriteMeals.indexWhere(
      (meal) => meal.id == mealId,
    );
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere(
          (element) => element.id == mealId,
        ));
      });
    }
  }

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any(
      (element) => element.id == id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
        fontFamily: 'Railway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleLarge: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      //home: const CategoriesScreen(),
      /**
       * Home screen can be accesed in both ways.
       * '/' => this is default value.
       */
      routes: {
        '/': (context) => TabScreen(favouriteMeals: _favouriteMeals),
        CategoryMealsScreen.rounteName: ((context) => CategoryMealsScreen(
              availableMeals: _availableMeals,
            )),
        MealDetailsScreen.routeName: (context) =>
            MealDetailsScreen(toggleFavourite: _toggleFavourite,isFavourite:_isMealFavourite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(filters: _filters, saveFilters: _setFilters),
      },
      onGenerateRoute: ((settings) {
        /**
         * this will be used, when no named route has been metioned and the navigation will be made to the 
         * screen mentioned below.
         */
        return MaterialPageRoute(
          builder: ((context) => const CategoriesScreen()),
        );
      }),
      onUnknownRoute: ((settings) {
        /**
         * this will be triggered, to avoid the application from crashing.
         */
        return MaterialPageRoute(
            builder: (context) => const CategoriesScreen());
      }),
    );
  }
}
