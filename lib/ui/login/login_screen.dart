import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/database/model/my_database.dart';
import 'package:todo/ui/register/register_screen.dart';
import '../../validation_utils.dart';
import '../Home/home_screen.dart';
import '../compnents/custome_form_field.dart';
import '../dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var mailController = TextEditingController(text: 'yasso@power.com');

  var passwordController = TextEditingController(text: '123456');


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFDFECDB),
        image: DecorationImage(
            image: AssetImage('assets/images/auth_pattern.png'),
            fit: BoxFit.fill
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Login'),

        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.25,
                  ),
                  CustomFormField(
                    controller: mailController,
                    label: 'E-Mail',
                    validator: (text){
                      if(text == null || text.trim().isEmpty){
                        return 'Please enter valid e-mail';
                      }
                      if (!ValidationUtils.isValidEmail(text)){
                        return 'Please enter a valid e-mail';
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomFormField(
                      controller: passwordController,
                      label: 'Password',
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please enter password';
                        }
                        if(text.length<6){
                          return 'Password should be at least 6 characters';
                        }
                      },
                      isPassword: true,
                      keyboardType: TextInputType.text
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 5)
                      ),
                      onPressed: (){
                        Login();
                      },
                      child:const Text('Login',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white
                        ),)
                  ),
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                  }, child: Text("Don't Have Account ?"))
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }

  FirebaseAuth authServices = FirebaseAuth.instance;

  void Login ()async{
    if(formKey.currentState?.validate()==false){
      return;
    }

    DialogUtils.showLoadingDialog(context,'Loading...');
    try {
      var result = await authServices.signInWithEmailAndPassword(email: mailController.text,
          password: passwordController.text);
      var user = await MyDatabase.readUser(result.user?.uid ?? "");
      DialogUtils.hideDialog(context);
      if(user==null){
        // user authenticated but not exist in the data base
        DialogUtils.showMessage(context, "error. user is not found in database ",
            postActionName: 'Ok');
        return;
      }
      DialogUtils.showMessage(context, 'Successfull login',
        postActionName: 'Ok',
        postAction: (){
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
        dismissible:false,
      );
    }
    on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage ='Wrong E-Mail or Password';
      DialogUtils.showMessage(context, errorMessage,
          postActionName: 'Ok');
    } catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage ='Something went wrong';
      DialogUtils.showMessage(context, errorMessage,
          postActionName: 'Cancel',
          negActionName: 'Try Again',
          negAction: (){
            Login();
          });
    }

  }

}
