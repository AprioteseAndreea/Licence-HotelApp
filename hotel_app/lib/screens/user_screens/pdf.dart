import 'dart:ui';
import 'package:first_app_flutter/models/extra_facility_model.dart';
import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/screens/services/facilities_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<void> createPDF(ReservationModel reservationModel) async {
  final PdfDocument document = PdfDocument();
  final PdfPage page = document.pages.add();
  final Size pageSize = page.getClientSize();
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(142, 170, 219, 255)));

  final PdfGrid grid = getGrid(reservationModel);
  final PdfLayoutResult? result =
      drawHeader(page, pageSize, grid, reservationModel);
  drawGrid(page, grid, result!, reservationModel);
  drawFooter(page, pageSize, reservationModel);
  List<int> bytes = document.save();
  final directory = await getApplicationDocumentsDirectory();

  final path = directory.path;

  final file = File('$path/Bill.pdf');
  await file.writeAsBytes(bytes, flush: true);

  OpenFile.open('$path/Bill.pdf');
}

double getFacilitiesPrice(List<String> facilities, int days) {
  FacilityService facilityService = FacilityService();
  double totalCost = 0;
  for (var f in facilityService.getFacilities()) {
    if (facilities.contains(f.facility)) {
      totalCost += int.parse(f.cost);
    }
  }
  return (totalCost * days);
}

double calculateVAT(int total) {
  return ((23 * total) / 100);
}

double calculateRoomsPrice(int total, facilitiesPrice) {
  return total - calculateVAT(total) - facilitiesPrice;
}

PdfGrid getGrid(ReservationModel reservationModel) {
  final PdfGrid grid = PdfGrid();

  DateTime checkIn = DateTime.parse(reservationModel.checkIn);
  DateTime checkOut = DateTime.parse(reservationModel.checkOut);

  int days = checkOut.difference(checkIn).inDays + 1;
  double facilitiesPrice =
      getFacilitiesPrice(reservationModel.facilities, days);
  grid.columns.add(count: 5);
  final PdfGridRow headerRow = grid.headers.add(1)[0];

  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;

  headerRow.cells[0].value = 'Product name';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Price';
  headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;

  addProducts('Facilities', facilitiesPrice, grid);
  addProducts('Rooms',
      calculateRoomsPrice(reservationModel.price, facilitiesPrice), grid);
  addProducts('VAT(23%)', calculateVAT(reservationModel.price), grid);

  grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
  grid.columns[1].width = 200;
  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.cellPadding =
        PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  }
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      if (j == 0) {
        cell.stringFormat.alignment = PdfTextAlignment.center;
      }
      cell.style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
  }
  return grid;
}

//Create row for the grid.
void addProducts(String productName, double price, PdfGrid grid) {
  PdfGridRow row = grid.rows.add();
  row.cells[0].value = productName;
  row.cells[1].value = price.toString();
}

PdfLayoutResult? drawHeader(PdfPage page, Size pageSize, PdfGrid grid,
    ReservationModel reservationModel) {
  page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(18, 69, 89, 255)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));

  page.graphics.drawString(
      'GRAND HOTEL', PdfStandardFont(PdfFontFamily.helvetica, 25),
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(350, 0, pageSize.width - 350, 90),
      brush: PdfSolidBrush(PdfColor(8, 52, 69)));

  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);

  page.graphics.drawString(Strings.street, contentFont,
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(350, 20, pageSize.width - 350, 30),
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.top));
  page.graphics.drawString(Strings.hotelPhone, contentFont,
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(350, 40, pageSize.width - 350, 30),
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.top));
  page.graphics.drawString(Strings.hotelEmail, contentFont,
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(350, 60, pageSize.width - 350, 30),
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.top));

  final DateFormat format = DateFormat.yMMMMd('en_US');
  final String invoiceNumber =
      'Invoice Number: ${reservationModel.id}\r\n\r\nDate: ${reservationModel.date}';
  final Size contentSize = contentFont.measureString(invoiceNumber);
  String address =
      'Bill To: \r\n\r\n Name: ${reservationModel.name}, \r\n\r\nE-mail: ${reservationModel.user} \r\n\r\n Check-in: ${reservationModel.checkIn}\r\n\r\n Check-out: ${reservationModel.checkOut}';

  PdfTextElement(text: invoiceNumber, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
          contentSize.width + 30, pageSize.height - 120));

  return PdfTextElement(text: address, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(30, 120, pageSize.width - (contentSize.width + 30),
          pageSize.height - 120));
}

void drawFooter(
    PdfPage page, Size pageSize, ReservationModel reservationModel) {
  final PdfPen linePen =
      PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
  linePen.dashPattern = <double>[3, 3];
  page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
      Offset(pageSize.width, pageSize.height - 100));

  const String footerContent =
      '800 Interchange Blvd.\r\n\r\nSuite 2501, Austin, TX 78721\r\n\r\nAny Questions? support@grand-hotel.com';

  page.graphics.drawString(
      footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
      format: PdfStringFormat(alignment: PdfTextAlignment.right),
      bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
}

void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result,
    ReservationModel reservationModel) {
  Rect totalPriceCellBounds = const Rect.fromLTWH(10, 10, 10, 10);
  Rect quantityCellBounds = const Rect.fromLTWH(10, 10, 10, 10);
  //Invoke the beginCellLayout event.
  grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
    final PdfGrid grid = sender as PdfGrid;
    if (args.cellIndex == grid.columns.count - 1) {
      totalPriceCellBounds = args.bounds;
    } else if (args.cellIndex == grid.columns.count - 2) {
      quantityCellBounds = args.bounds;
    }
  };
  //Draw the PDF grid and get the result.
  result = grid.draw(
      page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;

  //Draw grand total.
  page.graphics.drawString('Total',
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(quantityCellBounds.left, result.bounds.bottom + 10,
          quantityCellBounds.width, quantityCellBounds.height));
  page.graphics.drawString(reservationModel.price.toString(),
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(
          totalPriceCellBounds.left,
          result.bounds.bottom + 10,
          totalPriceCellBounds.width,
          totalPriceCellBounds.height));
}
