import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore Egypt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const ExploreEgyptPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExploreEgyptPage extends StatelessWidget {
  const ExploreEgyptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeaderSection(),
              
              // Search Bar
              _buildSearchBar(),
              
              // Categories Section
              _buildCategoriesSection(),
              
              // Popular Places Section
              _buildPopularPlacesSection(),
              
              // Recommended Section
              _buildRecommendedSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade800,
            Colors.blue.shade600,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Traveler!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Explore Egypt',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  image: const DecorationImage(
                    image: AssetImage('assets/profile.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Fast discovering new places based on ratings and best recommendations',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search places, attractions...',
                hintStyle: TextStyle(color: Colors.grey.shade600),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.filter_list, color: Colors.grey.shade600),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final categories = [
      {'icon': Icons.landscape, 'name': 'Historical'},
      {'icon': Icons.beach_access, 'name': 'Beaches'},
      {'icon': Icons.restaurant, 'name': 'Food'},
      {'icon': Icons.hotel, 'name': 'Hotels'},
      {'icon': Icons.shopping_bag, 'name': 'Shopping'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          categories[index]['icon'] as IconData,
                          color: Colors.blue.shade700,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        categories[index]['name'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularPlacesSection() {
    final popularPlaces = [
      {
        'name': 'Pyramids of Giza',
        'location': 'Cairo',
        'rating': 4.8,
        'image': 'assets/pyramids.jpg',
        'price': '\$50'
      },
      {
        'name': 'Luxor Temple',
        'location': 'Luxor',
        'rating': 4.7,
        'image': 'assets/luxor.jpg',
        'price': '\$30'
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular Places',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularPlaces.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 280,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(popularPlaces[index]['image'] as String),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                popularPlaces[index]['name'] as String,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on, 
                                      color: Colors.white.withOpacity(0.8), 
                                      size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    popularPlaces[index]['location'] as String,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(Icons.star, 
                                      color: Colors.amber, 
                                      size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    popularPlaces[index]['rating'].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              popularPlaces[index]['price'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedSection() {
    final recommended = [
      {
        'name': 'Khan El Khalili',
        'type': 'Market',
        'rating': 4.5,
        'image': 'assets/khan.jpg',
      },
      {
        'name': 'Nile Cruise',
        'type': 'Experience',
        'rating': 4.9,
        'image': 'assets/nile.jpg',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recommended For You',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recommended.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: AssetImage(recommended[index]['image'] as String),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recommended[index]['name'] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              recommended[index]['type'] as String,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  recommended[index]['rating'].toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'View Details',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}