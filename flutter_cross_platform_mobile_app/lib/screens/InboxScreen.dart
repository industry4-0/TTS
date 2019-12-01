import 'package:flutter/material.dart';
import 'package:TTS_Device_Manager/UtilityConstants.dart';
import 'package:TTS_Device_Manager/features/email/email.dart';
import 'package:TTS_Device_Manager/features/email/email_list.dart';
class Inbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _buildEmailList() {
      return <Email>[
        const Email(
          aliasFrom: 'Spyros Michailidis', subject: 'Finished Jobs: 2 Queued Jobs: 0'),
      const Email(
          aliasFrom: 'Tasos Athanasiadis', subject: 'Finished Jobs: 0 Queued Jobs: 2'),
      ];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(UtilityConstants.INBOX),
      ),
      body: EmailList(_buildEmailList()),
    );
  }
}