import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freela_app/firebase_options.dart';
import 'package:freela_app/screen/freelancer_home_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  final CollectionReference _projects =
  FirebaseFirestore.instance.collection('projects');
  _projects.add(
    {"id": 1, "title": 'Desenvolvimento de Aplicativo Mobile',
      "category": 'Desenvolvimento Mobile',
      "minBudget": 10000,
      "maxBudget": 15000,
      "description": 'Procuramos um desenvolvedor experiente para criar um aplicativo móvel para iOS e Android usando React Native. O aplicativo será um marketplace para produtos artesanais.',
      "skills": ['React Native', 'iOS', 'Android', 'API REST', 'Redux'],
     " publishedDate": DateTime(2023, 6, 15),
      "deadline": 45,
      "workType": 'Remoto',
      "clientName": 'Maria Empreendedora',
      "clientRating": 4.8,
     " clientProjects": 12}
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freela App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: TextTheme(
          headlineMedium: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          bodySmall: TextStyle(color: Colors.black),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
        ),
        cardTheme: CardTheme(
          color: Colors.white
        )
      ),
      home: FreelancerHomePage(),
    );
  }
}