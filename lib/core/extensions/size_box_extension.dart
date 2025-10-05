import 'package:flutter/widgets.dart';

extension View on num {
  Widget get heightBox => SizedBox(height: toDouble());
  Widget get widthBox => SizedBox(width: toDouble());
}