import 'package:flutter/material.dart';

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? venceu;
  final Function()? onReiniciar;
  final Function()? reiniciarTotal;

  const ResultadoWidget({
    required this.venceu,
    required this.onReiniciar,
    required this.reiniciarTotal,
    super.key,
  });

  Color? _getCor() {
    if (venceu == null) {
      return Colors.yellow;
    } else if (venceu!) {
      return Colors.green[300];
    } else {
      return Colors.red[300];
    }
  }

  IconData _getIcon() {
    if (venceu == null) {
      return Icons.sentiment_satisfied;
    } else if (venceu!) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade600,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: venceu != null
                    ? const EdgeInsets.only(right: 22)
                    : const EdgeInsets.only(right: 0),
                child: CircleAvatar(
                  backgroundColor: _getCor(),
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: onReiniciar,
                    icon: Icon(
                      _getIcon(),
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                ),
              ),
              venceu != null
                  ? CircleAvatar(
                      backgroundColor: _getCor(),
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: reiniciarTotal,
                        icon: const Icon(
                          Icons.restart_alt,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : const Padding(padding: EdgeInsets.all(0)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
