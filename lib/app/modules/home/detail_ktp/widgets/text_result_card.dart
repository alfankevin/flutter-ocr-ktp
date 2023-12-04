import 'package:flutter/material.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';

class TextResultCard extends StatefulWidget {
  const TextResultCard({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String value;
  final Function(String x) onChanged;

  @override
  State<TextResultCard> createState() => _TextResultCardState();
}

class _TextResultCardState extends State<TextResultCard> {
  late String value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final val = await showDialog(
          context: context,
          builder: (context) {
            final nameCont = TextEditingController(text: value);

            return AlertDialog(
              title: Text('Ubah ${widget.title}'),
              content: TextField(
                decoration: GenerateTheme.inputDecoration("Masukkan ${widget.title}"),
                style: AppStyles.text16Px.copyWith(color: ColorTheme.black),
                controller: nameCont,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, nameCont.text);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save_rounded),
                      Text('Simpan'),
                    ],
                  ),
                ),
              ],
            );
          },
        );
        if (val is String && val.isNotEmpty) {
          widget.onChanged.call(val);
          setState(() {
            value = val;
          });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: AppStyles.text16PxSemiBold.copyWith(color: ColorTheme.black),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppStyles.text14PxMedium.copyWith(color: ColorTheme.black),
            ),
          )
        ],
      ).py(3),
    );
  }
}
