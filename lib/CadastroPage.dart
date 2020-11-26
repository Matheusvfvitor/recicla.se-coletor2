import 'package:flutter/material.dart';
import 'FirebaseDocuments.dart';
import 'Navegador.dart';
import 'SiginUpPassEmail.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String password, email, nome, codigo, programa;
  bool _obscureText = true;
  bool _validate = false;
  var listCod = new List<String>();

  void initState() {
    super.initState();
    initPage();
  }

  initPage() async {
    await listBuilt();
  }

  listBuilt() async {
    var querySnapshot = await FirebaseDocuments().codShare();
    querySnapshot.docs.forEach((doc) {
      var codigo;
      var obj = doc.data();
      codigo = obj["id"];
      setState(() {
        listCod.add(codigo);
      });
    });
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

  String _validarNome(String value) {
    //String patttern = r'(^[a-zA-Z ]*$)';
    //RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o nome";
    } else {
      //if (!regExp.hasMatch(value)) {
      //return "O nome deve conter caracteres de a-z ou A-Z";
      return null;
    }
  }

  String _validarCodigo(String value) {
    print(listCod.length);
    if (value.length == 0) {
      return null;
    } else if (listCod.length > 0) {
      var retorno;
      print(listCod.first);
      listCod.forEach((list) {
        if (list == value) {
          retorno = null;
        } else {
          retorno = "codígo não existe";
        }
      });
      return retorno;
    } else
      return "Não existem codígos cadastrados";
  }

  _sendSignUp(BuildContext contextSnack) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("email $email senha $password nome $nome programa $programa");
      SiginUpPassEmail()
          .siginUpNew(nome, email, password, context, contextSnack, codigo);
      //login(email, password);
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
          title: Text("Cadastro"),
        ),
        body: Container(
            margin: EdgeInsets.all(4),
            child: Form(
              key: _formKey,
              autovalidate: _validate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Olá Seja Bem Vindo 😍",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    "Diga um pouco mais sobre você",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  TextFormField(
                    validator: _validarNome,
                    onSaved: (String val) {
                      nome = val;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.perm_identity),
                      hintText: "Qual seu nome ?",
                      labelText: "Nome",
                    ),
                  ),
                  TextFormField(
                    validator: _validarEmail,
                    onSaved: (String val) {
                      email = val;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Qual o seu e-mail ?",
                      labelText: "Email",
                    ),
                  ),
                  TextFormField(
                    validator: _validarPassword,
                    onSaved: (String val) {
                      password = val;
                    },
                    keyboardType: TextInputType.text,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: "Crie uma senha",
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
                  Text(
                    "Foi indicado por alguem digite o codigo abaixo.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  TextFormField(
                    validator: _validarCodigo,
                    onSaved: (String val) {
                      codigo = val;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Digite o código",
                      labelText: "Código de compartilhamento",
                      prefixIcon: Icon(Icons.code),
                    ),
                  ),
                  Builder(builder: (BuildContext context) {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          _sendSignUp(context);
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text(
                          "Cadastro",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  })
                ],
              ),
            )));
  }
}
