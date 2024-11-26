import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow overflow; // Yeni özellik
  final bool softWrap; // Yeni özellik
  final int? maxLines; // Opsiyonel, metin için satır sınırı

  const TextWidget({
    Key? key,
    required this.text,
    required this.size,
    required this.fontWeight,
    required this.color,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.visible, // Varsayılan değer
    this.softWrap = true, // Varsayılan olarak sarma açık
    this.maxLines, // Varsayılan olarak sınırsız satır
  }) : super(key: key);

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: widget.size,
        fontWeight: widget.fontWeight,
        color: widget.color,
      ),
      textAlign: widget.textAlign, // Varsayılan hizalama: sola
      overflow: widget.overflow, // Metnin taşma davranışı
      softWrap: widget.softWrap, // Metnin sarılmasını kontrol eder
      maxLines: widget.maxLines, // Metin için maksimum satır sayısı
    );
  }
}
