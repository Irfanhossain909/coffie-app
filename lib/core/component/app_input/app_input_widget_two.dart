import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppInputWidgetTwo extends StatefulWidget {
  const AppInputWidgetTwo({
    super.key,
    this.hintText,
    this.prefix,
    this.suffixIcon,
    this.isPassWord = false,
    this.isEmail = false,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.keyboardType,
    this.fillColor,
    this.elevation = 0.0,
    this.elevationColor,
    this.minLines = 1,
    this.readOnly = false,
    this.borderRadius,
    this.contentPadding,
    this.style,
    this.maxLines,
    this.onFieldSubmitted,
    this.onTap,
    this.onChanged,
    this.isPassWordSecondValidation = false,
    this.isOptional = false,
    this.isPassWordSecondValidationController,
    this.title,
    this.validator,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.textAlignVertical,
    this.filled = true,
    this.borderColor,

    /// 🔥 NEW PARAMS
    this.titleFontSize,
    this.titleFontWeight,
    this.titleColor,
  });

  final String? hintText;
  final Widget? prefix;
  final Widget? suffixIcon;
  final bool isPassWord;
  final bool isEmail;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final double elevation;
  final Color? elevationColor;
  final int minLines;
  final bool readOnly;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final int? maxLines;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool isPassWordSecondValidation;
  final bool isOptional;
  final TextEditingController? isPassWordSecondValidationController;
  final String? title;
  final String? Function(String?)? validator;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final TextAlignVertical? textAlignVertical;
  final bool filled;
  final Color? borderColor;

  /// 🔥 NEW PARAMS
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final Color? titleColor;

  @override
  State<AppInputWidgetTwo> createState() => _AppInputWidgetTwoState();
}

