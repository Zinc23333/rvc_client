import 'package:flutter/material.dart';

class PageWelcome2 extends StatefulWidget {
  const PageWelcome2({super.key});

  @override
  State<PageWelcome2> createState() => _PageWelcome2State();
}

class _PageWelcome2State extends State<PageWelcome2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8eee4),
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 300,
                child: Placeholder(),
              ),
              const SizedBox(height: 16),
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text("Welcome xxxxxxxxxxxxxxxxxxx"),
              const Expanded(child: SizedBox()),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xff132137),
                  ),
                  height: 36,
                  width: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.arrow_right_alt_sharp, color: Colors.white),
                    ],
                  ),
                ),
              ),
              Text.rich(TextSpan(
                children: [
                  const TextSpan(text: "Already have an account? "),
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {},
                      child: Text("Login", style: TextStyle(color: Colors.blue.shade900)),
                    ),
                  )
                ],
              )),
              const SizedBox(height: 64)
            ],
          ),
        ),
      ),
    );
  }
}
