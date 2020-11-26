import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reciclase_coletor/ChangePerfilData.dart';
import 'package:reciclase_coletor/Navegador.dart';
import 'package:reciclase_coletor/TrashColors.dart';
import 'package:reciclase_coletor/Users.dart';

class PerfilChgTelefone extends StatefulWidget {
  final Users user;

  const PerfilChgTelefone({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PerfilChgTelefone();
}

class _PerfilChgTelefone extends State<PerfilChgTelefone> {
  GlobalKey<FormState> _formKey = GlobalKey();
  Users user = Users();
  String telefone;
  bool _validate = false;
  TextEditingController nomeController = new TextEditingController();

  _updateTelefone() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(" telefone $telefone");
      ChangePerfilData().changeDataUser(telefone, "celular", context);
      //login(email, password);
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  String _validarMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
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
        title: Text("Altere seu telefone"),
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
                          child: Text("Telefone",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey[300]))),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, left: 8, right: 8),
                    child: TextFormField(
                        validator: _validarMobile,
                        controller: nomeController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "11999999999",
                            labelText: widget.user.celular,
                            prefixIcon: Icon(Icons.account_circle)),
                        onSaved: (String val) {
                          telefone = val;
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 32),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: RaisedButton(
                        onPressed: _updateTelefone,
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
