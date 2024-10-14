import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/models/all_journals_model.dart';
import 'package:top_sale/core/utils/app_fonts.dart';
import 'package:top_sale/features/details_order/screens/widgets/rounded_button.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/get_size.dart';
import '../../../login/widget/textfield_with_text.dart';
import '../../cubit/delevery_orders_cubit.dart';
import '../../cubit/delevery_orders_state.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({super.key});

  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  String? selectedOption;

  @override
  void initState() {
    context.read<DetailsOrdersCubit>().getAllJournals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<DetailsOrdersCubit>();
    final List<Result>? paymentMethods = cubit.getAllJournalsModel?.result;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Adding the 'آجل' option
        RadioListTile<String>(
          title: Text('آجل', style: getBoldStyle()), // Option for "آجل"
          value: 'آجل',
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value;
            });
            if (selectedOption == 'آجل') {
              // Perform action when "آجل" is selected
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(title: const Text('آجل')),
                    body: const Center(child: Text('لقد اخترت الدفع الآجل')),
                  ),
                ),
              );
            }
          },
        ),

        // List of other payment methods
        if (paymentMethods != null && paymentMethods.isNotEmpty)
          ...paymentMethods.map((method) {
            return BlocBuilder<DetailsOrdersCubit, DetailsOrdersState>(
              builder: (context, state) {
                return (cubit.getAllJournalsModel?.result?.length == 0)?
                CircularProgressIndicator(
                  color: AppColors.primaryColor,):
                RadioListTile<String>(
                  title: Text(method.displayName!, style: getBoldStyle()), // Display payment method name
                  value: method.displayName!,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                    if (selectedOption != 'آجل') {

                      _showBottomSheet(context, cubit,value);


                    }
                  },
                );
              },
            );
          })
        else
          const Center(child: Text("No payment methods available")),
      ],
    );
  }
}
void _showBottomSheet(BuildContext context, DetailsOrdersCubit cubit,String ? value) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(getSize(context) / 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("اجمالى الفاتورة :  60 ج",style: TextStyle(fontSize: getSize(context) / 20),),
              CustomTextFieldWithTitle(
                title: "Paid_in_full".tr(),
                controller: cubit.moneyController,
                hint: "Enter_the_amount".tr(),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: getSize(context) / 30,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: getSize(context) / 20,
                    right: getSize(context) / 20),
                child: RoundedButton(
                  backgroundColor: AppColors.primaryColor,
                  text: 'confirm'.tr(),
                  onPressed: () {
                    cubit.createAndValidateInvoice(
                        orderId: cubit.getDetailsOrdersModel?.id ?? -1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(title:  Text(value!)),
                          body:  Center(child: Text('لقد اخترت الدفع ${value!}')),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
