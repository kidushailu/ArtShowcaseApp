import '../helpers/image_list.dart';
import 'upload_page.dart';
import 'messages_page.dart';
import '../helpers/auth_service.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'settings_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _logout(BuildContext context) async {
    final AuthService authService = AuthService();

    await authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  String? filter;

  @override
  void initState() {
    super.initState();
    filterImages(filter);
  }

  void filterImages(String? newFilter) {
    setState(() {
      filter = newFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ArtConnect'),
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _logout(context),
            ),
          ],
        ),
        body: Column(children: [
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
                                onPressed: () {
                                  filterImages('Painting');
                                },
                                child: const Text('Painting')),
                            ElevatedButton(
                                onPressed: () {
                                  filterImages('Photography');
                                },
                                child: const Text('Photography')),
                            ElevatedButton(
                                onPressed: () {
                                  filterImages('Sculpture');
                                },
                                child: const Text('Sculpture')),
                            ElevatedButton(
                                onPressed: () {
                                  filterImages('Digital Art');
                                },
                                child: const Text('Digital Art')),
                            ElevatedButton(
                                onPressed: () {
                                  filterImages('Drawing');
                                },
                                child: const Text('Drawing')),
                          ],
                        )),
                    const SizedBox(height: 8),
                  ])),
          Expanded(
            child: Stack(alignment: Alignment.bottomCenter, children: [
              ImageList(
                filter: filter,
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
            ]),
          )
        ]));
    // bottomNavigationBar: BottomBar(),
  }
}
