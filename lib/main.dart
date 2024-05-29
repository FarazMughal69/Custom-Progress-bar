import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyLineAnimator());
}

class Constant {
  //(52, 36, 43)
  static const Color backgroundColor = Color.fromRGBO(30, 30, 30, 1);

  static const Color headerfontColor = Color.fromRGBO(190, 134, 134, 1);

  static const Color bodyHeaderfontColor = Color.fromRGBO(123, 124, 127, 1);

  static const Color bodyTxtfontColor = Color.fromRGBO(90, 88, 70, 1);

  static const Color bodyContainerClr = Color.fromARGB(41, 30, 30, 30);

  static const Color shahdowClr = Color.fromRGBO(0, 0, 0, 0.477);

  static const BoxShadow boxShadow = BoxShadow(
    offset: Offset(2, 3),
    color: Constant.shahdowClr,
    blurRadius: 1,
    spreadRadius: 1.50,
  );

  static const BoxShadow upperboxShadow = BoxShadow(
    offset: Offset(-2, -2),
    color: Color.fromARGB(16, 130, 128, 128),
    blurRadius: 1,
    spreadRadius: .50,
  );

  static const BoxShadow extraLowerShadow = BoxShadow(
    offset: Offset(4, 4),
    color: Constant.shahdowClr,
    blurRadius: 1,
    spreadRadius: 1,
  );

  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8));
}

class MyLineAnimator extends StatefulWidget {
  const MyLineAnimator({super.key});

  @override
  State<MyLineAnimator> createState() => _MyLineAnimatorState();
}

