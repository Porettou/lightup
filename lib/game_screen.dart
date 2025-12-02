import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lightup/shared/button_state_manager.dart';
import 'package:lightup/shared/custom_button_container.dart';
import 'package:lightup/shared/toggle_button.dart';
import 'dart:math';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _score=0;

  final List<String> _images = [
    'assets/img/base1.png',
    'assets/img/base2.png',
    'assets/img/base3.png',
    'assets/img/base4.png',
    'assets/img/base5.png',
    'assets/img/base6.png',
    'assets/img/base7.png',
    'assets/img/base8.png',
    'assets/img/base9.png',
    'assets/img/base10.png',
    'assets/img/base11.png',
    'assets/img/base12.png',
    'assets/img/base13.png',
    'assets/img/base14.png',
    'assets/img/base15.png',
    'assets/img/base16.png',
    'assets/img/base17.png',
    'assets/img/base18.png',
    'assets/img/base19.png',
    'assets/img/base20.png',
    // Add paths to other images
  ];
  Map<String, ImageData> imageMap = {
    'assets/img/base1.png':ImageData('base1',[true,false,false,true,true,false,true,false,false,true,true,true,true,true,false,false,false,false,true]),
    'assets/img/base2.png':ImageData('base2',[true,false,false,true,true,false,false,true,true,false,true,false,true,true,false,true,true,false,false]),
    'assets/img/base3.png':ImageData('base3',[true,false,true,false,true,true,false,true,true,false,true,true,false,true,true,false,true,false,true]),
    'assets/img/base4.png':ImageData('base4',[true,false,true,false,true,false,false,false,true,false,true,true,true,true,false,false,false,true,true]),
    'assets/img/base5.png':ImageData('base5',[false,true,false,false,true,false,true,false,true,false,true,false,true,false,true,false,false,true,false]),
    'assets/img/base6.png':ImageData('base6',[false,true,false,true,false,false,true,true,false,true,false,true,true,false,false,true,false,true,false]),
    'assets/img/base7.png':ImageData('base7',[false,true,false,true,false,true,true,false,false,true,false,true,true,true,false,true,true,false,false]),
    'assets/img/base8.png':ImageData('base8',[true,true,true,true,false,false,true,true,false,true,false,true,false,true,false,true,true,true,true]),
    'assets/img/base9.png':ImageData('base9',[true,false,true,false,false,false,true,true,true,true,false,false,false,false,false,true,true,false,true]),
    'assets/img/base10.png':ImageData('base10',[false,true,false,true,true,true,false,false,false,true,true,true,true,true,true,false,false,true,false]),
    'assets/img/base11.png':ImageData('base11',[false,true,false,false,true,true,false,true,true,true,true,true,false,true,true,false,false,true,false]),
    'assets/img/base12.png':ImageData('base12',[true,true,false,false,false,false,true,true,true,true,false,true,false,false,true,false,true,false,true]),
    'assets/img/base13.png':ImageData('base13',[false,true,true,true,false,true,false,false,true,true,true,true,true,true,false,false,false,true,false]),
    'assets/img/base14.png':ImageData('base14',[false,true,true,true,true,true,false,false,false,false,true,true,true,true,true,false,false,true,true]),
    'assets/img/base15.png':ImageData('base15',[true,false,true,false,false,true,true,true,false,false,false,false,false,true,false,true,true,true,false]),
    'assets/img/base16.png':ImageData('base16',[true,true,false,false,true,false,true,true,true,false,true,true,true,false,true,false,false,true,true]),
    'assets/img/base17.png':ImageData('base17',[false,true,false,false,true,true,false,false,true,true,true,false,true,true,true,true,false,false,false]),
    'assets/img/base18.png':ImageData('base18',[false,false,true,true,true,true,false,false,true,true,true,true,false,true,true,true,true,false,true]),
    'assets/img/base19.png':ImageData('base19',[false,false,true,false,false,true,false,true,false,false,false,true,true,false,false,false,false,true,false]),
    'assets/img/base20.png':ImageData('base20',[true,true,true,false,false,true,true,false,false,false,false,true,true,false,false,false,true,true,false]),
  };
  
  late List<String> _remainingImages;
  String? _currentImage;
  String? _currentImagepath;
  Timer? _timer;
  static const int _displayDuration = 3; // Duration in seconds

  
  @override
  void initState(){
    super.initState();
    _remainingImages = List.from(_images);
    _showNextImage();
  }

  void _showNextImage() {
    _timer?.cancel();// Cancel any existing timer before showing the next image
    if (_remainingImages.isNotEmpty) {
      setState(() {
        // Pick a random image from the remaining images
        final random = Random();
        _currentImage = _remainingImages.removeAt(random.nextInt(_remainingImages.length));
        _currentImagepath=_currentImage;
      });

      // Start a timer to hide the image after a certain duration
      _timer = Timer(const Duration(seconds: _displayDuration), _hideImage);
    } else {
      // Handle the end of the game (e.g., show a "Game Over" message)
      _currentImage = null;
      _showGameOver();
    }
  }

  void _hideImage() {
    setState(() {
      _currentImage = null;
    });
  }

  void _onCheckAnswer() {
    // Cancel the timer to avoid overlap
    _timer?.cancel();

    late List<bool> _currsol = [
      context.read<ButtonStateManager>().getButtonState('btn1'),
      context.read<ButtonStateManager>().getButtonState('btn2'),
      context.read<ButtonStateManager>().getButtonState('btn3'),
      context.read<ButtonStateManager>().getButtonState('btn4'),
      context.read<ButtonStateManager>().getButtonState('btn5'),
      context.read<ButtonStateManager>().getButtonState('btn6'),
      context.read<ButtonStateManager>().getButtonState('btn7'),
      context.read<ButtonStateManager>().getButtonState('btn8'),
      context.read<ButtonStateManager>().getButtonState('btn9'),
      context.read<ButtonStateManager>().getButtonState('btn10'),
      context.read<ButtonStateManager>().getButtonState('btn11'),
      context.read<ButtonStateManager>().getButtonState('btn12'),
      context.read<ButtonStateManager>().getButtonState('btn13'),
      context.read<ButtonStateManager>().getButtonState('btn14'),
      context.read<ButtonStateManager>().getButtonState('btn15'),
      context.read<ButtonStateManager>().getButtonState('btn16'),
      context.read<ButtonStateManager>().getButtonState('btn17'),
      context.read<ButtonStateManager>().getButtonState('btn18'),
      context.read<ButtonStateManager>().getButtonState('btn19'),
    ];
   ImageData? imageData = imageMap[_currentImagepath];
   if(imageData !=null){
    if(listEquals((imageData.solution),_currsol)){
      _score = _score +5;
    }
    else{
      if(_score-4>0){_score = _score-4;}
      else{_score=0;}
    }
    imageData = null;
   }
       if (_currentImage != null) {
        _currentImagepath=null;
      // The user pressed the button before the timer ended
      _hideImage();
    }
   
       _showNextImage();
    // Reset all toggle buttons using ButtonStateManager
    context.read<ButtonStateManager>().resetButtons();
  }

  void _showGameOver() {
    // You can navigate to another screen or show a dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content:  Text('You have completed all the patterns! and your score is: '+ _score.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

   @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define different button styles
    ToggleButton blackStyleButton(String id, String label) {
      return ToggleButton(
        id: id,
        label: label,
        onColor: Colors.black,
        offColor: Colors.grey,
        textStyle: const TextStyle(color: Colors.white),
        isON: context.read<ButtonStateManager>().getButtonState(id),
        onChanged: (bool newState){
          context.read<ButtonStateManager>().setButtonState(id,newState);
        },
      );
    }
  
    ToggleButton pinkStyleButton(String id, String label) {
      return ToggleButton(
        id: id,
        label: label,
        onColor: Colors.pink,
        offColor: Colors.grey,
        textStyle: const TextStyle(color: Colors.white),
        isON: context.read<ButtonStateManager>().getButtonState(id),
        onChanged: (bool newState){
          context.read<ButtonStateManager>().setButtonState(id,newState);
        },
      );
    }
    ToggleButton honeyStyleButton(String id, String label) {
      return ToggleButton(
        id: id,
        label: label,
        onColor: const Color.fromRGBO(255, 125, 0, 1),
        offColor:const Color.fromARGB(255, 255, 238, 0),
        textStyle: const TextStyle(color: Colors.white),
        isON: context.read<ButtonStateManager>().getButtonState(id),
        onChanged: (bool newState){
          context.read<ButtonStateManager>().setButtonState(id,newState);
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Light Im Up'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(_currentImage != null)
                Image.asset(_currentImage!,
                width:MediaQuery.of(context).size.width,
                height:(MediaQuery.of(context).size.height)/3.5,
                ),
              if(_currentImage == null)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.height)/3.5, // Adjust height as needed
                  color: Colors.grey[200],
                ),
                   
              const SizedBox(height: 10,),
              Text(_score.toString()),
              CustomButtonContainer(buttonBuilder: honeyStyleButton,),
              Column(
                children:[
                  SizedBox(
                    width: 200,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                      onPressed: _onCheckAnswer,
                      child: const Text('Check Answer'))),
                  ],
                ),
            ],
          ),
        ) ,
        ),
    );
  }
}
class ImageData{
  final String id;
  final List<bool> solution;
  ImageData(this.id,this.solution);
}