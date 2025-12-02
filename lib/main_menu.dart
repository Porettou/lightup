import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lightup/game_screen.dart';
import 'package:lightup/shared/menubtn.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
void _startgame(){Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen()));}

void _goToStore(){print('goToStore');}

void _goToScoreBoard(){print('goToScoreBoard');}

void _exitGame(BuildContext context){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Exit Game!!'),
        content: const Text('Are you sure you want to exit the game?'),
        actions:[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop(); // Exit the app
              },
              child: const Text('Exit'),
            ),
          ],
      );
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
         
        
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Menubtns(
              onPressed: _startgame,
              child: const Text('Start Game')
              ),
              const SizedBox(height: 50),
            Menubtns(
              onPressed: _goToStore,
              child: const Text('Store')
              ),
               const SizedBox(height: 50),
            Menubtns(
              onPressed: _goToScoreBoard,
              child: const Text('Score Board')
              ),
               const SizedBox(height: 50),
            Menubtns(
              onPressed:() => _exitGame(context),
              child: const Text('Exit')
              ),
            ],
          )
          
          

        ],
      ),
    );
  }
}