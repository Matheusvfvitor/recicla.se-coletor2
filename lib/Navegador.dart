import 'package:flutter/material.dart';
import 'package:reciclase_coletor/Home.dart';
import 'package:reciclase_coletor/PerfilPage.dart';
import 'package:reciclase_coletor/PhoneValidation.dart';
import 'package:reciclase_coletor/ResetPassword.dart';

import 'IntroScreen.dart';
import 'LoginPage.dart';
import 'PerfilChgName.dart';
import 'PerfilChgPhoto.dart';
import 'PerfilChgPrograma.dart';
import 'PerfilChgTelefone.dart';
import 'Users.dart';

class Navegador {
  void goToIntroScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => IntroScreen()));
  }

  void goToLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void goToHome(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  void goToPerfilChgPhoto(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PerfilChgPhoto()));
  }

  void goToPerfilChgName(BuildContext context, Users user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PerfilChgName(
                  user: user,
                )));
  }

  void goToPerfilChgTelefone(BuildContext context, Users user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PerfilChgTelefone(
                  user: user,
                )));
  }

  void goToPhoneValidation(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PhoneValidation()));
  }

  void goToPerfilChgPrograma(BuildContext context, String programa) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PerfilChgPrograma(
                  programa: programa,
                )));
  }

  void goToPerfilPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PerfilPage()));
  }

  void goToResetPassword(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResetPassword()));
  }
}
