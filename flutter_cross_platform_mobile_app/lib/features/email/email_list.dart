import 'package:flutter/material.dart';
import 'package:TTS_Device_Manager/features/email/email.dart';
import 'package:TTS_Device_Manager/features/email/email_list_item.dart';

class EmailList extends StatelessWidget {
  final List<Email> _email;

  EmailList(this._email);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      children: _buildEmailList(),      
    );
  }

  List<EmailListItem> _buildEmailList() {
    return _email
        .map((device) => EmailListItem(device))
        .toList();
  }
}
