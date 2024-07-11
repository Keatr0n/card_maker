import 'dart:io';

import 'package:card_maker/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class CardScreen extends StatefulWidget {
  const CardScreen(this.text, this.image, {Key? key}) : super(key: key);

  final String text;
  final File image;

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final ScreenshotController screenshotController = ScreenshotController();
  double headerFontSize = 42;
  double textFontSize = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 1600,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
                child: Screenshot(
                  controller: screenshotController,
                  child: BirthdayCard(
                    widget.text,
                    widget.image,
                    headerFontSize,
                    textFontSize,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
              child: TextFormField(
                initialValue: textFontSize.toString(),
                decoration: const InputDecoration(label: Text("Text Size")),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {
                  textFontSize = double.tryParse(value) ?? 30;
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
              child: TextFormField(
                initialValue: headerFontSize.toString(),
                decoration: const InputDecoration(label: Text("Header Size")),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {
                  headerFontSize = double.tryParse(value) ?? 42;
                }),
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () async {
                final imageBytes = await screenshotController.capture();

                File export = File("${(await getDownloadsDirectory())?.path}/export.png".replaceAll("\\", "/"));
                await export.create();
                await export.writeAsBytes(imageBytes ?? []);

                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text('Exported to ${export.path}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(_);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("EXPORT"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("BACK"),
            ),
          ],
        ),
      ),
    );
  }
}
