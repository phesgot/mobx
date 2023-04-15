import 'package:flutter/material.dart';
import 'package:lista_de_tarefas_2/stores/login_store.dart';
import 'package:lista_de_tarefas_2/widgets/custom_text_field.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../widgets/custom_icon_button.dart';
import 'list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStore loginStore = LoginStore();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(32),
          alignment: Alignment.center,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    hint: 'E-mail',
                    prefix: const Icon(Icons.account_circle),
                    textInputType: TextInputType.emailAddress,
                    onChanged: loginStore.setEmail,
                    enabled: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Observer(builder: (_) {
                    return CustomTextField(
                      hint: 'Senha',
                      prefix: const Icon(Icons.lock),
                      obscure: loginStore.passwordVisible,
                      onChanged: loginStore.setPassword,
                      enabled: true,
                      suffix: CustomIconButton(
                        radius: 32,
                        iconData: loginStore.passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onTap: loginStore.togglePasswordVisibility,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Observer(builder: (_) {
                    return SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: loginStore.isFormValid
                            ? () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ListScreen()));
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          disabledBackgroundColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
