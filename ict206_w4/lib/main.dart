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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Row & Column"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.loop), text: "For loop"),
            ],
          ),
        ),
        body: TabBarView(
          children: [

            // หน้าแรก
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlutterLogo(size: 50),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sompop Iemsombat", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text("IT Department", style: TextStyle(fontSize: 16)),
                      Text("SPU CHONBURI", style: TextStyle(fontSize: 16)),
                      Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThLiI0g2WKo2lvbONOoPTpq7AJYWK5_6popQ&s"),
                    ],
                  )
                ],
              ),
            ),

            // for loop
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                    // Container สีน้ำเงิน
                    Text("สีน้ำเงิน"),
                    Container(
                      decoration: BoxDecoration(color: Colors.blue),
                      height: 100,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ข้อความในสีน้ำเงิน",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10), // ระยะห่างระหว่างข้อความกับรูปภาพ
                          Icon(
                            Icons.water_drop,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(height: 10), // ระยะห่างระหว่างข้อความกับรูปภาพ
                          Text(
                            "หยดน้ำ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Container สีแดง
                    Text("สีแดง"),
                    Container(
                      decoration: BoxDecoration(color: Colors.red),
                      height: 100,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ข้อความในสีแดง",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(height: 10), // ระยะห่างระหว่างข้อความกับรูปภาพ
                          Text(
                            "หัวใจ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Container สีเหลือง
                    Text("สีเหลือง"),
                    Container(
                      decoration: BoxDecoration(color: Colors.yellow),
                      height: 100,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ข้อความในสีเหลือง",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Icon(
                            Icons.lightbulb,
                            color: Colors.black,
                            size: 40,
                          ),
                          SizedBox(height: 10), // ระยะห่างระหว่างข้อความกับรูปภาพ
                          Text(
                            "หลอดไฟ",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    for (int i = 0; i < 10; i++)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(color: Colors.yellow),
                        height: 100,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ข้อความในสีเหลือง",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThLiI0g2WKo2lvbONOoPTpq7AJYWK5_6popQ&s", height: 40,),
                            SizedBox(height: 10),
                            Text(
                              "SPU Logo",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
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
}
