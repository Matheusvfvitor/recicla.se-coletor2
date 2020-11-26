import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reciclase_coletor/ChangePerfilData.dart';

import 'Navegador.dart';
import 'TrashColors.dart';
import 'Users.dart';

class PerfilChgName extends StatefulWidget {
  final Users user;

  const PerfilChgName({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PerfilChgName();
}

class _PerfilChgName extends State<PerfilChgName> {
  GlobalKey<FormState> _formKey = GlobalKey();
  Users user = Users();
  String nome;
  bool _validate = false;
  TextEditingController nomeController = new TextEditingController();

  _updateName() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(" name $nome");
      ChangePerfilData().changeDataUser(nome, "name", context);
      //login(email, password);
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  String _validarNome(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TrashColors().appBarBackGround,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navegador().goToPerfilPage(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[],
        title: Text("Altere seu nome"),
      ),
      body: Container(
          child: Form(
              key: _formKey,
              autovalidate: _validate,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 64, left: 8),
                          child: Text("Nome",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey[300]))),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, left: 8, right: 8),
                    child: TextFormField(
                        validator: _validarNome,
                        controller: nomeController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: "Digite seu nome",
                            labelText: widget.user.name,
                            prefixIcon: Icon(Icons.account_circle)),
                        onSaved: (String val) {
                          nome = val;
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 32),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: RaisedButton(
                        onPressed: _updateName,
                        color: TrashColors().buttonColor,
                        textColor: Colors.white,
                        child: Text(
                          "Salvar",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
