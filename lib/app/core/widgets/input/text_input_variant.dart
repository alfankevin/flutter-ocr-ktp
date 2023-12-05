import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TextInputVariant extends StatefulWidget {
  const TextInputVariant({
    super.key,
    required this.formControlName,
    required this.hint,
    this.textInputType = TextInputType.text,
    this.isRequiredText = false,
    this.validationMessages = const {},
    this.maxLines = 1,
    this.prefix,
    this.suffix,
    this.onChanged,
  });

  final String formControlName;
  final String hint;
  final TextInputType textInputType;
  final bool isRequiredText;
  final Map<String, String Function(Object)> validationMessages;
  final int maxLines;
  final Widget? prefix;
  final Widget? suffix;
  final Function(FormControl<Object?>)? onChanged;

  @override
  State<TextInputVariant> createState() => _TextInputVariantState();
}

class _TextInputVariantState extends State<TextInputVariant> {
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
    return ReactiveTextField(
      keyboardType: widget.textInputType,
      formControlName: widget.formControlName,
      style:
          CustomTextTheme.paragraph2.copyWith(color: ColorTheme.neutral[800]),
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
    );
  }
}
