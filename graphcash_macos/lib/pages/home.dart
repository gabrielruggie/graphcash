import 'package:flutter/material.dart';
import 'package:graphcash_macos/components/mainMenuBtn.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Color.fromARGB(255, 50, 50, 50),
          title: const Text(
            "Graph Cash",
            style: TextStyle(fontSize: 40),
          ),
        ),
        body: Container(
          color: const Color.fromARGB(255, 37, 37, 37),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 500,
                child: Row(
                  children: <Widget>[],
                ),
              ),
              Container(
                height: 200,
                color: Color.fromARGB(255, 33, 33, 33),
                child: ButtonBar(
                  //constraints: const BoxConstraints(maxWidth: 200),
                  mainAxisSize: MainAxisSize.max,
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MenuButton(
                      height: 75,
                      width: 200,
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(255, 76, 195, 251),
                          Color.fromARGB(255, 28, 153, 243)
                        ],
                      ),
                      onPressed: () {},
                      child: const Text(
                        'New Project',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    MenuButton(
                      height: 75,
                      width: 200,
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(255, 28, 153, 243),
                          Color.fromARGB(255, 152, 46, 252)
                        ],
                      ),
                      onPressed: () {},
                      child: const Text(
                        'New Transaction',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    MenuButton(
                      height: 75,
                      width: 200,
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(255, 167, 57, 207),
                          Color.fromARGB(255, 118, 19, 205)
                        ],
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Generate Report',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
