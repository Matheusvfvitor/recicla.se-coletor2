import 'package:firebase_auth/firebase_auth.dart';

class SendResetPassword {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> resetEmail(String emailReset) async {
    var emailenviado = await _firebaseAuth
        .sendPasswordResetEmail(email: emailReset)
        .then<String>((_) {
      print("email enviado");
      return "email enviado";
    }).catchError((e) {
      print("falha ao enviar email");
      return "falha no envio";
    });
    return emailenviado;
  }
}
