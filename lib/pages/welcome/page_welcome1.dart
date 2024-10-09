import 'package:flutter/material.dart';
import 'package:rvc_client/pages/welcome/page_welcome2.dart';

class PageWelcome1 extends StatefulWidget {
  const PageWelcome1({super.key});

  @override
  State<PageWelcome1> createState() => _PageWelcome1State();
}

class _PageWelcome1State extends State<PageWelcome1> {
  final pages = [
    ("Generate your virtual singer", "welcome_generate.jpg"),
    ("Cloning voices for your singers", "welcome_cloning.gif"),
    ("Select the song you want to hear", "welcome_select.gif"),
    ("Design a background for your singer to sing on", "welcome_design.gif"),
  ];

  int pageIndex = 2;

  String get getPageDescription => pages[pageIndex].$1;
  String get getPageImage => pages[pageIndex].$2;
  String get getPageTitle => getPageDescription.split(" ").first;

  @override
  void initState() {
    super.initState();
    pageIndex = 0;
  }

  void skipPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const PageWelcome2()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8eee4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              skipPage();
            },
            child: const Text("Skip"),
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getPageTitle,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(getPageDescription),
            const SizedBox(height: 8),
            SizedBox(
              height: 300,
              width: 300,
              child: Image.asset(
                "assets/img/$getPageImage",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Placeholder(),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 32,
              width: 12 * pages.length - 4,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Icon(
                        Icons.circle,
                        size: 8,
                        color: index == pageIndex ? Colors.black : Colors.grey,
                      ),
                  separatorBuilder: (context, index) => const SizedBox(width: 4),
                  itemCount: pages.length),
            ),
            const SizedBox(height: 16),
            IconButton.filled(
              onPressed: () {
                pageIndex = (pageIndex + 1) % pages.length;
                if (pageIndex == 0) {
                  skipPage();
                }
                setState(() {});
              },
              style: IconButton.styleFrom(backgroundColor: Colors.black),
              icon: const Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      ),
    );
  }
}
