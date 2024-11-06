import 'package:fitness_app/presentation/pages/home_page/home_page.dart';
import 'package:fitness_app/presentation/pages/resources_page/resources_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE0C3FC),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            icon: SvgPicture.asset(
              'assets/svgs/Home Switch.svg',
              height: 25,
              width: 25,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResourcesScreen(),
                ),
              );
            },
            icon: SvgPicture.asset(
              'assets/svgs/Resources Switch.svg',
              height: 25,
              width: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/svgs/Stars.svg',
              height: 25,
              width: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/svgs/Support & Help Switch.svg',
              height: 25,
              width: 25,
            ),
          ),
        ],
      ),
    );
  }
}
