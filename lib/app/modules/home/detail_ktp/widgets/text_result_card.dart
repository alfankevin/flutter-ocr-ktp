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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              ),
              content: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 16.0),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: AppStyles.text16Px.copyWith(color: ColorTheme.black),
                controller: nameCont,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, nameCont.text);
                  },
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size.fromHeight(47.5)),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Save'),
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
            flex: 1,
            child: Text(
              widget.title,
              style:
                  AppStyles.text16PxSemiBold.copyWith(color: ColorTheme.black),
            ),
          ),
          Expanded(
            flex: 2,
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
