import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app/page.dart';
import 'package:flutter_huoshu_app/common/auto_size/auto_size.dart';

void main() {
  print("Main");
  WidgetsFlutterBinding.ensureInitialized();
  AutoSizeWidgetsFlutterBinding.ensureInitialized();
  runAutoSizeApp(createApp());
}
