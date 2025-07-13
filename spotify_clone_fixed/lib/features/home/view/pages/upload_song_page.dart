import 'package:client/cor/theme/app_pallete.dart';
import 'package:client/cor/widgets/custom_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({Key? key}) : super(key: key);

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final songNameController = TextEditingController();
  final artistController = TextEditingController();
  Color selectedColor = Pallete.cardColor;

  @override
  void dispose() {
    songNameController.dispose();
    artistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Upload Song'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              DottedBorder(
                color: Pallete.borderColor,
                radius: const Radius.circular(10),
                dashPattern: const [5, 5],
                borderType: BorderType.RRect,
                strokeCap: StrokeCap.round,
                child: const SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_open,
                        size: 40,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Select the thumbnail for your song',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomField(
                hintText: 'Pick Song',
                controller: null,
                readOnly: true,
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(hintText: 'Artist', controller: artistController),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                  hintText: 'Song Name', controller: songNameController),
              const SizedBox(
                height: 20,
              ),
              ColorPicker(
                pickersEnabled: {
                  ColorPickerType.wheel: true,
                },
                color: selectedColor,
                onColorChanged: (Color color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
