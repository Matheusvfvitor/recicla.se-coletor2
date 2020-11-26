import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reciclase_coletor/ChangePerfilData.dart';

import 'FirebaseDocuments.dart';
import 'Navegador.dart';
import 'TrashColors.dart';

class PerfilChgPrograma extends StatefulWidget {
  final String programa;

  const PerfilChgPrograma({Key key, this.programa}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PerfilChgPrograma();
}

class _PerfilChgPrograma extends State<PerfilChgPrograma> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String programa;
  bool _validate = false;
  var listProgram = new List<String>();
  TextEditingController nomeController = new TextEditingController();

  void initState() {
    super.initState();
    initPage();
  }

  initPage() async {
    await listBuilt();
  }

  listBuilt() async {
    var querySnapshot = await FirebaseDocuments().listProgram();
    querySnapshot.docs.forEach((doc) {
      var programa;
      var obj = doc.data();
      programa = obj["id"];
      setState(() {
        listProgram.add(programa);
      });
    });
  }

  _updatePrograma() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(" programa $programa");
      ChangePerfilData().changeProgramUser(programa, "programa", context);
      //login(email, password);
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  String _validarPrograma(String value) {
    print(listProgram.length);
    if (value.length == 0) {
      return "Informe o programa";
    } else if (listProgram.length > 0) {
      var retorno;
      print(listProgram.first);
      listProgram.forEach((list) {
        if (list == value) {
          retorno = null;
        } else {
          retorno = "Programa não existe";
        }
      });
      return retorno;
    } else
      return "Não existem programas cadastrados";
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
        title: Text("Programa"),
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
                          child: Text("Programa",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey[300]))),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, left: 8, right: 8),
                    child: TextFormField(
                        validator: _validarPrograma,
                        controller: nomeController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: "Digite o programa",
                            labelText: widget.programa,
                            prefixIcon: Icon(Icons.account_circle)),
                        onSaved: (String val) {
                          programa = val;
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 32),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: RaisedButton(
                        onPressed: _updatePrograma,
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