class _AppInputWidgetTwoState extends State<AppInputWidgetTwo> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ===============================
        /// TITLE
        /// ===============================
        if (widget.title != null) ...[
          RichText(
            text: TextSpan(
              text: widget.title,
              style: GoogleFonts.openSans(
                fontSize: widget.titleFontSize ?? 14.sp,
                fontWeight: widget.titleFontWeight ?? FontWeight.w600,
                color: widget.titleColor ?? Colors.black,
              ),
              children: widget.isOptional
                  ? [
                      TextSpan(
                        text: " (Optional)",
                        style: GoogleFonts.openSans(
                          fontSize: (widget.titleFontSize ?? 14.sp) - 1,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ]
                  : [],
            ),
          ),
          SizedBox(height: 8.h),
        ],

        /// ===============================
        /// TEXT FIELD
        /// ===============================
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassWord ? obscureText : false,
          keyboardType: widget.isEmail
              ? TextInputType.emailAddress
              : widget.keyboardType,
          textInputAction: widget.textInputAction,
          minLines: widget.minLines,
          maxLines: widget.maxLines ?? 1,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.validator,
          textAlignVertical: widget.textAlignVertical,
          style:
              widget.style ??
              GoogleFonts.openSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: widget.filled,
            fillColor: widget.fillColor ?? Colors.white,
            contentPadding: widget.contentPadding ?? EdgeInsets.all(12.r),
            border: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8.r),
              borderSide: BorderSide(color: widget.borderColor ?? Colors.blue),
            ),
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffixIcon,
            prefixIconConstraints: widget.prefixIconConstraints,
            suffixIconConstraints: widget.suffixIconConstraints,
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AppInputWidgetTwo extends StatefulWidget {
//   const AppInputWidgetTwo({
//     super.key,
//     this.hintText,
//     this.prefix,
//     this.suffixIcon,
//     this.isPassWord = false,
//     this.isEmail = false,
//     this.textInputAction = TextInputAction.next,
//     this.controller,
//     this.keyboardType,
//     this.fillColor,
//     this.elevation = 0.0,
//     this.elevationColor,
//     this.minLines = 1,
//     this.readOnly = false,
//     this.borderRadius,
//     this.contentPadding,
//     this.style,
//     this.maxLines,
//     this.onFieldSubmitted,
//     this.onTap,
//     this.onChanged,
//     this.isPassWordSecondValidation = false,
//     this.isOptional = false,
//     this.isPassWordSecondValidationController,
//     this.title,
//     this.validator,
//     this.prefixIconConstraints,
//     this.suffixIconConstraints,
//     this.textAlignVertical,
//     this.filled = true,
//     this.borderColor,

//     /// ✅ NEW PARAMS
//     this.isDescription = false,
//     this.height,
//   });

//   final String? hintText;
//   final Widget? prefix;
//   final Widget? suffixIcon;
//   final bool isPassWord;
//   final bool readOnly;
//   final bool isEmail;
//   final TextInputAction? textInputAction;
//   final TextEditingController? controller;
//   final TextInputType? keyboardType;
//   final Color? fillColor;
//   final bool filled;
//   final double elevation;
//   final Color? elevationColor;
//   final int minLines;
//   final int? maxLines;
//   final double? borderRadius;
//   final EdgeInsetsGeometry? contentPadding;
//   final TextStyle? style;
//   final BoxConstraints? prefixIconConstraints;
//   final BoxConstraints? suffixIconConstraints;
//   final void Function(String)? onFieldSubmitted;
//   final void Function()? onTap;
//   final void Function(String)? onChanged;
//   final TextAlignVertical? textAlignVertical;
//   final bool isPassWordSecondValidation;
//   final bool isOptional;
//   final TextEditingController? isPassWordSecondValidationController;
//   final String? title;
//   final FormFieldValidator<String>? validator;
//   final Color? borderColor;

//   /// ✅ NEW
//   final bool isDescription;
//   final double? height;

//   @override
//   State<AppInputWidgetTwo> createState() => _AppInputWidgetTwoState();
// }

// class _AppInputWidgetTwoState extends State<AppInputWidgetTwo> {
//   bool isShowPassWord = true;

//   @override
//   Widget build(BuildContext context) {
//     final Color effectiveBorderColor = widget.borderColor ?? Colors.black;

//     /// ✅ Height Logic
//     final double? effectiveHeight =
//         widget.height ?? (widget.isDescription ? 88.h : null);

//     return Material(
//       elevation: widget.elevation,
//       shadowColor: widget.elevationColor,
//       borderOnForeground: false,
//       color: Colors.transparent,
//       borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (widget.title != null)
//             Row(
//               children: [
//                 Text(
//                   widget.title!,
//                   style: GoogleFonts.jost().copyWith(
//                     fontSize: 14.sp,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 if (!widget.isOptional)
//                   Text(
//                     ' *',
//                     style: GoogleFonts.jost().copyWith(
//                       color: Colors.red,
//                       fontSize: 14.sp,
//                     ),
//                   ),
//               ],
//             ),
//           const SizedBox(height: 8),

//           /// 🔹 Height Wrapper
//           SizedBox(
//             height: effectiveHeight,
//             child: TextFormField(
//               cursorColor: effectiveBorderColor,
//               onChanged: widget.onChanged,
//               onTap: widget.onTap,
//               onFieldSubmitted: widget.onFieldSubmitted,
//               readOnly: widget.readOnly,
//               controller: widget.controller,
//               minLines: widget.isDescription ? 3 : widget.minLines,
//               maxLines: widget.isDescription ? null : widget.maxLines ?? 1,
//               validator: widget.validator,
//               keyboardType: widget.isEmail
//                   ? TextInputType.emailAddress
//                   : widget.keyboardType,
//               textInputAction: widget.textInputAction,
//               obscureText: widget.isPassWord && isShowPassWord,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               obscuringCharacter: "*",
//               textAlignVertical:
//                   widget.textAlignVertical ?? TextAlignVertical.center,
//               style:
//                   widget.style ??
//                   GoogleFonts.jost().copyWith(
//                     height: 1.5,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black,
//                   ),
//               decoration: InputDecoration(
//                 hintText: widget.hintText,
//                 hintStyle: GoogleFonts.jost().copyWith(
//                   fontSize: 14.sp,
//                   color: Colors.black.withOpacity(.4),
//                 ),
//                 filled: widget.filled,
//                 fillColor: widget.fillColor ?? Colors.white,
//                 contentPadding:
//                     widget.contentPadding ??
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 12),

//                 prefixIcon: widget.prefix != null
//                     ? Padding(
//                         padding: const EdgeInsets.only(left: 8.0),
//                         child: widget.prefix,
//                       )
//                     : null,

