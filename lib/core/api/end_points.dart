import 'package:top_sale/core/utils/app_strings.dart';

class EndPoints {
  //static const String baseUrl = "https://demo17.topbuziness.com";
  // static String baseUrl =  AppStrings.demoBaseUrl;
  // static String db = "demo17.topbuziness.com";

  ///
  static String auth = "/auth/";
  static String resUsers = "/api/res.users/";
  static String checkEmployee = '/api/hr.employee/';
  static String fleetLogs = '/api/fleet.vehicle.logs/';
  static String allCategoriesUrl =
      '/api/product.category?query={id,name,image}&filter=[["is_active", "=","true"]]';
  static String allProducts = '/api/product.product/';
  static String products = '/api/product/all_paginated';
  static String productSearch = '/api/product/search';
  static String getUserData = '/api/res.users/';
  static String getAllPartners = '/api/res.partner/';
  static String saleOrder = '/api/sale.order/';
  static String createPartner = '/api/partner/';
  static String partners = '/api/partners/';
  static String resPartner = '/api/res.partner/';
  static String objectSaleOrder = '/object/sale.order/';
  static String picking = '/api/picking/';
  static String createInvoice = '/api/sale_order/';
  static String invoice = '/api/invoice/';
  static String createQuotation = '/api/quotation/';
  static String returnedOrder = '/api/sale_order/returned_orders/';
  static String updateQuotation = '/api/quotation/update/';
  static String getAllJournals =
      '/api/account.journal/?query={id, display_name}';
  static String printOrder = '/report/pdf/sale.report_saleorder/';
  static String printPicking = '/report/pdf/stock.report_picking/';
  static String printPayment = '/report/pdf/account.report_payment_receipt/';
  static String printInvoice =
      '/report/pdf/account.report_invoice_with_payments/';
  static String printPaySlip = '/report/pdf/hr_payroll.report_payslip_lang/';
  static String wareHouse = '/api/stock.warehouse/';
  static String createPayment = '/api/payment/create';
  static String employee = '/api/employee/';
  static String expense = '/api/expense/products';
  static String returnPicking = '/api/return_picking/';
}
