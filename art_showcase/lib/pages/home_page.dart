import 'upload_page.dart';
import 'messages_page.dart';
import '../helpers/auth_service.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'settings_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  void _logout(BuildContext context) async {
    final AuthService authService = AuthService();

    await authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MessagePage()),
                              );
                            },
                            child: const Icon(Icons.message)),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProfilePage()),
                              );
                            },
                            child: const Icon(Icons.account_circle_outlined)),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SettingsPage()),
                              );
                            },
                            child: const Icon(Icons.settings))
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                        height: 30,
                        width: 70,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text('Painting')),
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text('Photography')),
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text('Sculpture')),
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text('Digital Art')),
                            ElevatedButton(
                                onPressed: () {}, child: const Text('Drawing')),
                          ],
                        )),
                    const SizedBox(height: 8),
                  ])),
          Expanded(
              child: Stack(alignment: Alignment.center, children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(238, 238, 238, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: const Center(
                child: Text('Art Showcase will be displayed here'),
              ),
            ),
            Positioned(
                bottom: 20,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shape: const CircleBorder()),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UploadPage()),
                      );
                    },
                    child: const Icon(Icons.add_box_outlined)))
          ]))
        ],
      ),
    );
    // bottomNavigationBar: BottomBar(),
  }
}
