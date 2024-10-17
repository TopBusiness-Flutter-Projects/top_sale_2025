import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:top_sale/core/preferences/preferences.dart';
import 'package:top_sale/core/utils/app_strings.dart'; // Import PdfPageFormat here

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({super.key, required this.baseUrl});
final String baseUrl;
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late Uint8List pdfBytes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPdfWithSession();
  }

  Future<void> fetchPdfWithSession() async {
  String? sessionId = await Preferences.instance.getSessionId();
    String odooUrl =
        await Preferences.instance.getOdooUrl() ?? AppStrings.demoBaseUrl;
 String cookie = 'session_id=$sessionId';
//  String cookie = 'session_id=6283d59dcd6abfa4a82380e5dedebf4398b1fe8c';
      // String cookie = loginResponse.headers['set-cookie'] ?? '';
      print("ccccc $cookie");

      // Step 3: Fetch the PDF using the session cookie
      final pdfResponse = await http.get(
        Uri.parse(
          odooUrl + widget.baseUrl),
        headers: {
          'Cookie': cookie, // Pass the session cookie
        },
      );
      if (pdfResponse.statusCode == 200) {
        setState(() {
          pdfBytes = pdfResponse.bodyBytes;
          isLoading = false;
        });
      } else {
        // Handle error
        print('Failed to load PDF');
      }

    // // Step 1: Authenticate with Odoo
    // final loginResponse = await http.post(
    //   Uri.parse(
    //       'https://novapolaris-stage-branche-15780489.dev.odoo.com/web/session/authenticate'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body:
    //       '{"params":{"db":"novapolaris-stage-branche-15780489","login":"master@gmail.com","password":"master"}}',
    // );

    // if (loginResponse.statusCode == 200) {
    //   // Step 2: Extract session cookies from the login response
    //   String cookie = 'session_id=6283d59dcd6abfa4a82380e5dedebf4398b1fe8c';
    //   // String cookie = loginResponse.headers['set-cookie'] ?? '';
    //   print("ccccc $cookie");

    //   // Step 3: Fetch the PDF using the session cookie
    //   final pdfResponse = await http.get(
    //     Uri.parse(
    //         'https://novapolaris-stage-branche-15780489.dev.odoo.com/report/pdf/stock.report_picking/41'),
    //     headers: {
    //       'Cookie': cookie, // Pass the session cookie
    //     },
    //   );
    //   if (pdfResponse.statusCode == 200) {
    //     setState(() {
    //       pdfBytes = pdfResponse.bodyBytes;
    //       isLoading = false;
    //     });
    //   } else {
    //     // Handle error
    //     print('Failed to load PDF');
    //   }
    // } else {
    //   // Handle login failure
    //   print('Failed to authenticate');
    // }
  }

  void printPdf() async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed:
                isLoading ? null : printPdf, // Disable the button while loading
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SfPdfViewer.memory(pdfBytes),
    );
  }
}
