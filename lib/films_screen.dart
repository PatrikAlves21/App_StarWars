import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import 'models/films_model.dart';

class FilmsScreen extends StatefulWidget {
  const FilmsScreen({Key? key}) : super(key: key);

  @override
  _FilmsScreenState createState() => _FilmsScreenState();
}

final filmController = TextEditingController();

class _FilmsScreenState extends State<FilmsScreen> {
  Future<Films> pegarFilms() async {
    var url = Uri.parse(teste);
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var films = Films.fromJson(json);
    filmController.clear();
    return films;
  }

  String teste = "https://swapi.dev/api/films";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: filmController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Pesquise o Filme',
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
                    String busca = "https://swapi.dev/api/films/?search=";
                    String att = filmController.text;
                    teste = busca + att;
                  });
                }),
          )
        ],
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<Films>(
        future: pegarFilms(),
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
                            height: 200,
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
                                      child:
                                          Lottie.asset('assets/json/film.json'),
                                    ),
                                    SizedBox(
                                      height: 180,
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Título: ' +
                                                  snapshot.data!.results![index]
                                                      .title
                                                      .toString(),
                                              maxLines: 3,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Episódio: ' +
                                                  snapshot.data!.results![index]
                                                      .episodeId
                                                      .toString(),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              snapshot.data!.results![index]
                                                  .openingCrawl
                                                  .toString(),
                                              maxLines: 3,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Lançamento: ' +
                                                  snapshot.data!.results![index]
                                                      .releaseDate
                                                      .toString(),
                                              maxLines: 2,
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
    );
  }
}
