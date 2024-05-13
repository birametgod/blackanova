import '../providers/base_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonRowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildButton(context, "Services"),
        buildButton(context, "Portfolio"),
        buildButton(context, "Reviews"),
      ],
    );
  }

  Widget buildButton(BuildContext context, String buttonName) {
    final buttonSelectionModel = Provider.of<BaseModel>(context);

    return Consumer<BaseModel>(
      builder: (context, buttonSelectionModel, child) {
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              buttonSelectionModel.selectedButton == buttonName
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
          onPressed: () {
            buttonSelectionModel.selectButton(buttonName);
          },
          child: Text(buttonName),
        );
      },
    );
  }
}
