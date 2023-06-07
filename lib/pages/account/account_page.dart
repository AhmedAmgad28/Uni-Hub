import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/guest/guest_page.dart';
import 'package:project_v2/pages/account/update_account_page.dart';
import '../../services/user_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'change_password_page.dart';
import '../home/navigator_home_page.dart';

class AccountPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const AccountPage({Key? key});

  static String id = 'AccountPage';

  @override
  // ignore: library_private_types_in_public_api
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String reverseDateFormat(String dateString) {
    final parsedDate = DateTime.parse(dateString);
    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(parsedDate);
    return formattedDate;
  }

  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = getMe();
  }

  Future<void> removeToken() async {
    // ignore: prefer_const_constructors
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle the back button press here
            Navigator.popAndPushNamed(context, NavigatorHome.id);
          },
        ),
        elevation: 10,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Account Settings',
          style: TextStyle(
            color: kBackgroundColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!['data']['user'];
              final profileImgUrl = userData['photo'];
              const defaultProfileImgUrl =
                  'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/626fd8140423801.6241b91e24d9c.png';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          profileImgUrl != null &&
                                  Uri.parse(profileImgUrl).isAbsolute
                              ? profileImgUrl
                              : defaultProfileImgUrl,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData['name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              userData['email'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              userData['phone'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Joined at: ${reverseDateFormat(userData['joinAt'])}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UpdateProfilePage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          icon: const Icon(
                            Icons.edit,
                            color: kBackgroundColor,
                          ),
                          label: const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Edit Profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kBackgroundColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ChangePasswordPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          icon: const Icon(
                            Icons.lock,
                            color: kBackgroundColor,
                          ),
                          label: const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Change Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kBackgroundColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Implement settings action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          icon: const Icon(
                            Icons.settings,
                            color: kBackgroundColor,
                          ),
                          label: const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Settings',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kBackgroundColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Implement about us action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          icon: const Icon(
                            Icons.info,
                            color: kBackgroundColor,
                          ),
                          label: const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'About Us',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kBackgroundColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Delete'),
                                  content: const Text(
                                      'Are you sure you want to delete your account? (this account will be deleted forever)'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Delete'),
                                      onPressed: () {
                                        deleteMe().then((_) {
                                          // Item successfully deleted, navigate to home page
                                          removeToken().then((_) {
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                              GuestPage.id,
                                              (Route<dynamic> route) => false,
                                              arguments: {},
                                            );
                                          });
                                        }).catchError((error) {
                                          // Handle error, e.g. show error message
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Error deleting item: $error'),
                                              duration:
                                                  const Duration(seconds: 3),
                                            ),
                                          );
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          icon: const Icon(
                            Icons.delete,
                            color: kBackgroundColor,
                          ),
                          label: const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Delete Account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kBackgroundColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Log Out'),
                                  content: const Text(
                                      'Are you sure you want to log out?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Log Out'),
                                      onPressed: () {
                                        removeToken().then((_) {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                            GuestPage.id,
                                            (Route<dynamic> route) => false,
                                            arguments: {},
                                          );
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          icon: const Icon(
                            Icons.logout_rounded,
                            color: kBackgroundColor,
                          ),
                          label: const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Log Out',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kBackgroundColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Failed to retrieve user data',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
