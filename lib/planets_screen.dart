// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/planets_model.dart';
import 'package:lottie/lottie.dart';

class PlanetsScreen extends StatefulWidget {
  const PlanetsScreen({Key? key}) : super(key: key);

  @override
  _PlanetsScreenState createState() => _PlanetsScreenState();
}

final planetController = TextEditingController();

class _PlanetsScreenState extends State<PlanetsScreen> {
  Future<Planet> pegarplanets() async {
    var url = Uri.parse(teste);
    var response = await http.get(url);
    var json = const JsonDecoder().convert(response.body);
    var planet = Planet.fromJson(json);
    uperPage = planet.next;
    lowerPage = planet.previous;
    planetController.clear();
    return planet;
  }

  var uperPage;

  var lowerPage;

  String teste = "https://swapi.dev/api/planets";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: planetController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Pesquise o Planeta',
            hintStyle: const TextStyle(color: Colors.black, fontSize: 18),
            contentPadding: const EdgeInsets.all(10.0),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 2,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 2,
                )),
          ),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .2,
            child: IconButton(
                icon: const Icon(Icons.search_rounded),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    String busca = "https://swapi.dev/api/planets/?search=";
                    String att = planetController.text;
                    teste = busca + att;
                  });
                }),
          )
        ],
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<Planet>(
        future: pegarplanets(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar'),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.results?.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/universo.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width *
                                          .3,
                                      child: Lottie.asset(
                                          'assets/json/planet.json'),
                                    ),
                                    SizedBox(
                                      height: 130,
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot
                                                  .data!.results![index].name
                                                  .toString(),
                                              maxLines: 3,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Rotação: ' +
                                                  snapshot.data!.results![index]
                                                      .rotationPeriod
                                                      .toString() +
                                                  ' Órbita: ' +
                                                  snapshot.data!.results![index]
                                                      .orbitalPeriod
                                                      .toString(),
                                              maxLines: 3,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Clima: ' +
                                                  snapshot.data!.results![index]
                                                      .climate
                                                      .toString(),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'População: ' +
                                                  snapshot.data!.results![index]
                                                      .population
                                                      .toString(),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Diâmetro: ' +
                                                  snapshot.data!.results![index]
                                                      .population
                                                      .toString(),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                    ),
                                  ],
                                )),
                          )),
                      onTap: () {});
                });
          }

          return Center(
            child: Lottie.asset('assets/json/loading.json',
                width: MediaQuery.of(context).size.width * .4),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Container(
                      color: Colors.black,
                      height: 20,
                      width: 100,
                      child: Row(children: const [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Anterior',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                    ),
                    onTap: () {
                      if (lowerPage != null) {
                        setState(() {
                          teste = lowerPage.toString();
                        });
                      }
                    },
                  ),
                  InkWell(
                    child: Container(
                      color: Colors.black,
                      height: 20,
                      width: 100,
                      child: Row(children: const [
                        Text(
                          'Próxima',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ]),
                    ),
                    onTap: () {
                      if (uperPage != null) {
                        setState(() {
                          teste = uperPage.toString();
                        });
                      }
                    },
                  ),
                ],
              ))),
    );
  }
}
