import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:reciclase_coletor/SizeConfig.dart';
import 'package:reciclase_coletor/TrashColors.dart';
import 'package:reciclase_coletor/ValidarEmail.dart';

class PhoneValidation extends StatefulWidget {
  @override
  _PhoneValidationState createState() => _PhoneValidationState();
}

class _PhoneValidationState extends State<PhoneValidation> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  var maskFormatter = new MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  GlobalKey<FormState> _formKey = GlobalKey();
  String telefone;
  bool _validate = false;
  TextEditingController nomeController = new TextEditingController();

  _updateTelefone() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(" telefone $telefone");
      final time = DateTime.now().millisecondsSinceEpoch;
      final currUser = _firebaseAuth.currentUser;
      final ref = db.collection("user_activity");
      final userCollection = db.collection("picker").doc(currUser.uid);
      userCollection.update({"celular": telefone}).then((_) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ValidarEmail()));
        print("sucesso");
      }).catchError((e) {
        print("Falha");
      });
      //login(email, password);
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  String _validarMobile(String value) {
    String pattern =
        r'(^(\(11\) [9][0-9]{4}-[0-9]{4})|(\(1[2-9]\) [5-9][0-9]{3}-[0-9]{4})|(\([2-9][1-9]\) [5-9][0-9]{3}-[0-9]{4})$)'; //r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    print(value);
    if (value.length == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ValidarEmail()));
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Form(
              key: _formKey,
              autovalidate: _validate,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 128, left: 8),
                          child: Text(
                              "Cadastre o seu celular e ganhe \n trashcoins para trocar por \n cupons incríveis.",
                              style: TextStyle(
                                  fontSize: SizeConfig.of(context)
                                      .dynamicScale(size: 24),
                                  color: Colors.black))),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 64, left: 8),
                          child: Text("Digite o número do seu celular.",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black))),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, left: 8, right: 8),
                    child: TextFormField(
                        inputFormatters: [maskFormatter],
                        validator: _validarMobile,
                        controller: nomeController,
                        keyboardType: TextInputType.phone,
                        decoration:
                            InputDecoration(prefixIcon: Icon(Icons.phone)),
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
                          "Prosseguir",
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
