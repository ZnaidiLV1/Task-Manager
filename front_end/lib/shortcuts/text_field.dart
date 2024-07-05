import 'package:flutter/material.dart';

class FormFieldWidget extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool obscure;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;

  const FormFieldWidget({
    Key? key,
    required this.text,
    required this.icon,
    required this.onChanged,
    required this.keyboardType,
    required this.obscure,
  }) : super(key: key);

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    widget.onChanged(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: _controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field must not be empty';
          }
          return null;
        },
        keyboardType: widget.keyboardType,
        obscureText: widget.obscure,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFEFE4F1),
          prefixIcon: Icon(
            widget.icon,
            size: 25,
            color: Color(0xFF857B85),
          ),
          label: Text(
            widget.text,
            style: const TextStyle(
              color: Color(0xFF857B85),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