//                 suffixIcon: widget.isPassWord
//                     ? IconButton(
//                         color: effectiveBorderColor,
//                         padding: EdgeInsets.zero,
//                         iconSize: 18,
//                         onPressed: () {
//                           setState(() {
//                             isShowPassWord = !isShowPassWord;
//                           });
//                         },
//                         icon: isShowPassWord
//                             ? const Icon(Icons.visibility)
//                             : const Icon(Icons.visibility_off),
//                       )
//                     : widget.suffixIcon,

//                 prefixIconConstraints:
//                     widget.prefixIconConstraints ??
//                     const BoxConstraints(maxWidth: 40, maxHeight: 40),
//                 suffixIconConstraints:
//                     widget.suffixIconConstraints ??
//                     const BoxConstraints(maxWidth: 40, maxHeight: 40),

//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(color: effectiveBorderColor),
//                   borderRadius: BorderRadius.circular(
//                     widget.borderRadius ?? 12,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: effectiveBorderColor),
//                   borderRadius: BorderRadius.circular(
//                     widget.borderRadius ?? 12,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: effectiveBorderColor,
//                     width: 1.5,
//                   ),
//                   borderRadius: BorderRadius.circular(
//                     widget.borderRadius ?? 12,
//                   ),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.red),
//                   borderRadius: BorderRadius.circular(
//                     widget.borderRadius ?? 12,
//                   ),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.red),
//                   borderRadius: BorderRadius.circular(
//                     widget.borderRadius ?? 12,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // class AppInputWidgetTwo extends StatefulWidget {
// //   const AppInputWidgetTwo({
// //     super.key,
// //     this.hintText,
// //     this.prefix,
// //     this.suffixIcon,
// //     this.isPassWord = false,
// //     this.isEmail = false,
// //     this.textInputAction = TextInputAction.next,
// //     this.controller,
// //     this.keyboardType,
// //     this.fillColor,
// //     this.elevation = 0.0,
// //     this.elevationColor,
// //     this.minLines = 1,
// //     this.readOnly = false,
// //     this.borderRadius,
// //     this.contentPadding,
// //     this.style,
// //     this.maxLines,
// //     this.onFieldSubmitted,
// //     this.onTap,
// //     this.onChanged,
// //     this.isPassWordSecondValidation = false,
// //     this.isOptional = false,
// //     this.isPassWordSecondValidationController,
// //     this.title,
// //     this.validator,
// //     this.prefixIconConstraints,
// //     this.suffixIconConstraints,
// //     this.textAlignVertical,
// //     this.filled = true,
// //     this.borderColor, // ✅ New Parameter
// //   });

// //   final String? hintText;
// //   final Widget? prefix;
// //   final Widget? suffixIcon;
// //   final bool isPassWord;
// //   final bool readOnly;
// //   final bool isEmail;
// //   final TextInputAction? textInputAction;
// //   final TextEditingController? controller;
// //   final TextInputType? keyboardType;
// //   final Color? fillColor;
// //   final bool filled;
// //   final double elevation;
// //   final Color? elevationColor;
// //   final int minLines;
// //   final int? maxLines;
// //   final double? borderRadius;
// //   final EdgeInsetsGeometry? contentPadding;
// //   final TextStyle? style;
// //   final BoxConstraints? prefixIconConstraints;
// //   final BoxConstraints? suffixIconConstraints;
// //   final void Function(String)? onFieldSubmitted;
// //   final void Function()? onTap;
// //   final void Function(String)? onChanged;
// //   final TextAlignVertical? textAlignVertical;
// //   final bool isPassWordSecondValidation;
// //   final bool isOptional;
// //   final TextEditingController? isPassWordSecondValidationController;
// //   final String? title;
// //   final FormFieldValidator<String>? validator;
// //   final Color? borderColor; // ✅ Added

// //   @override
// //   State<AppInputWidgetTwo> createState() => _AppInputWidgetTwoState();
// // }

// // class _AppInputWidgetTwoState extends State<AppInputWidgetTwo> {
// //   bool isShowPassWord = true;

// //   @override
// //   Widget build(BuildContext context) {
// //     final Color effectiveBorderColor = widget.borderColor ?? Colors.black;

