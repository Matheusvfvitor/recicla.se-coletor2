import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CadastroPage.dart';
import 'InfiniteButtoColor.dart';
import 'InfiniteButton.dart';
import 'LoginAll.dart';
import 'RecuperaSenha.dart';
import 'SizeConfig.dart';
import 'TrashColors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _obscureText = true;
  String password, email;
  bool _validate = false;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  _sendLogin() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("email $email senha $password");
      try {
        LoginAll().login(email, password, context);
      } catch (e) {
        print("email erro ! $email senha $password");
        print(e);
      }

      //login(email, password);
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  void resetSenha() {
    print("reset Senha");

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecuperaSenha()));
  }

  _launchURL() async {
    const url =
        'https://api.whatsapp.com/send?phone=+5511987363047&text=Tenho uma duvida';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void cadastro() {
    print("cadastro");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CadastroPage()));
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

  String _validarPassword(String value) {
    if (value.length == 0) {
      return "Informe a Senha";
    } else if (value.length < 6) {
      return "Senha deve possuir mais de 6 caracteres";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(16),
      child: Form(
          key: _formKey,
          autovalidate: _validate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              /*Flexible(
                fit: FlexFit.loose,
                child:
                    //Image(image: AssetImage('assets/reciclase_logo_verde.png')),
              ),*/
              TextFormField(
                  validator: _validarEmail,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Digite seu e-mail",
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email)),
                  onSaved: (String val) {
                    email = val;
                  }),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: _validarPassword,
                      onSaved: (String val) {
                        password = val;
                      },
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: "Digite sua senha",
                        labelText: "Senha",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            }),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 8),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: GestureDetector(
                              onTap: resetSenha,
                              child: Text(
                                "Esqueceu a Senha ?",
                                style: TextStyle(
                                  fontSize: SizeConfig.of(context)
                                      .dynamicScale(size: 20),
                                  color: Colors.blue[900],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(""),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 2,
                    child: InfiniteButtonColor(
                      action: cadastro,
                      text: 'Cadastre-se',
                      color: TrashColors().highlightButton,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: InfiniteButton(
                      action: _sendLogin,
                      text: 'Login',
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: _launchURL,
                    child: Text(
                      "Precisa de ajuda? Clique aqui.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SizeConfig.of(context).dynamicScale(size: 20),
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    ));
  }
}
