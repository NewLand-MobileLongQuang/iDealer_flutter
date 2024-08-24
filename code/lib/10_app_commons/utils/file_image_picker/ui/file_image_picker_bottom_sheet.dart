import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum FileImagePickerBottomSheetResult { gallery, camera, file }

class FileImagePickerBottomSheet extends StatefulWidget {
  const FileImagePickerBottomSheet({
    Key? key,
    this.fromGallery = false,
    this.fromCamera = false,
    this.fromFile = false,
  }) : super(key: key);

  final bool fromGallery;
  final bool fromCamera;
  final bool fromFile;

  static Future<FileImagePickerBottomSheetResult?> show(
    BuildContext context, {
    bool fromGallery = false,
    bool fromCamera = false,
    bool fromFile = false,
  }) async {
    if (!fromGallery && !fromCamera && !fromFile) return null;

    return showModalBottomSheet<FileImagePickerBottomSheetResult>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => FileImagePickerBottomSheet(
        fromGallery: fromGallery,
        fromCamera: fromCamera,
        fromFile: fromFile,
      ),
    );
  }

  @override
  _FileImagePickerBottomSheetState createState() =>
      _FileImagePickerBottomSheetState();
}

class _FileImagePickerBottomSheetState
    extends State<FileImagePickerBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if (widget.fromGallery) {
      widgets.add(RowToSelect(
        onSelect: () {
          Navigator.pop(context, FileImagePickerBottomSheetResult.gallery);
        },
        text: "Thư viện ảnh",
      ));
      widgets.add(const Divider(height: 1));
    }
    if (widget.fromCamera) {
      widgets.add(RowToSelect(
        onSelect: () {
          Navigator.pop(context, FileImagePickerBottomSheetResult.camera);
        },
        text: "Camera",
      ));
      widgets.add(const Divider(height: 1));
    }
    if (widget.fromFile) {
      widgets.add(RowToSelect(
        onSelect: () {
          Navigator.pop(context, FileImagePickerBottomSheetResult.file);
        },
        text: "File",
      ));
      widgets.add(const Divider(height: 1));
    }
    widgets.removeLast();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: widgets,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Hủy",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RowToSelect extends StatelessWidget {
  const RowToSelect({
    Key? key,
    required this.onSelect,
    required this.text,
  }) : super(key: key);

  final void Function() onSelect;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        GestureDetector(
          onTap: onSelect,
          child: Container(
            width: 200,
            height: kToolbarHeight,
            color: Colors.transparent,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
