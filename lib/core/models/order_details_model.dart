// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  int? id;
  dynamic name;
  dynamic dateOrder;
  dynamic amountTotal;
  dynamic state;
  dynamic currencyId;
  dynamic partnerName;
  List<Line>? orderLines;
  List<Invoice>? invoices;
  List<Picking>? pickings;
  List<dynamic>? payments;
  OrderDetailsModel({
    this.id,
    this.name,
    this.dateOrder,
    this.amountTotal,
    this.state,
    this.currencyId,
    this.partnerName,
    this.orderLines,
    this.invoices,
    this.pickings,
    this.payments,
  });
  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        id: json["id"],
        name: json["name"],
        dateOrder: json["date_order"],
        amountTotal: json["amount_total"],
        state: json["state"],
        currencyId: json["currency_id"],
        partnerName: json["partner_name"],
        orderLines: json["order_lines"] == null
            ? []
            : List<Line>.from(
                json["order_lines"]!.map((x) => Line.fromJson(x))),
        invoices: json["invoices"] == null
            ? []
            : List<Invoice>.from(
                json["invoices"]!.map((x) => Invoice.fromJson(x))),
        pickings: json["pickings"] == null
            ? []
            : List<Picking>.from(
                json["pickings"]!.map((x) => Picking.fromJson(x))),
        payments: json["payments"] == null
            ? []
            : List<dynamic>.from(json["payments"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date_order": dateOrder?.toIso8601String(),
        "amount_total": amountTotal,
        "state": state,
        "currency_id": currencyId,
        "partner_name": partnerName,
        "order_lines": orderLines == null
            ? []
            : List<dynamic>.from(orderLines!.map((x) => x.toJson())),
        "invoices": invoices == null
            ? []
            : List<dynamic>.from(invoices!.map((x) => x.toJson())),
        "pickings": pickings == null
            ? []
            : List<dynamic>.from(pickings!.map((x) => x.toJson())),
        "payments":
            payments == null ? [] : List<dynamic>.from(payments!.map((x) => x)),
      };
}

class Invoice {
  int? invoiceId;
  dynamic name;
  dynamic state;
  dynamic amountTotal;
  dynamic currency;
  dynamic invoiceDate;
  List<Line>? invoiceLines;

  Invoice({
    this.invoiceId,
    this.name,
    this.state,
    this.amountTotal,
    this.currency,
    this.invoiceDate,
    this.invoiceLines,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        invoiceId: json["invoice_id"],
        name: json["name"],
        state: json["state"],
        amountTotal: json["amount_total"],
        currency: json["currency"],
        invoiceDate: json["invoice_date"] == null
            ? null
            : DateTime.parse(json["invoice_date"]),
        invoiceLines: json["invoice_lines"] == null
            ? []
            : List<Line>.from(
                json["invoice_lines"]!.map((x) => Line.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "invoice_id": invoiceId,
        "name": name,
        "state": state,
        "amount_total": amountTotal,
        "currency": currency,
        "invoice_date":
            "${invoiceDate!.year.toString().padLeft(4, '0')}-${invoiceDate!.month.toString().padLeft(2, '0')}-${invoiceDate!.day.toString().padLeft(2, '0')}",
        "invoice_lines": invoiceLines == null
            ? []
            : List<dynamic>.from(invoiceLines!.map((x) => x.toJson())),
      };
}

class Line {
  int? id;
  dynamic productId;
  dynamic quantity;
  dynamic priceUnit;
  dynamic discount;
  dynamic priceSubtotal;
  List<dynamic>? taxes;
  dynamic productUomQty;

  Line({
    this.id,
    this.productId,
    this.quantity,
    this.priceUnit,
    this.discount,
    this.priceSubtotal,
    this.taxes,
    this.productUomQty,
  });

  factory Line.fromJson(Map<String, dynamic> json) => Line(
        id: json["id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        priceUnit: json["price_unit"],
        discount: json["discount"],
        priceSubtotal: json["price_subtotal"],
        taxes: json["taxes"] == null
            ? []
            : List<dynamic>.from(json["taxes"]!.map((x) => x)),
        productUomQty: json["product_uom_qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "quantity": quantity,
        "price_unit": priceUnit,
        "discount": discount,
        "price_subtotal": priceSubtotal,
        "taxes": taxes == null ? [] : List<dynamic>.from(taxes!.map((x) => x)),
        "product_uom_qty": productUomQty,
      };
}

class Picking {
  int? pickingId;
  dynamic name;
  dynamic state;
  dynamic scheduledDate;
  dynamic dateDone;
  List<PickingLine>? pickingLines;

  Picking({
    this.pickingId,
    this.name,
    this.state,
    this.scheduledDate,
    this.dateDone,
    this.pickingLines,
  });

  factory Picking.fromJson(Map<String, dynamic> json) => Picking(
        pickingId: json["picking_id"],
        name: json["name"],
        state: json["state"],
        scheduledDate: json["scheduled_date"],
        dateDone: json["date_done"] == null
            ? null
            : DateTime.parse(json["date_done"]),
        pickingLines: json["picking_lines"] == null
            ? []
            : List<PickingLine>.from(
                json["picking_lines"]!.map((x) => PickingLine.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "picking_id": pickingId,
        "name": name,
        "state": state,
        "scheduled_date": scheduledDate?.toIso8601String(),
        "date_done": dateDone?.toIso8601String(),
        "picking_lines": pickingLines == null
            ? []
            : List<dynamic>.from(pickingLines!.map((x) => x.toJson())),
      };
}

class PickingLine {
  int? moveId;
  dynamic productId;
  dynamic demand;
  dynamic quantity;
  dynamic locationId;
  dynamic locationDestId;

  PickingLine({
    this.moveId,
    this.productId,
    this.demand,
    this.quantity,
    this.locationId,
    this.locationDestId,
  });

  factory PickingLine.fromJson(Map<String, dynamic> json) => PickingLine(
        moveId: json["move_id"],
        productId: json["product_id"],
        demand: json["demand"],
        quantity: json["quantity"],
        locationId: json["location_id"],
        locationDestId: json["location_dest_id"],
      );

  Map<String, dynamic> toJson() => {
        "move_id": moveId,
        "product_id": productId,
        "demand": demand,
        "quantity": quantity,
        "location_id": locationId,
        "location_dest_id": locationDestId,
      };
}
