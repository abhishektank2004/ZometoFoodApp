import 'package:flutter/material.dart';
import 'package:zometo_app/cart_page.dart';
import 'package:zometo_app/profile_page.dart'; // Import the profile page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _cartItems = [];
  List<Map<String, dynamic>> _allFoodItems = [
    {
      'imageUrl': 'assets/burger.jpg',
      'title': 'Cheeseburger',
      'subtitle': 'Wendy\'s Burger',
      'rating': 4.9,
      'price': '₹199',
    },
    {
      'imageUrl': 'assets/Hamburger.jpeg',
      'title': 'Hamburger',
      'subtitle': 'Veggie Burger',
      'rating': 4.8,
      'price': '₹299',
    },
    {
      'imageUrl': 'assets/pizza.webp',
      'title': 'Pizza',
      'subtitle': 'Wendy\'s Burger',
      'rating': 4.9,
      'price': '₹499',
    },
    {
      'imageUrl': 'assets/ExtraCheesePizza.jpg',
      'title': 'Extra Cheese Pizza',
      'subtitle': 'Extra Cheese',
      'rating': 4.8,
      'price': '₹899',
    },
    {
      'imageUrl': 'assets/Chocleateshake.jpg',
      'title': 'Chocolate Shake',
      'subtitle': 'Full Chocolate shakes',
      'rating': 4.9,
      'price': '₹499',
    },
    {
      'imageUrl': 'assets/shake.jpg',
      'title': 'Shakes',
      'subtitle': 'Biscoff Shake',
      'rating': 4.8,
      'price': '₹599',
    },
    {
      'imageUrl': 'assets/pasta.jpg',
      'title': 'Pasta',
      'subtitle': 'panner Pasta',
      'rating': 4.8,
      'price': '₹599',
    },
  ];
  List<Map<String, dynamic>> _filteredFoodItems = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredFoodItems = _allFoodItems;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartPage(cartItems: _cartItems)),
        );
      } else if (_selectedIndex == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      }
    });
  }

  void _addToCart(Map<String, dynamic> foodItem) {
    setState(() {
      _cartItems.add(foodItem);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${foodItem['title']} added to cart!'),
        duration: const Duration(seconds: 2),
      ),
    );

    print('Added to cart: $foodItem');
  }

  void _filterFoodItems(String query) {
    final filteredItems = _allFoodItems.where((item) {
      final titleLower = item['title'].toLowerCase();
      final subtitleLower = item['subtitle'].toLowerCase();
      final queryLower = query.toLowerCase();

      return titleLower.contains(queryLower) || subtitleLower.contains(queryLower);
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredFoodItems = filteredItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          automaticallyImplyLeading: false,
          title: const Text('ZOMETO FOODS'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: CircleAvatar(
                backgroundImage: AssetImage('assets/Screenshot 2024-08-11 at 21.49.56.png'), // Add your profile photo here
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: _filterFoodItems,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _filterFoodItems('');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text('All', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text('Combos', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text('Classic', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              _buildFoodItemsGrid(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'View Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItemsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          for (var item in _filteredFoodItems) ...[
            if (_filteredFoodItems.indexOf(item) % 2 == 0)
              _buildFoodItem(
                imageUrl: item['imageUrl'],
                title: item['title'],
                subtitle: item['subtitle'],
                rating: item['rating'],
                price: item['price'],
              ),
            if (_filteredFoodItems.indexOf(item) % 2 != 0)
              Row(
                children: [
                  Expanded(
                    child: _buildFoodItem(
                      imageUrl: item['imageUrl'],
                      title: item['title'],
                      subtitle: item['subtitle'],
                      rating: item['rating'],
                      price: item['price'],
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16.0),
          ],
        ],
      ),
    );
  }

  Widget _buildFoodItem({
    required String imageUrl,
    required String title,
    required String subtitle,
    required double rating,
    required String price,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.asset(
            imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
        Text(
          price,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow[700],
              size: 16.0,
            ),
            Text(
              rating.toString(),
              style: const TextStyle(fontSize: 14.0),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        ElevatedButton.icon(
          onPressed: () {
            _addToCart({
              'title': title,
              'subtitle': subtitle,
              'price': price,
            });
          },
          icon: const Icon(Icons.add),
          label: const Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
      ],
    );
  }
}
