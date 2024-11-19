import 'package:flutter/material.dart';
import 'package:ton_ton/video_player_screen.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, dynamic>> movieCategories;

  SearchScreen({required this.movieCategories});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Variabel untuk menyimpan hasil pencarian
  List<Map<String, dynamic>> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

  // Fungsi untuk mencari film
  void _searchMovies(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    List<Map<String, dynamic>> results = [];
    for (var category in widget.movieCategories) {
      for (var movie in category['movies']) {
        if (movie['title'].toLowerCase().contains(query.toLowerCase())) {
          results.add(movie);
        }
      }
    }

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pencarian Film'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari film...',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _searchMovies, // Panggil fungsi pencarian setiap kali input berubah
            ),
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(child: Text('Tidak ada hasil ditemukan.'))
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final movie = _searchResults[index];
                        return ListTile(
                          leading: Image.asset(movie['poster'], width: 50, height: 50),
                          title: Text(movie['title']),
                          onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerScreen(videoUrl: movie['url'])));
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
