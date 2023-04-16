import 'package:flutter/material.dart';
import 'package:lista_de_tarefas_2/stores/login_store.dart';
import 'package:lista_de_tarefas_2/widgets/custom_text_field.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../widgets/custom_icon_button.dart';
import 'list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStore loginStore = LoginStore();

  late ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // AutoRun é acionado inicialmente e quando houver trocas de valor
    // autorun((_){
    //   if(loginStore.loggedIn){
    //     Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(
    //             builder: (_)=>const ListScreen()
    //         ),
    //     );
    //   }
    // });

    //Reaction só é acionada quando houver troca de valor
    disposer = reaction((_) => loginStore.loggedIn, //Monitoramento
      (loggedIn) {  //Reação
        if (loggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ListScreen()),
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(32),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.ac_unit,
                      size: 250,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Observer(builder: (_) {
                          return CustomTextField(
                            hint: 'E-mail',
                            prefix: const Icon(Icons.account_circle),
                            textInputType: TextInputType.emailAddress,
                            onChanged: loginStore.setEmail,
                            enabled: !loginStore.loading,
                          );
                        }),
                        const SizedBox(
                          height: 16,
                        ),
                        Observer(builder: (_) {
                          return CustomTextField(
                            hint: 'Senha',
                            prefix: const Icon(Icons.lock),
                            obscure: loginStore.passwordVisible,
                            onChanged: loginStore.setPassword,
                            enabled: !loginStore.loading,
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
                              onPressed:
                                  loginStore.loginPressed as void Function()?,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                disabledBackgroundColor: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(100),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: loginStore.loading
                                    ? const CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      )
                                    : const Text(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
