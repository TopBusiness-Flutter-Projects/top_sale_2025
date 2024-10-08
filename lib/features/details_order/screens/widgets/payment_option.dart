import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_sale/core/utils/app_fonts.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({Key? key}) : super(key: key);

  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  String? selectedOption = 'آجل'; // Default selected value

  @override
  Widget build(BuildContext context) {
    // List of payment options
    final List<String> paymentMethods = ['آجل', 'كاش', 'بنك'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paymentMethods.map((method) {
        return CustomRadioTile(
          title: method,
          isSelected: selectedOption == method,
          onSelect: () {
            setState(() {
              selectedOption = method;
            });
            selectedOption=="آجل"?
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Container(color:Colors.red)),
            ):     Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Container(color:Colors.pink))    );
            },
        );
      }).toList(),
    );
  }
}

// Custom Widget for Radio Tile
class CustomRadioTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onSelect;

  const CustomRadioTile({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Row(
        children: [
          // Custom circular checkbox/radio button
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.orange : Colors.orange.shade300,
                width: 2.0,
              ),
            ),
            child: isSelected
                ? Center(
              child: Container(
                height: 12,
                width: 12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
              ),
            )
                : null,
          ),
          const SizedBox(width: 12),
          // Option label text
          Text(
            title,
            style: getBoldStyle()
            // TextStyle(
            //   fontSize: 16,
            //   fontWeight: FontWeight.w500,
            //   color: Colors.black,
            // ),
          ),
        ],
      ),
    );
  }
}