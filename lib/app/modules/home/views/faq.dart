import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:get/get.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {


  @override
  void initState() {
    super.initState();
  }

  final _loremIpsum =
      "Open the Blackanova app to get started and follow the\nsteps. Blackanova doesn’t charge a fee to create or\nmaintain your Blackanova account.";
  final _contentStyle =
  const TextStyle(fontSize: 14, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset("assets/images/back.png", scale: 5),
        ),
        title: Text(
          "FAQ",
          style: TextStyle(color: Colors.black, fontFamily: 'Gilroy_Bold'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 30),
            Row(
              children: [
                SizedBox(width: width / 15),
                Text(
                  "Top Questions",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Gilroy_Bold'),
                ),
              ],
            ),
            SizedBox(height: height / 50),
            Accordion(
              disableScrolling: true,
              flipRightIconIfOpen: true,
              contentVerticalPadding: 0,
              scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
              contentBorderColor: Colors.transparent,
              maxOpenSections: 1,
              headerBackgroundColorOpened: Colors.black54,
              headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              children: [
                AccordionSection(
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  headerBackgroundColor: Colors.white,
                  header: Text(
                    'How to create a Blackanova account?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  content: Text(_loremIpsum, style: _contentStyle),
                  contentHorizontalPadding: 20,
                  contentBorderWidth: 1,
                ),
                AccordionSection(
                  //flipRightIconIfOpen: true,
                  headerBackgroundColor: Colors.white,
                  header: Text(
                    'How to add a payment method?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  content: Text(_loremIpsum, style: _contentStyle),
                  contentHorizontalPadding: 20,
                  contentBorderWidth: 1,
                ),
                AccordionSection(
                  //flipRightIconIfOpen: true,
                  headerBackgroundColor: Colors.white,
                  header: Text(
                    'How to take care of your hair ?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  content: Text(_loremIpsum, style: _contentStyle),
                  contentHorizontalPadding: 20,
                  contentBorderWidth: 1,
                ),
              ],
            ),
            // type("How to buy stocks?", Icons.add),
          ],
        ),
      ),
    );
  }

  Widget type(txt, icon) {
    return Row(
      children: [
        SizedBox(width: width / 15),
        Text(
          txt,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Gilroy_Bold',
              fontSize: 14),
        ),
        const Spacer(),
        Icon(icon, color: Colors.blue, size: 20),
        SizedBox(width: width / 15),
      ],
    );
  }

  Widget faqtype(image, txt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(image, height: height / 25),
        SizedBox(height: height / 100),
        Text(
          txt,
          style: TextStyle(color: Colors.black, fontSize: 13),
        )
      ],
    );
  }
}

dynamic height;
dynamic width;

double responsiveWidth(int X, double width) {
  return (width * X) / width;
}

double responsiveHeight(int X, double height) {
  return (height * X) / height;
}

