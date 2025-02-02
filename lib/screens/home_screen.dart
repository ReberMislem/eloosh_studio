import 'package:flutter/material.dart';
import 'add_student_screen.dart';
import 'students_list_screen.dart';



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eloosh Studio',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xfff68504),
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Color(0xffec880d), width: 4),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.teal,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Eloosh Studio',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'إدخال البيانات'),
                  Tab(text: 'التقارير'),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                AddStudentScreen(),
                StudentsListScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
