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
              venceu != null
                  ? CircleAvatar(
                      backgroundColor: _getCor(),
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: onReiniciar,
                        icon: const Icon(
                          Icons.settings_backup_restore,
                          color: Colors.black,
                          size: 35,
                        ),
                      ),
                    )
                  : const Padding(padding: EdgeInsets.all(0)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CircleAvatar(
                  backgroundColor: _getCor(),
                  child: Icon(
                    _getIcon(),
                    size: 35,
                    color: Colors.black,
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
                          Icons.home_outlined,
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
