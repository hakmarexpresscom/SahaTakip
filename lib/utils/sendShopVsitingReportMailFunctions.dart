import 'dart:io';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/constants.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

Future<void> sendReport(int grup, List<String> recipients) async {

  String subject = "${box.get("currentShopID")} ${box.get("currentShopName")} Ziyaret Raporu";

  List<String> attachments = [];

  if (boxshopVisitingPhoto.get("beforePhoto") != null) {
    final resizedBeforePhoto = await resizeAndCompressImage(boxshopVisitingPhoto.get("beforePhoto"), 800);
    if (resizedBeforePhoto != null) attachments.add(resizedBeforePhoto.path);
  }

  if (boxshopVisitingPhoto.get("afterPhoto") != null) {
    final resizedAfterPhoto = await resizeAndCompressImage(boxshopVisitingPhoto.get("afterPhoto"), 800);
    if (resizedAfterPhoto != null) attachments.add(resizedAfterPhoto.path);
  }

  if(grup == 1){
    await sendReportToApi(
        recipients,
        subject,
        [boxShopVisitingForms.get("manavShopFormList")],
        attachments,
        box.get("userFullName"),
        box.get("visitingStartTime").toString(),
        box.get("visitingFinishTime").toString()
    );
  }

  else if(grup == 2){
    await sendReportToApi(
        recipients,
        subject,
        [
          boxShopVisitingForms.get("breadGroupFormList"),
          boxShopVisitingForms.get("frozenGroupFormList"),
          boxShopVisitingForms.get("tatbakGroupFormList")
        ],
        attachments,
        box.get("userFullName"),
        box.get("visitingStartTime").toString(),
        box.get("visitingFinishTime").toString()
    );
  }
}

//-------------------------------------

String formatFormToHTML(Map<String, int> form) {
  StringBuffer formListBuffer = StringBuffer();
  formListBuffer.write("<ul>");
  form.forEach((question, answer) {
    formListBuffer.write("<li>$question: ${answer == 0 ? 'Hayır' : 'Evet'}</li>");
  });
  formListBuffer.write("</ul>");
  return formListBuffer.toString();
}

//-------------------------------------

Future<File?> resizeAndCompressImage(String filePath, int width) async {
  try {

    final originalImageFile = File(filePath);
    final originalImageBytes = await originalImageFile.readAsBytes();
    final originalImage = img.decodeImage(originalImageBytes);

    if (originalImage == null) return null;

    final resizedImage = img.copyResize(originalImage, width: width);

    final compressedImageBytes = img.encodeJpg(resizedImage, quality: 70);

    final tempDir = await getTemporaryDirectory();
    final compressedImagePath = '${tempDir.path}/compressed_${originalImageFile.path.split('/').last}';
    final compressedImageFile = File(compressedImagePath);
    await compressedImageFile.writeAsBytes(compressedImageBytes);

    return compressedImageFile;
  } catch (e) {
    print("Error resizing and compressing image: $e");
    return null;
  }
}

//-------------------------------------

Future<void> sendReportToApi(List<String> recipients, String subject, List<String> formattedFormHTMLList, List<String> attachments, String userName, String time1, String time2) async {
  StringBuffer completeHTMLContent = StringBuffer();
  formattedFormHTMLList.forEach((htmlContent) {
    completeHTMLContent.write(htmlContent);
  });

  List<Map<String, String>> base64Attachments = [];
  for (var filePath in attachments) {
    final bytes = await File(filePath).readAsBytes();
    base64Attachments.add({
      'filename': filePath.split('/').last,
      'content': base64Encode(bytes),
      'type': 'image/jpeg', // veya uygun MIME tipi
    });
  }

  DateTime now = DateTime.now();
  String formattedDate = "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}";

  var url = Uri.parse('${constUrl}api/email/send-report');
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'recipients': recipients,
      'subject': subject,
      'htmlContent': "<p>Yollanmış olan mailde $userName kişisinin $formattedDate tarihli mağaza ziyareti sırasında doldurulmuş formların sonuçlarını "
          "ve uygulamaya yüklenmiş olan ziyaret fotoğraflarını bulabilirsiniz. Ziyaret başlangıç saati: $userName, Ziyaret bitiş saati: $time2</p>"
          + completeHTMLContent.toString(),
      'attachments': base64Attachments,
    }),
  );

  if (response.statusCode == 200) {
    print('Mail sent successfully');
  } else {
    print('Failed to send mail: ${response.statusCode}');
    print('Response body: ${response.body}'); // Sunucudan dönen hata mesajını görüntüleyin
  }
}



