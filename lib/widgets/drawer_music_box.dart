import 'package:flutter/material.dart';

class DrawerMusicBox extends StatelessWidget {
  const DrawerMusicBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                const Text(
                  'Lisa',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 100, child: Image.asset("assets/img/welcome_generate.jpg", fit: BoxFit.contain)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('生成'),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('克隆'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('选择'),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('设计'),
          ),
        ],
      ),
    );
  }
}