// //     return Material(
// //       elevation: widget.elevation,
// //       shadowColor: widget.elevationColor,
// //       borderOnForeground: false,
// //       color: Colors.transparent,
// //       borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           if (widget.title != null)
// //             Row(
// //               children: [
// //                 Text(
// //                   widget.title!,
// //                   style: GoogleFonts.jost().copyWith(
// //                     fontSize: 14.sp,
// //                     color: Colors.black,
// //                     fontWeight: FontWeight.w500,
// //                   ),
// //                 ),
// //                 if (!widget.isOptional)
// //                   Text(
// //                     ' *',
// //                     style: GoogleFonts.jost().copyWith(
// //                       color: Colors.red,
// //                       fontSize: 14.sp,
// //                     ),
// //                   ),
// //               ],
// //             ),
// //           const SizedBox(height: 8),

// //           /// 🔹 Text Field
// //           TextFormField(
// //             cursorColor: effectiveBorderColor,
// //             onChanged: widget.onChanged,
// //             onTap: widget.onTap,
// //             onFieldSubmitted: widget.onFieldSubmitted,
// //             readOnly: widget.readOnly,
// //             controller: widget.controller,
// //             minLines: widget.minLines,
// //             maxLines: widget.maxLines ?? 1,
// //             validator: widget.validator,
// //             keyboardType: widget.isEmail
// //                 ? TextInputType.emailAddress
// //                 : widget.keyboardType,
// //             textInputAction: widget.textInputAction,
// //             obscureText: widget.isPassWord && isShowPassWord,
// //             autovalidateMode: AutovalidateMode.onUserInteraction,
// //             obscuringCharacter: "*",
// //             textAlignVertical:
// //                 widget.textAlignVertical ?? TextAlignVertical.center,
// //             style:
// //                 widget.style ??
// //                 GoogleFonts.jost().copyWith(
// //                   height: 1.5,
// //                   fontWeight: FontWeight.w400,
// //                   color: Colors.black,
// //                 ),
// //             decoration: InputDecoration(
// //               hintText: widget.hintText,
// //               hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
// //                 color: Colors.black.withOpacity(.4),
// //               ),
// //               filled: widget.filled,
// //               fillColor: widget.fillColor ?? Colors.white,
// //               contentPadding:
// //                   widget.contentPadding ??
// //                   const EdgeInsets.symmetric(vertical: 12, horizontal: 12),

// //               /// 🔹 Prefix
// //               prefixIcon: widget.prefix != null
// //                   ? Padding(
// //                       padding: const EdgeInsets.only(left: 8.0),
// //                       child: widget.prefix,
// //                     )
// //                   : null,

// //               /// 🔹 Suffix / Password Toggle
// //               suffixIcon: widget.isPassWord
// //                   ? IconButton(
// //                       color: effectiveBorderColor,
// //                       padding: EdgeInsets.zero,
// //                       iconSize: 18,
// //                       onPressed: () {
// //                         setState(() {
// //                           isShowPassWord = !isShowPassWord;
// //                         });
// //                       },
// //                       icon: isShowPassWord
// //                           ? const Icon(Icons.visibility)
// //                           : const Icon(Icons.visibility_off),
// //                     )
// //                   : widget.suffixIcon,

// //               prefixIconConstraints:
// //                   widget.prefixIconConstraints ??
// //                   const BoxConstraints(maxWidth: 40, maxHeight: 40),
// //               suffixIconConstraints:
// //                   widget.suffixIconConstraints ??
// //                   const BoxConstraints(maxWidth: 40, maxHeight: 40),

// //               /// 🔹 Borders
// //               border: OutlineInputBorder(
// //                 borderSide: BorderSide(color: effectiveBorderColor),
// //                 borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
// //               ),
// //               enabledBorder: OutlineInputBorder(
// //                 borderSide: BorderSide(color: effectiveBorderColor),
// //                 borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
// //               ),
// //               focusedBorder: OutlineInputBorder(
// //                 borderSide: BorderSide(color: effectiveBorderColor, width: 1.5),
// //                 borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
// //               ),
// //               errorBorder: OutlineInputBorder(
// //                 borderSide: const BorderSide(color: Colors.red),
// //                 borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
// //               ),
// //               focusedErrorBorder: OutlineInputBorder(
// //                 borderSide: const BorderSide(color: Colors.red),
// //                 borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
