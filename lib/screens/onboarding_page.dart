import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blackanova/constants.dart';
import 'package:blackanova/widgets/card_info.dart';
import 'package:blackanova/widgets/google_font_one.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final int _numPages = 3;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> roundedCircleArray = [];
    for (int i = 0; i < _numPages; i++) {
      roundedCircleArray
          .add(_currentPage == i ? indicator(true) : indicator(false));
    }
    return roundedCircleArray;
  }

  Widget indicator(bool isActive) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      duration: Duration(milliseconds: 150),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
          color: isActive ? gradientThird : gradientFirst,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: homeBodyDecoration,
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 40.0,
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text(
                      'Skip',
                      style: GoogleFonts.poppins(
                          textStyle:
                          TextStyle(fontSize: 20.0, color: Colors.white
                            //fontWeight: FontWeight.bold
                          )),
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    //height: 650,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (currentPage) {
                        setState(() {
                          _currentPage = currentPage;
                        });
                      },
                      children: <Widget>[
                        CardInfo(imagePath: 'assets/images/location.png',width: 300.0, height: 300.0),
                        CardInfo(imagePath: 'assets/images/finder.png',width: 300.0, height: 300.0),
                        CardInfo(imagePath: 'assets/images/city.png',width: 300.0, height: 300.0)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(bottom: 40.0, right: 20.0),
                    child: FlatButton(
                      onPressed: () {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 1),
                            curve: Curves.ease);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: gradientFirst,
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GoogleFontOne(size: 20.0, textValue: 'Next'),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: gradientEnd,
                              size: 20.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                    : Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: gradientSecond,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0))),
                    height: 100.0,
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () => print('Get started'),
                      child: Center(
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: GoogleFontOne(
                                textValue: 'Get started',
                                size: 30.0)
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

