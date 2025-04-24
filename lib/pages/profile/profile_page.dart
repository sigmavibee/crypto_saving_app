import 'package:auto_route/auto_route.dart';
import 'package:crypto_saving_app/pages/auth/screen/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_router.dart';
import '../../components/box_information.dart';
import '../../components/friend_profile_pic.dart';
import '../../components/profile_picture.dart';
import '../../models/user.dart';
import '../../services/auth_services.dart';
import '../../styles/colors.dart';
import '../../styles/text_style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = true;
  User? _user;

  @override
  void initState() {
    super.initState();
    fetchUser(); // Ganti nama dari fetchUsername ke fetchUser
  }

  Future<void> fetchUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('id');

      if (userId == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final user = await AuthService().getUser(int.parse(userId));
      setState(() {
        _user = user;
      });
    } catch (e) {
      // Handle error
      print('Error fetching user: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  final AuthService authService = AuthService();

  void _logout() async {
    bool success = false;
    try {
      await authService.logout();
      success = true; // Set success to true if no exception occurs
      context.router.push(const AuthenticationRoute());
    } catch (e) {
      print('Logout error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor.withOpacity(0.5),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfilePicture(),
                      SizedBox(
                        height: 20,
                      ),
                      // Stack for name and username with background box
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          BoxInformation(
                            height: 100,
                          ),
                          Column(
                            children: [
                              Text(
                                _user?.name ?? 'Guest',
                                style: kHeading6.copyWith(
                                  color: kMatterhornBlack,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                _user?.username ?? 'Guest',
                                style: kBody1.copyWith(color: kDarkGray),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          BoxInformation(height: 80),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Crypto Super App Member Since :',
                                  style: kBody1.copyWith(
                                    color: kMatterhornBlack,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  _user?.createdAt ?? '2023-10-01',
                                  style: kBody1.copyWith(color: kDarkGray),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            BoxInformation(height: 80),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Text(
                                  'Friends : 147',
                                  style: kBody1.copyWith(
                                    color: kMatterhornBlack,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    FriendProfilePict('assets/images/ava.png'),
                                    FriendProfilePict('assets/images/ava2.png'),
                                    FriendProfilePict('assets/images/ava2.png'),
                                    FriendProfilePict('assets/images/ava3.png'),
                                    FriendProfilePict('assets/images/ava4.png'),
                                  ],
                                )
                              ]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          BoxInformation(height: 80),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Achievements',
                                  style: kBody1.copyWith(
                                    color: kMatterhornBlack,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    FriendProfilePict(
                                        ('assets/images/trophy.png')),
                                    FriendProfilePict(
                                        ('assets/images/trophy.png')),
                                    FriendProfilePict(
                                        ('assets/images/trophy.png')),
                                    FriendProfilePict(
                                        ('assets/images/trophy.png')),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AuthenticationPage()),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.blue),
                                foregroundColor:
                                    WidgetStatePropertyAll(Colors.black),
                                textStyle: WidgetStateProperty.all<TextStyle>(
                                    kButton1),
                              ),
                              icon: Icon(
                                  Icons.person_outlined), // Add the icon here
                              label: const Text('Edit Profile'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _logout();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.red),
                                foregroundColor:
                                    WidgetStatePropertyAll(Colors.black),
                                textStyle: WidgetStateProperty.all<TextStyle>(
                                    kButton1),
                              ),
                              icon:
                                  Icon(Icons.exit_to_app), // Add the icon here
                              label: const Text('Logout'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
