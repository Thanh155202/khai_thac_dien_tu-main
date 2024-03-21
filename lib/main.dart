import 'package:flutter/material.dart';
import 'package:originproject/views/Login/login_mobile_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Cấu hình ngôn ngữ
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('vi', ''), // Tiếng Việt
        const Locale('en', ''), // Tiếng Anh
      ],
      locale: const Locale('vi', ''),
      title: 'MyApp',
      debugShowCheckedModeBanner: false,
      home: MobileLoginLayout(),
    );
  }
}