class _MyLineAnimatorState extends State<MyLineAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late bool _isVisible = false;
  late double containerHeight = 50;
  late Animation<double> _animation;
  late double appBarheight = 50.0;
  late double rotateAngle = 1 * 3.1415927 / 360;
  late bool clicked = false;
  late double mq;
  late String percentage = '0';
  late double end = 10.0;
  late int value = 0;
  late double animationContainerWidth;
  final String title_phrase = 'L i s t V i e w. b u i l d e r ';
  final String body_phrase =
      'This is ListView.builder practice in which adding the letters of the Phrase after specific time interval....';
  late List<String> title_letters = [];
  late List<String> body_letters = [];
  late Timer timer;
  late Timer cursorTimer;
  // late Timer bodyCurserTimer =
  //     Timer.periodic(const Duration(milliseconds: 300), (Timer t) async {
  //   if (bodyTxt_index < body_phrase.length) {
  //     if (bodycurser) {
  //       bodycurser = false;
  //     } else {
  //       bodycurser = true;
  //     }
  //     setState(() {});
  //   } else {
  //     await Future.delayed(Duration(seconds: 5));
  //     bodyCurserTimer.cancel();
  //     setState(() {});
  //   }
  // });
  late int index = 0;
  late int bodyTxt_index = 0;
  late int duration = 200;
  late bool cursor = true;
  late double listViewBuilderHeight = 50.0;
  late bool bodyVisibility = false;
  late bool bodycurser = false;
  @override
  void initState() {
    cursorTimer = Timer.periodic(const Duration(milliseconds: 350), (Timer t) {
      if (index <= title_phrase.length && bodyVisibility == false) {
        if (cursor) {
          cursor = false;
        } else {
          cursor = true;
        }
        setState(() {});
      } else {
        setState(() {
          cursor = false;
        });
        cursorTimer.cancel();
      }
    });

    timer = Timer.periodic(Duration(milliseconds: duration), (Timer t) async {
      if (index < title_phrase.length) {
        title_letters.add(title_phrase[index]);
        index++;
      } else if (index == title_phrase.length &&
          bodyTxt_index < body_phrase.length) {
        // bodycurser = true;
        // bodyCurserTimer;

        await Future.delayed(const Duration(seconds: 2));
        listViewBuilderHeight = 80;
        bodyVisibility = true;

        body_letters.add(body_phrase[bodyTxt_index]);
        bodyTxt_index++;
      } else {
        timer.cancel();
      }
      setState(() {});
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )
      ..repeat(reverse: false)
      ..addListener(() {
        value = (_animation.value / end * 100).toInt();
        percentage = '$value';
        setState(() {});
      });

    _animation = Tween<double>(begin: 0, end: end).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );

    _animationController.reset();
    super.initState();

    ///rgb(61, 61, 121)
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    timer.cancel();
    cursorTimer.cancel();
  }

  void _expandedWidgetPressd() {
    _animationController.reset();
    _animationController.forward();
    setState(() {
      end = animationContainerWidth * 0.8;
      _animation = Tween<double>(begin: 0, end: end).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.ease,
        ),
      );
    });
    if (rotateAngle == 1 * 3.1415927 / 180) {
      setState(() {
        _isVisible = true;

        // percentage = '0';
      });

      Future.delayed(const Duration(milliseconds: 10100), () {
        setState(() {
          _isVisible = false;
          containerHeight = 300;
          clicked = true;
          rotateAngle = 90 * 3.1415927 / 180;
          // _animationController.animateTo(0);
        });
      });

      // print(true);
    } else {
      setState(() {
        rotateAngle = 1 * 3.1415927 / 180;
        clicked = false;
        containerHeight = 50;
        _isVisible = false;
      });

      // print(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    animationContainerWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Constant.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      curve: Curves.bounceInOut,
                      foregroundDecoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      height: appBarheight,
                      width: animationContainerWidth,
                      decoration: const BoxDecoration(
                        color: Constant.backgroundColor,
                      ),
                      duration: const Duration(milliseconds: 8000),
                      child: Center(
                        child: Text(
                          ' P R O G R E S S - B A R ',
                          // textAlign: TextAlign.start,
                          style: GoogleFonts.montserrat(
                            shadows: [
                              Constant.boxShadow,
                              Constant.upperboxShadow,
                              Constant.extraLowerShadow
                            ],
                            color: Constant.headerfontColor,
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            // fontFamily: 'Sans-sarif', //Google fonts
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    AnimatedContainer(
                      curve: Curves.easeInOutBack,
                      // curve: Curves.easeInOutCubicEmphasized,
                      // curve: Curves.easeInOut,
                      height: containerHeight,
                      width: animationContainerWidth * 0.8,
                      decoration: BoxDecoration(
                        color: clicked
                            ? Constant.bodyContainerClr
                            : Constant.backgroundColor,
                        borderRadius: Constant.borderRadius,
                        border: const Border(
                          bottom: BorderSide(
                            color: Constant.shahdowClr, // Set border color here
                            width: 1.0,
                          ),
                          // Set border width here
                        ),
                        boxShadow: const [
                          Constant.boxShadow,
                          Constant.upperboxShadow,
                        ],
                      ),
                      duration: const Duration(milliseconds: 800),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                            top: 15,
                            left: 20,
                            child: Text(
                              ' L I N E A R ',
                              style: GoogleFonts.montserrat(
                                color: Constant.bodyTxtfontColor,
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          Positioned(
                            height: 30,
                            width: 30,
                            right: 8,
                            top: 8,
                            child: Transform.rotate(
                              alignment: Alignment.center,
                              angle: rotateAngle,
                              child: IconButton(
                                icon: Icon(
                                  shadows: clicked
                                      ? []
                                      : [
                                          Constant.boxShadow,
                                          const BoxShadow(
                                            offset: Offset(3, 0),
                                            color: Constant.shahdowClr,
                                            blurRadius: 1,
                                            spreadRadius: 0.50,
                                          ),
                                        ],
                                  Icons.arrow_forward_ios_rounded,
                                  color: Constant.bodyTxtfontColor,
                                  size: 18,
                                ),
                                onPressed: () {
                                  _expandedWidgetPressd();
                                },
                                color: Constant.backgroundColor,
                              ),
                              // color: Constant.backgroundColor,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Visibility(
                              visible: _isVisible,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: FractionallySizedBox(
                                      alignment: Alignment.bottomLeft,
                                      widthFactor: 0.98,
                                      // heightFactor: 0.1,
                                      child: AnimatedContainer(
                                        // curve: Curves.easeInOutBack,
                                        decoration: const BoxDecoration(
                                            // color: Constant.shahdowClr,
                                            ),
                                        // width: MediaQuery.of(context).size.width,
                                        height: 5,
                                        duration: const Duration(seconds: 1),
                                        child: CustomPaint(
                                          // size: const Size(40, 10),
                                          painter:
                                              CustomProgressBar(_animation),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: AnimatedContainer(
                                      height: 10,
                                      width: 30,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: Text(
                                        // ignore: deprecated_member_use
                                        // textScaleFactor: 1,
                                        '$percentage%',
                                        style: GoogleFonts.montserrat(
                                          color: const Color.fromARGB(
                                              109, 255, 236, 179),
                                          fontSize: 8,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AnimatedContainer(
                      curve: Curves.easeInOutBack,
                      // curve: Curves.easeInOutCubicEmphasized,
                      // curve: Curves.easeInOut,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: clicked
                            ? Constant.bodyContainerClr
                            : Constant.backgroundColor,
                        borderRadius: Constant.borderRadius,
                        border: const Border(
                          bottom: BorderSide(
                            color: Constant.shahdowClr, // Set border color here
                            width: 1.0,
                          ),
                          // Set border width here
                        ),
                        boxShadow: const [
                          Constant.boxShadow,
                          Constant.upperboxShadow,
                        ],
                      ),
                      duration: const Duration(milliseconds: 800),
                      child: Center(
                        child: Text(
                          "C I R C U L A R",
                          style: GoogleFonts.montserrat(
                            color: Constant.bodyTxtfontColor,
                            fontSize: 17,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AnimatedContainer(
                      curve: Curves.easeInOutBack,
                      // curve: Curves.easeInOutCubicEmphasized,
                      // curve: Curves.easeInOut,
                      height: listViewBuilderHeight,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: clicked
                            ? Constant.bodyContainerClr
                            : Constant.backgroundColor,
                        borderRadius: Constant.borderRadius,
                        border: const Border(
                          bottom: BorderSide(
                            color: Constant.shahdowClr, // Set border color here
                            width: 1.0,
                          ),
                          // Set border width here
                        ),
                        boxShadow: const [
                          Constant.boxShadow,
                          Constant.upperboxShadow,
                        ],
                      ),
                      duration: const Duration(milliseconds: 800),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text(
                                //   phrase,
                                //   style: TextStyle(color: Colors.amber[200]),
                                // ),
                                ListView.builder(
                                  padding: const EdgeInsets.only(top: 13),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: title_letters.length,
                                  // itemExtent: 2.0,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      title_letters[index],
                                      style: GoogleFonts.montserrat(
                                        color: Constant.bodyTxtfontColor,
                                        fontSize: 17,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    );
                                  },
                                ),
                                Visibility(
                                  visible: cursor,
                                  child: AnimatedContainer(
                                    // padding: const EdgeInsets.only(bottom: 30),
                                    // alignment: Alignment.topCenter,
                                    duration: const Duration(seconds: 1),
                                    decoration: BoxDecoration(
                                      color: Colors.cyan[200],
                                    ),
                                    height: 15,
                                    width: 1.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: bodyVisibility,
                            child: Expanded(
                              flex: 1,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   phrase,
                                      //   style: TextStyle(color: Colors.amber[200]),
                                      // ),
                                      ListView.builder(
                                        padding: const EdgeInsets.only(top: 13),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: body_letters.length,
                                        // itemExtent: 2.0,
                                        itemBuilder: (context, index) {
                                          return Text(
                                            body_letters[index],
                                            style: GoogleFonts.aBeeZee(
                                              color: Constant.bodyTxtfontColor,
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          );
                                        },
                                      ),
                                      Visibility(
                                        visible: bodycurser,
                                        child: AnimatedContainer(
                                          // padding: const EdgeInsets.only(bottom: 30),
                                          // alignment: Alignment.topCenter,
                                          duration: const Duration(seconds: 1),
                                          decoration: BoxDecoration(
                                            color: Colors.cyan[200],
                                          ),
                                          height: 15,
                                          width: 1.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CustomProgressBar extends CustomPainter {
  final Animation<double> animation;

  CustomProgressBar(this.animation) : super(repaint: animation);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromRGBO(82, 139, 255, 1)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.butt;

    canvas.drawLine(
      Offset(0, size.height * 0.999),
      Offset(animation.value, size.height * 0.999),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}






// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Container(
//             height: 400,
//             width: 400,
//             decoration:
//                 const BoxDecoration(color: Color.fromARGB(255, 52, 198, 224)),
//             child: const Align(
//               alignment: Alignment.bottomLeft,
//               child: LineAnimator(size: Size(400, 400)),
//             ),
//           ),
//         ),
//       ),
//     );
//     // return Column(
//     //   children: [

//     //   ],
//     // );
//   }
// }

// class LineAnimator extends StatefulWidget {
//   final Size size;
//   const LineAnimator({super.key, required this.size});

//   @override
//   State<LineAnimator> createState() => _LineAnimatorState();
// }

// class _LineAnimatorState extends State<LineAnimator>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   late double width = 20.0;
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 4),
//     )
//       ..repeat(reverse: false)
//       ..addListener(() {
//         double animationValue = _animation.value * (_animation.value);
//         if (animationValue >= 50.0 && animationValue <= 70.0) {
//           // Perform logic when animation value is between 50 and 60
//           setState(() {
//             width = 40;
//           });
//           print('Animation value is between 50 and 60 $animationValue');
//         } else if (animationValue >= 170 && animationValue <= 220) {
//           // Perform logic when animation value is between 100 and 120
//           setState(() {
//             width = 20;
//           });
//           print('Animation value is between 100 and 120 $animationValue');
//         }
//         // if (animationValue > 100 && animationValue < 120) {
//         //   print('Animation Value $animationValue');
//         //   // print('true');
//         //   setState(() {
//         //     width = 40;
//         //   });
//         //   print(width);
//         // }
//         // if (animationValue > 200 && animationValue < 230) {
//         //   print("object true");
//         //   setState(() {
//         //     width = 70;
//         //   });
//         // }

//         // if (animationValue > 290 && animationValue < 300) {
//         //   print("object false");
//         //   setState(() {
//         //     width = 35;
//         //   });
//         // }
//         // if (animationValue > 350 && width != 2) {
//         //   print("object 2************");
//         //   setState(() {
//         //     width = 2;
//         //   });
//         // }
//         // if (animationValue > 210 && width != 50) {
//         //   setState(() {
//         //     width = 50;
//         //   });
//         // }
//         // if (animationValue > 300 && width != 20) {
//         //   setState(() {
//         //     width = 20;
//         //   });
//         // }
//         // if (animationValue > 310 && width != 2) {
//         //   setState(() {
//         //     width = 2;
//         //   });
//         // }
//         // Future.delayed(duration)
//       });
//     _animation = Tween<double>(begin: 0, end: -380)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

//     _controller.forward();

//     Future.delayed(const Duration(seconds: 5), () {
//       _controller.animateTo(0); // Animate the animation value to 0
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return AnimatedContainer(
//           width: width,
//           height: 5,
//           decoration: BoxDecoration(color: Colors.amber),
//           duration: const Duration(seconds: 3),
//           child: Align(
//             // alignment: Alignment.bottomLeft,
//             child: CustomPaint(
//               size: Size(width, 400),
//               painter: CustomProgressBar(_animation),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


