import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/database/model/User.dart' as MyUser;
import 'package:todo/database/model/my_database.dart';
import 'package:todo/ui/Home/home_screen.dart';
import 'package:todo/ui/compnents/custome_form_field.dart';
import 'package:todo/ui/dialog_utils.dart';
import 'package:todo/ui/login/login_screen.dart';
import 'package:todo/validation_utils.dart';
//DFECDB
class RegisterScreen extends StatefulWidget {

  static const String routeName = 'Register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController(text: 'Yasso elgyar');

  var mailController = TextEditingController(text: 'yasso@power.com');

  var passwordController = TextEditingController(text: '123456');

  var rePasswordController = TextEditingController(text: '123456');

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
          title: const Text('Register'),

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
                    controller: nameController,
                      label: 'Full Name',
                    validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please enter full name';
                        }
                    },
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
                  CustomFormField(
                    controller: rePasswordController,
                    label: 'Password Confirmation',
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please enter password-confirmation';
                        }
                        if(passwordController.text != text){
                          return "Password doesn't match";
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
                      Register();
                      },
                       child:const Text('Register',
                       style: TextStyle(
                         fontSize: 24,
                         color: Colors.white
                       ),)
                  ),
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                  }, child: Text("Already  Have Account ?"))
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }

  FirebaseAuth authServices = FirebaseAuth.instance;

  void Register ()async{
    if(formKey.currentState?.validate()==false){
      return;
    }

    DialogUtils.showLoadingDialog(context,'Loading...');
    try {
     var result = await authServices.createUserWithEmailAndPassword(email: mailController.text,
          password: passwordController.text);


     var myUser = MyUser.User(
       id: result.user?.uid,
       name: nameController.text,
       email: mailController.text,
     );
     await MyDatabase.addUser(myUser);
     DialogUtils.hideDialog(context);
     DialogUtils.showMessage(context, 'User registed successfully',
       postActionName: 'Ok',
       postAction: (){
       Navigator.pushReplacementNamed(context, LoginScreen.routeName);
       },
       dismissible:false,
     );
    }
    on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage ='Something went wrong';
      if (e.code == 'weak-password') {
        errorMessage ='The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      DialogUtils.showMessage(context, errorMessage,
      postActionName: 'Ok');
    } catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage ='Something went wrong';
      DialogUtils.showMessage(context, errorMessage,
      postActionName: 'Cancel',
      negActionName: 'Try Again',
      negAction: (){
        Register();
      });
    }

  }
}
