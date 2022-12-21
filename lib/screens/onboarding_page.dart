import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/screens/welcome_page.dart';
import 'package:blackanova/widgets/portrait_with_description.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding/onboarding.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late int index;
  final List<PageModel> onBoardingPagesList = [
    PageModel(
      widget:  PortraitWithDescription(
        file: Assets.blackSkinGirl,
        title: 'Mise en relation',
        description:'Mise en relation avec une coiffeuse près de chez vous.',
      ),
    ),
    PageModel(
      widget:  PortraitWithDescription(
        file: Assets.brownSkinGirl,
        title: 'Profils certifiés et verifiés',
        description:'Possibilité de prendre rendez-vous avec votre coiffeuse(r) préférée(é). Nous avons des profils certifiés et verifiés.',
      ),
    ),
    PageModel(
      widget:  PortraitWithDescription(
        file: Assets.lightSkinGirl,
        title:  'CHANGE AND RISE',
        description: 'Une communauté qui réunit tous les estheticiens et coiffeurs dans un seul endroit.',
      ),
    ),
  ];

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: defaultSkipButtonColor,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 2;
            setIndex(2);
          }
        },
        child: Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: GoogleFonts.alegreya(
                textStyle: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Material get _signUpButton {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: defaultSkipButtonColor,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WelcomePage()));
        },
        child: Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Sign up',
            style: GoogleFonts.alegreya(
                textStyle: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackanova.background,
      body: Onboarding(
        pages: onBoardingPagesList,
        onPageChange: (int pageIndex) {
          index = pageIndex;
        },
        startPageIndex: 0,
        footerBuilder: (context, dragDistance, pagesLength, setIndex) {
          return DecoratedBox(
            decoration: BoxDecoration(
                color: AppColors.blackanova.background,
                border: Border.all(width: 0.0, color: AppColors.blackanova.background)),
            child: ColoredBox(
              color: AppColors.blackanova.background,
              child: Padding(
                padding: const EdgeInsets.all(45.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIndicator(
                        netDragPercent: dragDistance,
                        indicator: Indicator(
                          indicatorDesign: IndicatorDesign.line(
                            lineDesign: LineDesign(
                              lineType: DesignType.line_nonuniform,
                            ),
                          ),
                        ),
                        pagesLength: pagesLength),
                    index == pagesLength - 1
                        ? _signUpButton
                        : _skipButton(setIndex: setIndex)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

