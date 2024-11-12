import 'package:flutter/material.dart';
import 'package:zometo_app/EditProfilePage.dart';
import 'package:zometo_app/login.dart'; // Import the LoginPage

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Abhishek Tank';
  String email = 'abhishektank2004@gmail.com';
  String phone = '+91 79900 65400';
  String address = 'BHAKTI SADAN, Nana Mova Main Road, Surya Nagar Street no-4, Rajkot-360004';

  void _editProfile() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          name: name,
          email: email,
          phone: phone,
          address: address,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        name = result['name'];
        email = result['email'];
        phone = result['phone'];
        address = result['address'];
      });
    }
  }

  void _logOut() {
    // Navigate to the LoginPage when the Log Out button is clicked
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontSize: 30)),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage('assets/Screenshot 2024-08-11 at 21.49.56.png'),
              ),
            ),
            const SizedBox(height: 30.0),
            Text(
              'Name: $name',
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Email: $email',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Phone: $phone',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Address: $address',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _editProfile,
              style: ElevatedButton.styleFrom(),
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _logOut, // Calls the _logOut method to navigate to LoginPage
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Optional: Set the button color
              ),
              child: const Text('Log Out',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
