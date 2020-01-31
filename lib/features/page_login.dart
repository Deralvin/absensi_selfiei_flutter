
import 'package:absensi_selfie_2020_java/animation/fade_animatpion.dart';
import 'package:absensi_selfie_2020_java/features/home_page.dart';
import 'package:absensi_selfie_2020_java/models/response_login.dart';
import 'package:absensi_selfie_2020_java/services/api_services.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginPage extends StatefulWidget{
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  ApiService apiService;
  Flushbar flushbar;
  ProgressDialog pr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    apiService = ApiService();
  }
  @override
  void showErrorMessage() {
    flushbar = Flushbar(
      title: "Failed",
      message: "Login Failed please check your username and password",
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.easeOut,
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.clear,color: Colors.white,),
      duration:new Duration(seconds: 5),
    )..show(context);
  }
  
  void showLoginSuccess(){

  }
  
  void showLoading(){
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);

    pr.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.deepPurpleAccent,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    pr.show();
  }
  void attempt_login()async{
    showLoading();
    ResponseLogin resp = await apiService.attemptLogin(email.text.toString(), pass.text.toString());
    if(resp.status != 'success'){
      showErrorMessage();
      pr.dismiss();
    }else{
      pr.dismiss();
    }
    print(resp.status);
    print(pass.text);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill
                        )
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeAnimation(1, Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/light-1.png')
                                )
                            ),
                          )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(1.3, Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/light-2.png')
                                )
                            ),
                          )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(1.5, Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/clock.png')
                                )
                            ),
                          )),
                        ),
                        Positioned(
                          child: FadeAnimation(1.6, Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                            ),
                          )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(1.8, Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10)
                                )
                              ]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextField(
                                  controller: email,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email or Phone number",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  obscureText: true,
                                  controller: pass,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                        SizedBox(height: 30,),
                        FadeAnimation(2, Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ]
                              )
                          ),
                          child: Center(
                            child: InkWell(
                              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              onTap: (){
//                                Navigator.pushReplacement(
//                                  context,
//                                  MaterialPageRoute(builder: (context) => HomePage()),
//                                );

                              attempt_login();
                              },
                            )
                          ),
                        )),
                        SizedBox(height: 70,),
                        FadeAnimation(1.5, Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}