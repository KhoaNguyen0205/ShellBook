import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<Invoice> _invoices = [];

  @override
  void initState() {
    super.initState();
    _loadInvoices();
  }

  Future<void> _loadInvoices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? invoiceStrings = prefs.getStringList('invoices');
    if (invoiceStrings != null) {
      List<Invoice> invoices =
          invoiceStrings.map((string) => Invoice.fromJson(string)).toList();
      setState(() {
        _invoices = invoices;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int paidInvoicesCount = _invoices.where((invoice) => invoice.isPaid).length;
    double totalRevenue = _invoices
        .where((invoice) => invoice.isPaid)
        .fold(0, (sum, invoice) => sum + invoice.totalAmount);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Danh sách hoá đơn'),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 26.0, fontWeight: FontWeight.bold),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bghp.png"),
                fit: BoxFit.fitWidth)),
        height: MediaQuery.of(context).size.height * 3 / 5,
        child: ListView.builder(
          itemCount: _invoices.length,
          itemBuilder: (context, index) {
            Invoice invoice = _invoices[index];
            return ListTile(
              title: RichText(
                text: TextSpan(
                  text: invoice.customerName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    if (invoice.isVip)
                      TextSpan(
                        text: '  (VIP) ',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Số lượng sách: ${invoice.quantity}',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color.fromARGB(255, 148, 139, 13),
                    ),
                  ),
                  Text(
                    'Đơn giá: ${invoice.price}',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Thành tiền: ${invoice.totalAmount}',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color.fromARGB(255, 26, 16, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: Icon(
                invoice.isPaid ? Icons.check : Icons.close,
                color: invoice.isPaid ? Colors.green : Colors.red,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.8 / 5,
        color: Colors.grey[200],
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tổng số hoá đơn đã thanh toán: $paidInvoicesCount',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Tổng doanh thu: $totalRevenue',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
