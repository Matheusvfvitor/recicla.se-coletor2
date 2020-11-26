import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reciclase_coletor/LoginPage.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  void nextPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        margin: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Você acabou de receber um e-mail para resetar sua senha, não esqueça de verificar seu Email 😉",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.email,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  onPressed: nextPage,
                  color: Colors.white,
                  textColor: Colors.green,
                  child: Text(
                    "Ir para Login",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
