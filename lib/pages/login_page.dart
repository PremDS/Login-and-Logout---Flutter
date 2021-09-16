import 'package:flutter/material.dart';
import 'package:login_system/services/api_service.dart';
import 'package:login_system/services/progressHUD.dart';
import 'package:login_system/utils/form_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String _username  = "";
  String _password = "";
  bool hidePassword = true;
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        key: _scaffoldKey,
        body: ProgressHUD(
          child: _loginUISetup(context),
          inAsyncCall: showLoading,
          opacity: 0.3,

        ),
      ),
    );
  }


  Widget _loginUISetup(BuildContext context) {
    return new SingleChildScrollView(
      child: Container(
        child: Form(
          key:globalFormKey,
          child:_loginUI(context),
        )
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width:MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height / 3.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin:Alignment.topCenter,
              end:Alignment.bottomCenter,
              colors: [
                Colors.redAccent,
                Colors.redAccent
              ]
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(150),
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: Image.network(
                    "https://premtamang.com/static/images/Prem%20Tamang.png",
                    fit:BoxFit.contain,
                    width:140
                ),
              ),
              Spacer(),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding:EdgeInsets.only(bottom:20, top:40),
            child:Text("Login", style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25))
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom:20, top:20),
          child: FormHelper.inputFieldWidget(
            context,
            Icon(Icons.verified_user),
            "username",
            "Username",
            (onValidateVal){
              if(onValidateVal.isEmpty) {
                return "Username can\'t be empty.";
              }
              return null;
            },
            (onSavedValue){
              _username = onSavedValue.toString().trim();
            },


          ),
        ),
        Padding(
          padding:EdgeInsets.only(bottom: 20),
          child: FormHelper.inputFieldWidget(
              context,
              Icon(Icons.lock),
              "password",
              "Password",
              (onValidateVal){
                if(onValidateVal.isEmpty){
                  return "Password can\'t be empty.";
                }
                return null;
              },
              (onSavedValue){
                _password = onSavedValue.toString().trim();
              },
              initialValue: "",
              obsecureText: hidePassword,
              suffixIcon: IconButton(
              onPressed: ()=> {
              setState(() {
              hidePassword = !hidePassword;
              }),

              },
              color:Colors.redAccent.withOpacity(0.8),
              icon: Icon(
              hidePassword?Icons.visibility_off:Icons.visibility
              ),
              ),

              ),
        ),
        SizedBox(
          height:20,
        ),
        Center(
          child:showLoading
              ? CircularProgressIndicator()
              : FormHelper.saveButton("Login",() {
                if(validateAndSave()) {
                  print("Username: $_username");
                  print("Password: $_password");
                  showLoading=true;
                  setState((){});
                  APIServices.loginCustomer(_username, _password).then((response) {
                    print(response);
                  });
                }

          }),
        ),
      ],
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    return false;
  }

}