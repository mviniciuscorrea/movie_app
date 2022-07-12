import 'package:flutter/material.dart';
import 'package:movie_app/styles/style.dart';

class Input {
  Input();

  insertInputRequired({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
  }) {
    final styles = Styles();

    return TextFormField(
      controller: controller,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 25,
      ),
      validator: (String? value) {
        return (value != null && value.isEmpty)
            ? 'Obrigatório o preenchimento'
            : null;
      },
      decoration: InputDecoration(
        labelText: label,
        errorStyle: TextStyle(
          color: styles.colorSecondary(),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: styles.borderInput(),
          borderSide: BorderSide(
            color: styles.colorSecondary(),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: styles.borderInput(),
          borderSide: BorderSide(
            color: styles.colorSecondary(),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: styles.borderInput(),
          borderSide: BorderSide(
            color: styles.colorTextDefault(),
          ),
        ),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderRadius: styles.borderInput(),
          borderSide: BorderSide(
            color: styles.colorSecondary(),
          ),
        ),
        prefixIcon: Icon(
          Icons.movie,
          color: styles.colorTextDefault(),
        ),
        suffix: GestureDetector(
          onTap: () => controller.clear(),
          child: Icon(
            Icons.clear,
            color: styles.colorSecondary(),
          ),
        ),
      ),
    );
  }
}
