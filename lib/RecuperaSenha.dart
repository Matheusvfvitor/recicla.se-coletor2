import 'package:flutter/material.dart';
import 'package:reciclase_coletor/Navegador.dart';
import 'package:reciclase_coletor/SendResetPassword.dart';

class RecuperaSenha extends StatefulWidget {
  @override
  _RecuperaSenhaState createState() => _RecuperaSenhaState();
}

class _RecuperaSenhaState extends State<RecuperaSenha> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String email;
  bool _validate = false;

  void resetEmail(String emailReset, BuildContext context) async {
    var email = await SendResetPassword().resetEmail(emailReset);
    print("email enviado: $email");
    if (email == "email enviado") {
      Navegador().goToResetPassword(context);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Email enviado.")));
    } else {
      print("falha no envio.$email");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Falha ao enviar o email.")));
    }
    print("context 2 $context");
  }

  String _validarEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Informe o Email";
    } else if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  _sendReset(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("email $email ");
      print("context 1 $context");
      resetEmail(email, context);
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navegador().goToLogin(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[],
        title: Text("Recuperar a Senha"),
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child: Form(
              key: _formKey,
              autovalidate: _validate,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Esqueceu a senha ?",
                      style: TextStyle(fontSize: 35, color: Colors.black),
                    ),
                    Text(
                      "Digite seu e-mail, após isso você receberá um e-mail para reiniciar sua senha",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    TextFormField(
                      validator: _validarEmail,
                      onSaved: (String val) {
                        email = val;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Digite seu e-mail", labelText: "Email"),
                    ),
                    Text(""),
                    Text(""),
                    Builder(
                      builder: (BuildContext context) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: RaisedButton(
                            onPressed: () {
                              _sendReset(context);
                              print("context 3 $context");
                            },
                            color: Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              "Enviar Senha",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ))),
    );
  }
}
