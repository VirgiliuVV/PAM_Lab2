import 'dart:convert'; // For jsonDecode

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../entities/wine.dart';

class WineCard extends StatelessWidget {
  final List<Wine> wines;

  const WineCard({super.key, required this.wines});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: wines.length,
      itemBuilder: (context, index) {
        final wine = wines[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Constrain the image height using a SizedBox
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Image.network(wine.image, fit: BoxFit.cover),
                ),
                const SizedBox(height: 10),
                Text(
                  wine.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.wine_bar),
                    Text('Type: ${wine.type}'),
                  ],
                ),
                Text('Country: ${wine.country}'),
                Text('Grape: ${wine.grape}'),
                Text('Price: \$${wine.price.toStringAsFixed(2)}'),
                Text('Size: ${wine.sizeMl} ml'),
                Text('Critics Score: ${wine.criticsScore}'),
                Text('Place: ${wine.place}'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    wine.available
                        ? const Text('Available',
                            style: TextStyle(color: Colors.green))
                        : const Text('Out of Stock',
                            style: TextStyle(color: Colors.red)),
                    Icon(
                      wine.favourite ? Icons.favorite : Icons.favorite_border,
                      color: wine.favourite ? Colors.red : Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class WineListScreen extends StatefulWidget {
  const WineListScreen({super.key});

  @override
  _WineListScreenState createState() => _WineListScreenState();
}

class _WineListScreenState extends State<WineListScreen> {
  late Future<List<Wine>> _wineList;

  @override
  void initState() {
    super.initState();
    setState(() {
      _wineList = _loadWines();
    });
  }

  Future<List<Wine>> _loadWines() async {
    final String response =
        await rootBundle.loadString('lib/assets/wines.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((wineJson) => Wine.fromJson(wineJson)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Wine>>(
      future: _wineList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading wine data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No wines available'));
        }

        return Column(
          children: [
            WineCard(wines: snapshot.data!),
          ],
        );
      },
    );
  }
}