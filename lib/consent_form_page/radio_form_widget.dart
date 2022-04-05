import 'package:flutter/material.dart';

enum Consentiment { agree, disagreee }

class RadioFormWidget extends StatefulWidget {
  final void Function(bool didAgree) onChange;

  const RadioFormWidget({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  State<RadioFormWidget> createState() => _RadioFormWidgetState();
}

class _RadioFormWidgetState extends State<RadioFormWidget> {
  Consentiment? _character = Consentiment.agree;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Concordo'),
          leading: Radio<Consentiment>(
            value: Consentiment.agree,
            groupValue: _character,
            onChanged: (Consentiment? value) {
              widget.onChange(true);
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Discordo'),
          leading: Radio<Consentiment>(
            value: Consentiment.disagreee,
            groupValue: _character,
            onChanged: (Consentiment? value) {
              widget.onChange(false);
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
