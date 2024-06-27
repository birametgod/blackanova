/*
 * File name: booking_address_chip_widget.dart
 * Last modified: 2023.02.09 at 15:50:34
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2023
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/ui.dart';
import '../../models/booking_model.dart';

class BookingAddressChipWidget extends StatelessWidget {
  const BookingAddressChipWidget({
    Key? key,
    required Booking booking,
  })  : _booking = booking,
        super(key: key);

  final Booking _booking;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      overflow: TextOverflow.fade,
      softWrap: true,
      textScaleFactor: Get.textScaleFactor,
      text: TextSpan(
        style: Get.textTheme.bodyLarge,
        children: <InlineSpan>[
          WidgetSpan(
            baseline: TextBaseline.ideographic,
            child: Container(
              margin: EdgeInsetsDirectional.only(end: 5),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0.5),
              child: Text(
                _booking.atSalon! ? "At Salon".tr : (_booking.address!.description == '' ? "My Address".tr : _booking.address!.description) ?? "",
                textScaleFactor: 1,
                style: Get.textTheme.bodyLarge,
              ),
              decoration: Ui.getBoxDecoration(color: Get.theme.focusColor.withOpacity(0.4)),
            ),
          ),
          TextSpan(
            text: _booking.address!.isUnknown() ? _booking.salon!.address!.address : _booking.address!.address,
            style: Get.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
