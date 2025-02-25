import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> rides = [
      {'name': 'ice cream', 'image': 'assets/ice cream.png'},
      {'name': 'ice cream', 'image': 'assets/ice cream.png'},
      {'name': 'ice cream', 'image': 'assets/ice cream.png'},
      {'name': 'ice cream', 'image': 'assets/ice cream.png'},
      {'name': 'ice cream', 'image': 'assets/ice cream.png'},
      {'name': 'ice cream', 'image': 'assets/ice cream.png'},
      {'name': 'ice cream', 'image': 'assets/ice cream.png'},
      {'name': 'ice cream', 'image': 'assets/ice cream.png'},
    ];

    List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.home, 'label': "Home"},
      {'icon': Icons.list, 'label': "Rides"},
      {'icon': Icons.notifications, 'label': "Notifications"},
      {'icon': Icons.person, 'label': "Profile"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Your ice cream",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hi, Ikhsan👋",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: const ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.9,
                ),
                itemCount: rides.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white,
                          width: index == 0 ? 3 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(rides[index]['image']!, height: 80),
                          const SizedBox(height: 5),
                          Text(
                            rides[index]['name']!,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/details');
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.shade200,
                              child: const Icon(Icons.arrow_forward, color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: menuItems.map((item) => BottomNavigationBarItem(
          icon: Icon(item['icon']),
          label: item['label'],
        )).toList(),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
