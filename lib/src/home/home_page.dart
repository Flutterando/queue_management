import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Entrada')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: const Text('Salão')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: const Text('Guichê')),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/config');
              },
              child: const Text('Configurações'),
            ),
          ],
        ),
      ),
    );
  }
}
