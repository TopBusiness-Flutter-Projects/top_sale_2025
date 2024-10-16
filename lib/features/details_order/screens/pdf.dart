import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:top_sale/core/preferences/preferences.dart';
import 'package:top_sale/features/details_order/cubit/details_orders_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/utils/get_size.dart';
import '../cubit/details_orders_state.dart';

class PaymentWebViewScreen extends StatefulWidget {
  const PaymentWebViewScreen({super.key, this.url});
  final String? url;
  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  String? sessionId;
  @override
  void initState() {
    getSession();
    super.initState();
    _controller.clearCache();
// CookieManager().clearCookies();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            // Navigator.pop(context);
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          }))
      ..loadRequest(
        Uri.parse(widget.url ?? 'https://flutter.dev'),
        // headers: {
        //   'session_id': "354afcce1c8dcf780d593eae28b36195c3f4ce1e", // Add your session ID here
        // },
        headers: {
          "Cookie": "session_id=354afcce1c8dcf780d593eae28b36195c3f4ce1e"
        },
      );
  }

  getSession() async {
    setState(() async {
      sessionId = await Preferences.instance.getSessionId();
    });
    // sessionId = await Preferences.instance.getSessionId();
    print("ssssss $sessionId");
  }

  @override
  Widget build(BuildContext context) {
    // OrdersCubit cubit = context.read<OrdersCubit>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'payment'.tr(),
            style: TextStyle(
              fontSize: getSize(context) / 32,
            ),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<DetailsOrdersCubit, DetailsOrdersState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SfPdfViewer.network(
                    'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                    canShowPaginationDialog: true,
                    pageLayoutMode: PdfPageLayoutMode.continuous,
                  ),
                );
                // return WebViewWidget(controller: _controller);
              }),
        )));
  }
}
