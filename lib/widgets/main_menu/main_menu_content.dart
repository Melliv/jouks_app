import 'package:flutter/material.dart';
import 'package:jouks_app/utils/route_url.dart';

class MainMenuContent extends StatefulWidget {
  const MainMenuContent({super.key});

  @override
  State<MainMenuContent> createState() => _MainMenuContentState();
}

class _MainMenuContentState extends State<MainMenuContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 100),
            Container(
              height: 260,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/jouks_logo.png"))),
            ),
            const SizedBox(height: 20),
            Container(
              constraints: BoxConstraints(maxWidth: 200),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () =>
                            {Navigator.pushNamed(context, RouteUrl.EXERCISES)},
                        child: Text("Play game")),
                    SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: () =>
                            {Navigator.pushNamed(context, RouteUrl.GAME_SETUP)},
                        child: Text("Play game v2")),
                    SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: () => {}, child: Text("How to play"))
                  ]),
            )
          ],
        ));
  }
}
