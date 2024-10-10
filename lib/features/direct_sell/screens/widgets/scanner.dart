import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:top_sale/core/widgets/custom_text_form_field.dart';

import '../../../../core/utils/app_colors.dart';

class CustomSearchWidget extends StatefulWidget {
  const CustomSearchWidget({super.key});

  @override
  State<CustomSearchWidget> createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  String barcode = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: CustomTextField(
                onChanged: (keyValue) {
                  if (keyValue.isEmpty) {
                    // cubit.getAllProducts();
                  } else {
                    // EasyDebounce.debounce(
                    //     'search', // <-- An ID for this particular debouncer
                    //     Duration(
                    //         seconds: 1), // <-- The debounce duration
                    //     () => cubit.searchProducts(
                    //           productName: keyValue,
                    //         ) // <-- The target method
                    //     );
                  }
                },
                labelText: "search_product".tr(),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 35,
                  color: AppColors.gray2,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () async {
                  String? scannedValue = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AiBarcodeScanner(
                        onScan: (p0) {},
                        onDispose: () {
                          debugPrint("Barcode scanner disposed!");
                        },
                        controller: MobileScannerController(
                          detectionSpeed: DetectionSpeed.noDuplicates,
                        ),
                        onDetect: (BarcodeCapture capture) {
                          String? scannedValue =
                              capture.barcodes.first.rawValue;
                          debugPrint("Barcode scanned: $scannedValue");
                          // cubit.searchProducts(
                          //     productName: scannedValue.toString(),
                          //     isBarcode: true);
                          setState(() {
                            barcode = scannedValue!;
                            print("llll ${barcode}");
                          });
                          // successGetBar(scannedValue);
                          // Update the barcode value and pop back to the previous screen
                        },
                      ),
                    ),
                  );

                  // If a barcode was scanned, update the UI
                  if (scannedValue != null) {
                    setState(() {
                      barcode = scannedValue;
                      print("llll ${barcode}");
                    });
                  }
                },
                child: Scanner()),
            SizedBox(
              width: 8,
            )
          ],
        ),
        if (barcode.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                barcode,
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    //  cubit.getAllProducts();
                    barcode = "";
                  });
                },
                child: Icon(
                  Icons.close_rounded,
                  color: AppColors.white,
                  size: 30,
                ),
              )
            ],
          ),
      ],
    );
  }
}

class Scanner extends StatelessWidget {
  const Scanner({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.secondPrimary,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Icon(
          Icons.document_scanner_outlined,
          color: AppColors.white,
          size: 30,
        ),
      ),
    );
  }
}
