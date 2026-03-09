import 'package:flutter/material.dart';
import 'package:skin_care_app/config/service_locator.dart';
import 'package:skin_care_app/core/utils/routers.dart';
import 'package:skin_care_app/presentation/on_boarding/view/on_boarding.dart';

void main() {
  
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(

   routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
     
    );
  }
}

