import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/state/AccountState.dart';
import 'package:mobile/views/GameHistory.dart';
import 'package:mobile/views/styles.dart';
import 'PublicRooms.dart';
import 'JoinPrivateRoom.dart';
import 'Room.dart';
import 'package:mobile/viewModels/MenuViewModel.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  final AccountState _accountState = AccountState();

  late double screenWidth;
  late double screenHeight;
  bool _isLoading = false;

  void _getIsLoadingValue(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    await context.read<MenuViewModel>().createRoom(
          () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RoomPage(),
          ),
        ).then((value) {
          setState(() {
            if (value != null && value is bool) {
              _isLoading = value;
            } else {
              _isLoading = false;
            }
          });
        });
      },
          () {
        Fluttertoast.showToast(
          msg: 'Creating room error',
        );
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    Size size = view.physicalSize;
    screenWidth = size.width;
    screenHeight = size.height;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mafia+'),
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  MyStyles.purple,
                  MyStyles.lightestPurple,
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Image.asset(
                'assets/images/mafialogo.png',
                fit: BoxFit.contain,
                height: 35
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             SizedBox(height: screenHeight*0.01),
              Text(
                'Welcome to the family!',
                textAlign: TextAlign.center,
                style: MyStyles.menuTitleStyle,
              ),
              SizedBox(height: screenHeight*0.0005),
              Text(
                _accountState.currentAccount!.username,
                textAlign: TextAlign.center,
                style: MyStyles.menuUsernameStyle,
              ),
              SizedBox(height: screenHeight*0.005),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      MenuItem(
                        icon: Icons.add,
                          title: _isLoading ? 'Creating...' : 'Create new room',
                          onPressed: _isLoading ? null : () => _getIsLoadingValue(context)

                      ),
                      MenuItem(
                        icon: Icons.lock_open,
                        title: 'Enter room code',
                          onPressed: _isLoading ? null : () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const JoinPrivateRoomPage()
                            )
                          );
                        }
                      ),
                      MenuItem(
                        icon: Icons.public,
                        title: 'Public rooms',
                          onPressed: _isLoading ? null : () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PublicRoomsPage()
                            )
                          );
                        }
                      ),
                      MenuItem(
                        icon: Icons.history,
                        title: 'Game history',
                          onPressed: _isLoading ? null : () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GameHistoryPage()
                            )
                          );
                        }
                      ),
                      MenuItem(
                        icon: Icons.settings,
                        title: 'Settings',
                        onPressed: _isLoading ? null : () async {
                          Fluttertoast.showToast(
                            msg: 'No settings to show',
                          );
                        }
                      ),
                      MenuItem(
                        icon: Icons.logout,
                        title: _isLoading ? 'Logging out...' : 'Logout',
                        onPressed: () {
                          context.read<MenuViewModel>().logout(
                            () {
                              Navigator.pop(context);
                            },
                            () {
                              Fluttertoast.showToast(
                                msg: 'Logout error'
                              );
                            }
                          );
                        }
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onPressed;

  const MenuItem({
    required this.icon,
    required this.title,
    required this.onPressed,
    super.key}
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: MyStyles.menuItemStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100),
          const SizedBox(height: 5),
          Text(title)
        ],
      ),
    );
  }
}