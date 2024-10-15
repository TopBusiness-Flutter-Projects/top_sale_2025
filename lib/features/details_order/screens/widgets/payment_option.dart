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
    return BlocBuilder<DetailsOrdersCubit, DetailsOrdersState>(
      builder: (context, state) {
        if (state is GetAllJournalsLoadingState) {
          // Show a single CircularProgressIndicator for loading state
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        // After loading, display the list of payment methods
        final List<Result>? paymentMethods = cubit.getAllJournalsModel?.result;

        if (paymentMethods != null && paymentMethods.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: paymentMethods.map((method) {
              return RadioListTile<String>(
                title: Text(method.displayName!, style: getBoldStyle()), // Display payment method name
                value: method.displayName!,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                  if (selectedOption != null) {
                    _showBottomSheet(context, cubit, value);
                  }
                },
              );
            }).toList(),
          );
        } else {
          return const Center(child: Text("No payment methods available"));
        }
      },
    );
  }
}

void _showBottomSheet(BuildContext context, DetailsOrdersCubit cubit, String? value) {
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
              Text("اجمالى الفاتورة :  ${cubit.getDetailsOrdersModel?.amountTotal ?? 0} ج", style: TextStyle(fontSize: getSize(context) / 20)),
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
                padding: EdgeInsets.only(left: getSize(context) / 20, right: getSize(context) / 20),
                child: RoundedButton(
                  backgroundColor: AppColors.primaryColor,
                  text: 'confirm'.tr(),
                  onPressed: () {

                    cubit.registerPayment(context,
                      orderId:  cubit.getDetailsOrdersModel?.id ?? -1,
                        journalId: cubit.getAllJournalsModel?.result?.first.id ?? -1,
                        invoiceId: cubit.getDetailsOrdersModel?.invoices?.first.invoiceId ?? -1,);

                    print("///////////////////////// ${cubit.getDetailsOrdersModel?.id}");


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
