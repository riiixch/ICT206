import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TabBar Example",
      home: TabBarExample(),
    );
  }
}

class TabBarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // จำนวน Tab
      child: Scaffold(
        appBar: AppBar(
          title: Text("Menu design"),
          backgroundColor: const Color.fromARGB(255, 200, 159, 248),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.list), text: "Service"),
              Tab(icon: Icon(Icons.info), text: "About"),
              Tab(icon: Icon(Icons.contact_mail), text: "Contact"), // เพิ่มแท็บ Contact
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 217, 196, 250),
        body: TabBarView(
          children: [
            // หน้าแรก
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network("https://picsum.photos/250?image=9", height: 150, width: 150),
                SizedBox(height: 20),
                Text("ยินดีต้อนรับสู่หน้าแรก", style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                Text("สมภพ เอี่ยมสมบัติ", style: TextStyle(fontSize: 18, color: Colors.blue)),
              ],
            ),
            // บริการ (Service) เปลี่ยนเป็น ListView
            ListView.builder(
              itemCount: 5, // จำนวนรายการ
              itemBuilder: (context, index) {
                return buildServiceItem(
                  "https://picsum.photos/${200 + index}",
                  "บริการ ${String.fromCharCode(65 + index)}",
                );
              },
            ),
            // เกี่ยวกับเรา
            ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.directions_bike),
                  title: Text("08.00"),
                  subtitle: Text("Bike Time"),
                  trailing: Icon(Icons.notifications_none),
                  onTap: () {
                    print("Bike");
                  },
                  selected: true,
                ),
                ListTile(
                  leading: Icon(Icons.directions_boat),
                  title: Text("09.20"),
                  subtitle: Text("Boat Time"),
                  trailing: Icon(Icons.notifications_none),
                  onTap: (){
                    print("Boat");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.directions_bus),
                  title: Text("10.10"),
                  subtitle: Text("Bus Time"),
                  trailing: Icon(Icons.notifications_none),
                  onTap: () {
                    print("Bus");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.directions_walk),
                  title: Text("16.30"),
                  subtitle: Text("Walk Time"),
                  trailing: Icon(Icons.notifications_none),
                  onTap: () {
                    print("Walk");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.motorcycle),
                  title: Text("18.30"),
                  subtitle: Text("Motorcycle Time"),
                  trailing: Icon(Icons.notifications_none),
                  onTap: () {
                    print("Motorcycle");
                  },
                ),
              ],
            ),
            // ติดต่อ
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.people, color: Colors.blue),
                      SizedBox(width: 8),
                      Text("Sompop Iemsombat ID : 65064435")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Colors.blue),
                      SizedBox(width: 8),
                      Text("email : sompop@riiixch.com")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Colors.green),
                      SizedBox(width: 8),
                      Text("Telephone : 0956451925")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.web, color: Colors.orange),
                      SizedBox(width: 8),
                      Text("Website : https://profile.riiixch.com/")
                    ],
                  ),
                ],
              ),  
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("คุณกดปุ่ม FloatingActionButton!"),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  // ฟังก์ชันสำหรับแสดงบริการแต่ละรายการ
  Widget buildServiceItem(String imageUrl, String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.network(imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
