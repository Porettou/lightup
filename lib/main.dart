import 'package:flutter/material.dart';
import 'package:lightup/main_menu.dart';
import 'package:lightup/shared/button_state_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ButtonStateManager(),
      child: const MaterialApp(
              home: MainMenu()
            ),
    ),
    );
    
}

