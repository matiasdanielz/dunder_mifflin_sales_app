import 'package:flutter/material.dart';

class AppIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 275,
              child: Image.asset(
                'Assets/images/dunder_mifflin_logo.jpg',
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 400,
              width: 400,
              child: Hero(
                tag: 'subLogoHero',
                child: Image.asset(
                  'Assets/images/sub_logo.jpeg',
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
