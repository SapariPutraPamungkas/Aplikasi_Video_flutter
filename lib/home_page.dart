import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'video_player_screen.dart'; 
import 'profile_screen.dart';
import 'search_screen.dart';

class HomePage extends StatefulWidget {
  final String username;

  HomePage({required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;
  final List<Map<String, dynamic>> movieCategories = [
    {
      'title': 'Kartun',
      'movies': [ 
        {
          'title': 'Demon Slayer',
          'url': '',
          'poster': 'assets/images/poster_demon.jpg'
        },
        {
          'title': 'Mencuri Harum',
          'url': 'assets/videos/video2.mp4',
          'poster': 'assets/images/gambar2.jpg'
        },
        {
          'title': 'Doraemon',
          'url': 'assets/videos',
          'poster': 'assets/images/Doraemon.jpeg'
        },
      ],
    },
    {
      'title': 'Family',
      'movies': [
        {
          'title': 'Venom The Last Dance',
          'url': '',
          'poster': 'assets/images/seisun_ciderella.jpg'
        },
        {
          'title': 'Seoul Busters',
          'url': 'assets/videos/video4.mp4',
          'poster': 'assets/images/seoul_busters.jpg'
        },
      ], 
    },
  ];

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(movieCategories: movieCategories),
      SearchScreen(movieCategories: movieCategories), // Kirimkan movieCategories ke SearchScreen
      ProfileScreen(username: widget.username),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> movieCategories;

  HomeScreen({required this.movieCategories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movieCategories.length + 1, // Tambahkan 1 untuk carousel
      itemBuilder: (context, index) {
        if (index == 0) {
          // Carousel di bagian atas
          return Padding(
            padding: const EdgeInsets.all(8.0), 
            child: FlutterCarousel(
              items: [
                Image.asset(
                  'assets/images/poster_demon.jpg',
                  fit: BoxFit.cover,
                ),
                Image.asset( 
                  'assets/images/poster_venom.jpeg',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/images/produk3.jpg',
                  fit: BoxFit.cover,
                ),
              ],
              options: FlutterCarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  showIndicator: true,
                  height: 200.0),
            ),
          );
        }

        // Kategori film
        int categoryIndex = index - 1; // Adjust untuk kategori film setelah carousel
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  movieCategories[categoryIndex]['title'],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
              Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieCategories[categoryIndex]['movies'].length,
                  itemBuilder: (context, movieIndex) {
                    final movie = movieCategories[categoryIndex]['movies'][movieIndex];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(videoUrl: movie['url']),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(movie['poster']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Text(
                                  movie['title'],
                                  style: TextStyle(
                                    backgroundColor: Colors.black.withOpacity(0.5),
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
