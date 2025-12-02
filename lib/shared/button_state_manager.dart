import 'package:flutter/material.dart';
import 'package:lightup/shared/toggle_button.dart';

class ButtonStateManager extends ChangeNotifier {
  final Map<String, bool> _buttonStates = {}; // A map to track button states by ID

  // Retrieve the state of a button by its ID, defaulting to false if not found
  bool getButtonState(String id) => _buttonStates[id] ?? false;

  // Set the state of a button by its ID
  void setButtonState(String id, bool newState) {
    _buttonStates[id] = newState;
    notifyListeners(); // Notify consumers to rebuild
  }

  // Toggle the state of a button by its ID
  void toggleButton(String id) {
    _buttonStates[id] = !(_buttonStates[id] ?? false); // Safeguard in case the ID is not initialized
    notifyListeners(); // Notify consumers to rebuild
  }

  // Reset all buttons to the off state
  void resetButtons() {
    _buttonStates.updateAll((key, value) => false);
    notifyListeners(); // Notify consumers to rebuild
  }
}
