import 'dart:convert';
import 'package:e_commerce_app/auth_cubit/state.dart';
import 'package:e_commerce_app/network/cachnetwork.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  void register(
      {required String name,
      required String email,
      required String phone,
      required String password}) async {
    emit(RegisterLoadingState());
    try {
      Response response = await http
          .post(Uri.parse('http://student.valuxapp.com/api/register'), body: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'image': 'ok'
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          print('Response is $data');
          emit(RegisterSuccessState());
        } else {
          print('Response is $data');
          emit(RegisterFailureState(message: data['message']));
        }
      }
    } catch (e) {
      emit(RegisterFailureState(message: e.toString()));
    }
  }

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      Response response = await http.post(
          Uri.parse('http://student.valuxapp.com/api/login'),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          debugPrint("User login success and has data is : $data");
         await CacheNetwork.insertToCache(key: 'token', value: data['data']['token']);
          emit(LoginSuccessState());
        } else {
          debugPrint("Failed to login: reason is : $data['message']");
          emit(LoginFailureState(message: data['message']));
        }
      }
    } catch (e) {
      emit(LoginFailureState(message: e.toString()));
    }
  }
}
