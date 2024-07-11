import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'card_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _file;
  String? _text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                FilePicker.platform
                    .pickFiles(
                  type: FileType.image,
                )
                    .then((value) {
                  if (value == null) {
                    if (mounted) setState(() {});
                    return;
                  }

                  _file = File.fromUri(Uri.file(value.files.first.path ?? "", windows: Platform.isWindows));
                  if (mounted) setState(() {});
                });
              },
              child: Text(_file == null ? 'PICK IMAGE' : 'PICK A DIFFERENT IMAGE'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Clipboard.getData('text/plain').then((value) {
                  _text = value?.text;
                  if (mounted) setState(() {});
                });
              },
              child: Text(_text == null ? 'GET TEXT FROM CLIPBOARD' : 'GET TEXT FROM CLIPBOARD AGAIN'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _file == null || _text == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return CardScreen(_text!, _file!);
                          },
                        ),
                      );
                    },
              child: const Text('MAKE CARD'),
            ),
          ],
        ),
      ),
    );
  }
}
