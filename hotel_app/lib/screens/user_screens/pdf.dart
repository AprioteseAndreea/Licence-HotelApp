import 'dart:ui';
import 'package:first_app_flutter/models/reservation_model.dart';
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

  final PdfGrid grid = getGrid();
  final PdfLayoutResult? result =
      drawHeader(page, pageSize, grid, reservationModel);
  drawGrid(page, grid, result!);
  drawFooter(page, pageSize);
  List<int> bytes = document.save();
  final directory = await getApplicationDocumentsDirectory();

  final path = directory.path;

  final file = File('$path/HelloWorld.pdf');
  await file.writeAsBytes(bytes, flush: true);

  OpenFile.open('$path/HelloWorld.pdf');
}

PdfGrid getGrid() {
  final PdfGrid grid = PdfGrid();
  grid.columns.add(count: 5);
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = 'Product Id';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Product Name';
  headerRow.cells[2].value = 'Price';
  headerRow.cells[3].value = 'Quantity';
  headerRow.cells[4].value = 'Total';
  addProducts('CA-1098', 'AWC Logo Cap', 8.99, 2, 17.98, grid);
  addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
  addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
  addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
  addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
  addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);

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
void addProducts(String productId, String productName, double price,
    int quantity, double total, PdfGrid grid) {
  PdfGridRow row = grid.rows.add();
  row.cells[0].value = productId;
  row.cells[1].value = productName;
  row.cells[2].value = price.toString();
  row.cells[3].value = quantity.toString();
  row.cells[4].value = total.toString();
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

  // page.graphics.drawString(
  //     '\$' + "720", PdfStandardFont(PdfFontFamily.helvetica, 18),
  //     bounds: Rect.fromLTWH(300, 0, pageSize.width - 300, 100),
  //     brush: PdfBrushes.white,
  //     format: PdfStringFormat(
  //         alignment: PdfTextAlignment.center,
  //         lineAlignment: PdfVerticalAlignment.middle));

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

void drawFooter(PdfPage page, Size pageSize) {
  final PdfPen linePen =
      PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
  linePen.dashPattern = <double>[3, 3];
  page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
      Offset(pageSize.width, pageSize.height - 100));

  const String footerContent =
      '800 Interchange Blvd.\r\n\r\nSuite 2501, Austin, TX 78721\r\n\r\nAny Questions? support@adventure-works.com';

  page.graphics.drawString(
      footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
      format: PdfStringFormat(alignment: PdfTextAlignment.right),
      bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
}

void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
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
  page.graphics.drawString('Grand Total',
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(quantityCellBounds.left, result.bounds.bottom + 10,
          quantityCellBounds.width, quantityCellBounds.height));
  page.graphics.drawString("720",
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(
          totalPriceCellBounds.left,
          result.bounds.bottom + 10,
          totalPriceCellBounds.width,
          totalPriceCellBounds.height));
}
