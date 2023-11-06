import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TextInputComponent extends StatefulWidget {
  const TextInputComponent({
    Key? key,
    required this.formControlName,
    required this.hint,
    required this.label,
    this.textInputType = TextInputType.text,
    this.isRequiredText = false,
    this.validationMessages = const {},
    this.maxLines = 1,
    this.prefix,
    this.suffix,
    this.onChanged,
  }) : super(key: key);

  final String formControlName;
  final String hint;
  final String label;
  final TextInputType textInputType;
  final bool isRequiredText;
  final Map<String, String Function(Object)> validationMessages;
  final int maxLines;
  final Widget? prefix;
  final Widget? suffix;
  final Function(FormControl<Object?>)? onChanged;

  @override
  State<TextInputComponent> createState() => _TextInputComponentState();
}

class _TextInputComponentState extends State<TextInputComponent> {
  final Map<String, String Function(Object)> message = {
    ValidationMessage.required: (_) => 'inputan ini tidak boleh kosong',
    'validation_error': (e) => (e as String),
  };

  @override
  void initState() {
    super.initState();
    message.addAll(widget.validationMessages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: widget.label,
              ),
              if (widget.isRequiredText)
                TextSpan(
                  text: "*",
                  style: AppStyles.text14PxMedium.copyWith(color: ColorTheme.red),
                ),
            ],
          ),
          style: AppStyles.text14PxMedium.copyWith(fontWeight: FontWeight.w700),
        ),
        8.verticalSpacingRadius,
        ReactiveTextField(
          keyboardType: widget.textInputType,
          formControlName: widget.formControlName,
          style: CustomTextTheme.paragraph2.copyWith(color: ColorTheme.neutral[800]),
          decoration: widget.maxLines > 1
              ? GenerateTheme.inputDecoration(widget.hint)
              : InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: 48.rounded,
                    borderSide: const BorderSide(
                      color: ColorTheme.primary,
                      width: 1,
                    ),
                  ),
                  contentPadding: 12.all,
                  hintText: widget.hint,
                  suffixIcon: widget.suffix,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: 12.w,
                    ),
                    child: widget.prefix,
                  ),
                ),
          validationMessages: message,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
