import 'package:delimeals/screens/meals_details.dart';
import 'package:delimeals/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

import 'screens/categories_screen.dart';
import 'screens/category_meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        '/': (context) => const TabScreen(),
        CategoryMealsScreen.rounteName: ((context) => CategoryMealsScreen()),
        MealDetailsScreen.routeName: (context) => const MealDetailsScreen(),
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
