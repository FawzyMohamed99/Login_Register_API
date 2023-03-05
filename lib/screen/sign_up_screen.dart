import 'package:e_commerce_app/auth_cubit/cubit.dart';
import 'package:e_commerce_app/auth_cubit/state.dart';
import 'package:e_commerce_app/screen/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {

  RegisterScreen({Key? key}) : super(key: key);

  final nameController =TextEditingController();
  final emailController =TextEditingController();
  final phoneController =TextEditingController();
  final passwordController =TextEditingController();
  final formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context,state)
      {
        if(state is RegisterSuccessState){
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
        }
        else if(state is RegisterFailureState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
          Container(
            alignment: Alignment.center,
            height: 100,
            width: double.infinity,
            child: Text(state.message),)));
        }
      },

      builder: (context,state)

      {
        return Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Container(
                    height: 28,
                    width: 100,
                    alignment: Alignment.center,
                    color: Colors.green,
                    child: Text('Sign Up',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,

                    ),),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (input){
                      if(nameController.text.isNotEmpty)
                      {
                        return null;
                      }
                      else{
                        return 'Name must not be empty!';
                      }
                    },
                  ),
                  SizedBox(height: 12,),
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
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                    validator: (input){
                      if(phoneController.text.isNotEmpty)
                      {
                        return null;
                      }
                      else{
                        return 'Phone must not be empty!';
                      }
                    },
                  ),
                  SizedBox(height: 12,),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
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
                  SizedBox(height: 15,),
                  MaterialButton(
                    onPressed: ()
                    {
                      if(formKey.currentState!.validate()==true){
                        BlocProvider.of<AuthCubit>(context).register(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text);
                      }
                    }
                    ,
                    color: Colors.green,
                    minWidth: double.infinity,
                    child: Text('Register'),),
                ],
              ),
            ),
          ),
        );
      } ,
    );
  }
}
