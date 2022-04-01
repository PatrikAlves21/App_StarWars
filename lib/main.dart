// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/films_screen.dart';
import 'package:flutter_application_1/person_screen.dart';
import 'package:flutter_application_1/planets_screen.dart';
import 'package:lottie/lottie.dart';

import 'package:http/http.dart' as http;

import 'models/planets_model.dart';

void main() async {
  runApp(const MyApp());
}

Future<Planet> pushPlanets() async {
  var url = Uri.parse("https://swapi.dev/api/planets");
  var response = await http.get(url);
  var json = jsonDecode(response.body);
  var planet = Planet.fromJson(json);
  return planet;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      color: Colors.black,
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 180,
            width: MediaQuery.of(context).size.width * .6,
            child: Image.asset('assets/images/star.png'),
          ),
          GestureDetector(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 70,
                            width: MediaQuery.of(context).size.width * .3,
                            child: Lottie.asset(
                              'assets/json/planet.json',
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width * .5,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Planetas',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                        ],
                      )),
                )),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PlanetsScreen())),
          ),
          GestureDetector(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width * .3,
                            child: Lottie.asset('assets/json/person.json'),
                          ),
                          SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width * .5,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Personagens',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                        ],
                      )),
                )),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PersonScreen())),
          ),
          GestureDetector(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 70,
                            width: MediaQuery.of(context).size.width * .3,
                            child: Lottie.asset(
                              'assets/json/film.json',
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width * .5,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Filmes',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                        ],
                      )),
                )),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FilmsScreen())),
          ),
        ],
      ),
    )));
  }
}
