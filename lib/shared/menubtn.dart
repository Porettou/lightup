import 'package:flutter/material.dart';

class Menubtns extends StatelessWidget {
  const Menubtns({
    super.key,
    required this.onPressed,
    required this.child,
    });

  final Widget child;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 180,
     
      child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size(180, 60),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))
                )
              ),
              onPressed: onPressed,
              child:child,
              ),
    );
  }
}