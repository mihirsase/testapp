import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/services/pallete.dart';

class TextFieldMolecule extends StatefulWidget {
  final Key? key;
  final TextEditingController? controller;
  final String? initialValue;
  final bool? enabled;
  final String? labelText;
  final String? helperText;
  final String? hintText;
  final InputBorder? focusedBorder;
  final InputBorder? border;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final bool showCursor;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool isPassword;
  final Widget? suffix;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final void Function(String value)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String? value)? onSaved;
  final String? Function(String? value)? validator;
  final List<dynamic> inputFormatters;
  final List<String>? autofillHints;
  final Color? backgroundColor;
  final Widget? leadingWidget;

  const TextFieldMolecule({
    final this.key,
    final this.controller,
    final this.initialValue,
    final this.enabled,
    final this.labelText,
    final this.helperText,
    final this.hintText,
    final this.focusedBorder,
    final this.border,
    final this.keyboardType,
    final this.textCapitalization = TextCapitalization.none,
    final this.autofocus = false,
    final this.showCursor = true,
    final this.autocorrect = true,
    final this.enableSuggestions = true,
    final this.isPassword = false,
    final this.suffix,
    final this.maxLines,
    final this.minLines,
    final this.maxLength,
    final this.onChanged,
    final this.onEditingComplete,
    final this.onSaved,
    final this.validator,
    final this.inputFormatters = const [],
    final this.autofillHints,
    final this.backgroundColor,
    final this.leadingWidget,
  });

  @override
  _TextFieldMoleculeState createState() => _TextFieldMoleculeState();
}

class _TextFieldMoleculeState extends State<TextFieldMolecule> {
  bool isHidden = true;

  @override
  Widget build(final BuildContext _) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: TextStyle(
              color: Pallete.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        SizedBox(height: 8),
        TextFormField(
          key: widget.key,
          controller: widget.controller,
          initialValue: widget.initialValue,
          enabled: widget.enabled,
          cursorColor: Pallete.white,
          style: TextStyle(
            fontSize: 18,
            color: Pallete.greyLight,
          ),
          decoration: InputDecoration(
            prefixIcon: widget.leadingWidget,
            filled: true,
            fillColor: widget.backgroundColor ?? Pallete.textFieldBackground,
            helperText: widget.helperText,
            helperMaxLines: 5,
            suffixIcon: suffixIcon,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 18,
              color: Pallete.greyLight,
            ),
            hintMaxLines: widget.keyboardType == TextInputType.multiline ? 99 : null,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.white,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.white.withOpacity(0.13),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.white,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.red,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.red,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            errorMaxLines: 5,
          ),
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          autofocus: widget.autofocus,
          showCursor: widget.showCursor,
          autocorrect: widget.autocorrect,
          obscureText: widget.isPassword ? isHidden : false,
          enableSuggestions: widget.enableSuggestions,
          maxLines: widget.maxLines == null
              ? (widget.keyboardType == TextInputType.multiline ? null : 1)
              : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          validator: (final String? value) {
            if (widget.validator == null) {
              if (value!.trim().isEmpty) {
                return "Field is mandatory";
              } else {
                return null;
              }
            } else {
              return widget.validator!(value);
            }
          },
          onSaved: widget.onSaved,
          inputFormatters: <TextInputFormatter>[...widget.inputFormatters],
          autofillHints: widget.autofillHints,
        ),
      ],
    );
  }

  Widget? get suffixIcon {
    if (widget.suffix != null) {
      return widget.suffix;
    } else if (widget.isPassword == true) {
      return GestureDetector(
        onTap: () {
          setState(() {
            isHidden = !isHidden;
          });
        },
        child: isHidden
            ? Icon(Icons.visibility, color: Pallete.white)
            : Icon(Icons.visibility_off, color: Pallete.white),
      );
    } else {
      return null;
    }
  }
}
