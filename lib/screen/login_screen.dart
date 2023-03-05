import 'package:e_commerce_app/auth_cubit/cubit.dart';
import 'package:e_commerce_app/auth_cubit/state.dart';
import 'package:e_commerce_app/screen/home_page_screen.dart';
import 'package:e_commerce_app/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

   final passwordController =TextEditingController();
   final emailController =TextEditingController();
   final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: Form(
          key: formKey,
          child: BlocConsumer<AuthCubit,AuthStates>(
            listener: (context,state)
            {

            if(state is LoginSuccessState){
              Navigator.pop(context);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
            }
            else if(state is LoginFailureState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
            Container(
            alignment: Alignment.center,
            height: 100,
            width: double.infinity,
            child: Text(state.message),)));
            }

            },
            builder: (context,state){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 28,
                    width: 100,
                    alignment: Alignment.center,
                    color: Colors.green,
                    child: Text('Login',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,

                    ),),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (input){
                      if(emailController.text.isNotEmpty)
                      {
                        return null;
                      }
                      else{
                        return 'Email must not be empty!';
                      }
                    },
                  ),
                  SizedBox(height: 12,),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Pasword',
                      border: OutlineInputBorder(),
                    ),
                    validator: (input){
                      if(passwordController.text.isNotEmpty)
                      {
                        return null;
                      }
                      else{
                        return 'Password must not be empty!';
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                    onPressed: ()
                    {
                      if(formKey.currentState!.validate() == true){
                        BlocProvider.of<AuthCubit>(context).login(
                            email: emailController.text,
                            password: passwordController.text);
                      }
                    },
                    minWidth: double.infinity,
                    color: Colors.green,
                    child: Text(state is LoginLoadingState ? 'Loading...': 'Login',),),
                  SizedBox(height: 15,),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('Forget your password ?' ,style: TextStyle(color: Colors.black),),
                          TextButton(onPressed: ()
                          {},
                              child: Text('Click her',style: TextStyle(color: Colors.black),))
                        ],
                      ),
                      Row(
                        children: [
                          Text( 'Dond have any account ?' ,style: TextStyle(color: Colors.black),),
                          TextButton(onPressed: ()
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                          },
                              child: Text('Click her',style: TextStyle(color: Colors.black),))
                        ],
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
