import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter/main.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // WidgetsFlutterBinding.ensureInitialized();
    //await Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Register(),
    );
  }
}

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 380,
                  height: 50,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            FlatButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  onClickLogin(emailController.text,passwordController.text);
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                //action
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyApp()));
              },
              child: Text(
                'Already Have An Account', //title
                textAlign: TextAlign.end, //aligment
              ),
            ),

          ],
        ),
      ),
    );
  }
  Future<void> onClickLogin(String mail, String pass) async {
    await Firebase.initializeApp();
    if(mail.isEmpty){
      PrintToast("Please enter your email id");
      return;
    }else if(pass.isEmpty){
      PrintToast("Please enter your Password");
      return;
    }else{
      try {
           FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: mail, password: pass)
           .then((value) =>
           {
             PrintToast('${value.user!.email.toString()} User created'),
             Navigator.push(
                 context, MaterialPageRoute(builder: (_) => MyApp())),
           }
           );
      }catch(e){
        PrintToast(e.toString());
      }
    }
  }
  void PrintToast(String str){
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


}