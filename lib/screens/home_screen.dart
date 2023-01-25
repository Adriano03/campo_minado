import 'package:campo_minado/screens/campo_minado_app.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final qtdeBomb = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit(BuildContext context) {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return CampoMinadoApp(qtdBombas: qtdeBomb.text);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(122, 2, 50, 65),
            Color.fromARGB(227, 114, 62, 5),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Campo Minado',
                  style: TextStyle(
                      fontSize: 52, fontFamily: 'Kaushan', color: Colors.amber),
                ),
                const SizedBox(height: 120),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.yellow),
                    keyboardType: TextInputType.number,
                    controller: qtdeBomb,
                    decoration: const InputDecoration(
                      label: Text(
                        'Digite a quantidade de bombas!',
                        style: TextStyle(
                            color: Colors.yellow,
                            shadows: [Shadow(blurRadius: 5)]),
                      ),
                    ),
                    validator: (qtde) {
                      final qtdeBomb = qtde ?? '';
                      if (qtdeBomb.isEmpty) {
                        return 'Campo Obrigatório!';
                      } else if (int.parse(qtdeBomb) > 350) {
                        return 'Número máximo permitido de bombas é de 350!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.99,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      elevation: 0.1,
                      side: const BorderSide(color: Colors.yellow, width: 0.3),
                    ),
                    onPressed: () => _submit(context),
                    icon: const Icon(
                      Icons.games_outlined,
                      color: Colors.yellow,
                    ),
                    label: const Text(
                      '    INICIAR JOGO',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
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
}
