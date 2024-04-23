import 'package:flutter/material.dart';
import 'package:jouks_app/domain/body.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PlayerBodyCreateSheet extends StatelessWidget {
  const PlayerBodyCreateSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Body body = Body();

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 340,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Player body",
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              Column(
                children: [
                  TextFormField(
                    onChanged: (value) => body.height = int.parse(value),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Height (cm)", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    onChanged: (value) => body.weight = int.parse(value),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Weight (kg)", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 8),
                  ToggleSwitch(
                    initialLabelIndex: 0,
                    minHeight: 75.0,
                    minWidth: double.maxFinite,
                    activeBgColor: [Colors.blue.shade50],
                    inactiveBgColor: Colors.white,
                    dividerColor: Colors.blue,
                    borderColor: [Colors.blue],
                    borderWidth: 1.0,
                    customWidgets: [
                      // Overrides default widgets, foreground colors
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xffC0C0C0),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xffFFD700),
                          )
                        ],
                      ),
                    ],
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
