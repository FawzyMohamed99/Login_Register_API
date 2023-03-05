import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/auth_cubit/cubit.dart';
import 'package:e_commerce_app/bloc_observer.dart';
import 'package:e_commerce_app/constant/constant.dart';
import 'package:e_commerce_app/network/cachnetwork.dart';
import 'package:e_commerce_app/screen/home_page_screen.dart';
import 'package:e_commerce_app/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
 await CacheNetwork.cacheInitialization();
  token = CacheNetwork.getCacheData(key: 'token');
  print('token is ${token}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>AuthCubit())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Commerce App',
          home: token != null && token != "" ? HomePage() : LoginScreen(),
        )
    );
  }
}

