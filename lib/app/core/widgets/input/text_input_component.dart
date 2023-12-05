import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TextInputComponent extends StatefulWidget {
  const TextInputComponent({
    super.key,
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
  });

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
    ValidationMessage.required: (_) => 'Inputan ini tidak boleh kosong',
    ValidationMessage.email: (_) => 'Email yang ada masukkan tidak valid',
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
                  style:
                      AppStyles.text16PxMedium.copyWith(color: ColorTheme.red),
                ),
            ],
          ),
          style: AppStyles.text16PxMedium.copyWith(fontWeight: FontWeight.w700),
        ),
        8.verticalSpacingRadius,
        ReactiveTextField(
          keyboardType: widget.textInputType,
          formControlName: widget.formControlName,
          style: AppStyles.text18Px.copyWith(color: ColorTheme.neutral[800]),
          decoration: GenerateTheme.inputDecorationIcon(
              widget.hint, widget.prefix, widget.suffix),
          validationMessages: message,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
