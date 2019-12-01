import 'package:flutter/material.dart';
import 'package:TTS_Device_Manager/features/email/email.dart';

class EmailListItem extends StatelessWidget {
  final Email _email;

  EmailListItem(this._email);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(child: Text(_email.aliasFrom[0])),
        title: Text(_email.aliasFrom),
        subtitle: Text(_email.subject));
  }
}
