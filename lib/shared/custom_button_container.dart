import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:lightup/shared/button_state_manager.dart';
import 'package:lightup/shared/toggle_button.dart';
import 'package:provider/provider.dart';

typedef ButtonStyleBuilder = ToggleButton Function(String id, String label);


class CustomButtonContainer extends StatelessWidget {
  final ButtonStyleBuilder buttonBuilder;


  const CustomButtonContainer({
    super.key,
    required this.buttonBuilder,
    });

 

   @override
  Widget build(BuildContext context) {
    // Access ButtonStateManager from the provider
    return Consumer<ButtonStateManager>(
      builder: (context, buttonStateManager, child) {
        return Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildColumn(context, ['btn1', 'btn2', 'btn3']),
                  _buildColumn(context, ['btn4', 'btn5', 'btn6', 'btn7']),
                  _buildColumn(context, ['btn8', 'btn9', 'btn10', 'btn11', 'btn12']),
                  _buildColumn(context, ['btn13', 'btn14', 'btn15', 'btn16']),
                  _buildColumn(context, ['btn17', 'btn18', 'btn19']),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildColumn(BuildContext context, List<String> buttonIds) {
    return Column(
      children: buttonIds.map((id) {
        // Use the buttonBuilder to create buttons, manage state with provider
        return HexagonWidget.flat(
          width: 70,
          height: 80,
          cornerRadius: 8,
          elevation: 3,
          padding: 0,
          child: buttonBuilder(
            id,
            '', // label, customize as needed
          ),
        );
      }).toList(),
    );
  }
 
}

