// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:campo_minado/screens/campo_minado_app.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final qtdeBomb = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submit(BuildContext context) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    isLoading = true;

    FocusScope.of(context).unfocus();
    await Future.delayed(const Duration(milliseconds: 500));

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
            Color.fromARGB(121, 17, 120, 151),
            Color.fromARGB(223, 112, 63, 14),
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
                      icon: Padding(
                        padding: EdgeInsets.only(top: 23),
                        child: Icon(
                          Icons.play_circle_outlined,
                          size: 35,
                          color: Colors.yellow,
                        ),
                      ),
                      label: Text(
                        'Digite a quantidade de bombas!',
                        style: TextStyle(
                            color: Colors.yellow,
                            shadows: [Shadow(blurRadius: 5)]),
                      ),
                    ),
                    validator: (qtde) {
                      final qtdeBomb = qtde ?? '';
                      if (qtdeBomb.trim().isEmpty ||
                          qtdeBomb.contains(RegExp('[,.-]'))) {
                        return 'INFORME UM NÚMERO VÁLIDO!';
                      } else if (int.parse(qtdeBomb) < 1) {
                        return 'QUANTIDADE DE BOMBAS INSUFICIENTES!';
                      } else if (int.parse(qtdeBomb) > 350) {
                        return 'NUMERO MÁXIMO DE BOMBAS É DE 350!';
                      } else {
                        return null;
                      }
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
                    icon: isLoading
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child:
                                CircularProgressIndicator(color: Colors.yellow),
                          )
                        : const Icon(
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
