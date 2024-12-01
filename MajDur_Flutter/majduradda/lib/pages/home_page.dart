import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:majduradda/Services/auth_services.dart';
import 'package:majduradda/components/majdurTile.dart';
import 'package:majduradda/models/Majdurs/majdurdetails.dart';
import 'package:majduradda/Services/majdurservice.dart';
import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:majduradda/pages/profile_page.dart';
import 'package:majduradda/pages/setting_page.dart';

class Homepage extends StatefulWidget {
   final Function(int) onTap;
  final Function(int)? onTabChange;
  const Homepage({super.key, required this.onTap, required this.onTabChange});

  @override
   State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final AuthService _authService = AuthService();
  Future<void> _handleRefresh() async {
    getMajdurdata();
    return await Future.delayed(const Duration(seconds: 2));
  }
  List<MajdurDetails>? majdurdetails;
  var isLoaded = false;
   int count = 0;
  @override
  void initState()
  {
    super.initState();
    getMajdurdata();
  }
  getMajdurdata() async
  {
    majdurdetails = await MajdurService().getMajdurdata();
    if(majdurdetails !=null){
      setState(() {
        isLoaded =true;
        count = majdurdetails!.length;
      });
    }
  }
   _buildMockList(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width - 16;
    var list = <CardModel>[];
    for (int i = 0; i < count; i++) {
      list.add(
        CardModel(
          shadowBlurRadius: 4,
          backgroundColor: Colors.grey.withOpacity(0.5),
          radius: const Radius.circular(30),
          shadowColor: const Color.fromARGB(255, 52, 52, 52).withOpacity(0.3),
          child: SizedBox(
            height: 210,
            width: containerWidth,
            child: Stack(
              children: [
                // White circle on top left
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
                // White box on corresponding row
                Positioned(
                  top: 20,
                  left: 90,
                  child: Container(
                    width: 250,
                    height: 50,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 20,
                  child: Container(
                    width: 320,
                    height: 80,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Center(child: Text("Majduradda")),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  "M A J D U R",
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(
                'Profile',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfilePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                'Settings',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingPage()));
              },
            ),
             ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'LogOut',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                _authService.signOut();
              },
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: LiquidPullToRefresh(
          onRefresh: _handleRefresh,
          color: Colors.grey,
          backgroundColor: Colors.grey.shade200,
          animSpeedFactor: 2,
          showChildOpacityTransition: false,
          height: 300,
          child: ListView(
            children: [
              const SizedBox(height: 25),
              const Center(
                child: Text(
                  "Pick from the available list of majdhur",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 550,
                child: ListView.builder(
                  itemCount: count,
                  padding: const EdgeInsets.all(15),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final majdurdetail = majdurdetails?[index];
                    return MajdurTile(majdur: majdurdetail);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
