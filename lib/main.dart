import 'package:agrofate_mobile_app/screens/main_screens.dart';
import 'package:flutter/material.dart';
import 'package:agrofate_mobile_app/screens/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  //WidgetsFlutterBinding.ensureInitialized();
  //dynamic _token = FlutterSession().get('token');
  
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var _token = prefs.getString('email');
  runApp(MyApp(token: _token,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, 
        @required this.token}) : super(key: key);
  final dynamic token;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agrofate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Color(0xff8b8b8b),
              fontSize: 18,
            ),
          ),
        ),
      ),    
      home: token ==  null ? LoginScreen() : MainScreens(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
    );
  }
}