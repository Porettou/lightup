import 'package:flutter/material.dart';


class ToggleButton extends StatefulWidget {
  final String id;
  final String label;
  final Color onColor;
  final Color offColor;
  final TextStyle textStyle;
  final bool isON;
  final ValueChanged<bool> onChanged;
  
  const ToggleButton({
    super.key,
    required this.id,
    required this.label,
    required this.onColor,
    required this.offColor,
    required this.textStyle,
    required this.isON,
    required this.onChanged,
    });
  

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {

  void toggleButton(){
    widget.onChanged(!widget.isON);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: TextButton(
        onPressed: toggleButton,
        style: TextButton.styleFrom(
          backgroundColor: widget.isON ? widget.onColor : widget.offColor,
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          
        ),
        child: Text(
          widget.label,
          style: widget.textStyle,
          ),
      ),
    );
  }
}