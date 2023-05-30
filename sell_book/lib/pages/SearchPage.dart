import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Invoice> _invoices = [];
  List<Invoice> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

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

  void _searchInvoices(String query) {
    List<Invoice> results = _invoices.where((invoice) {
      return invoice.customerName.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Tìm kiếm hoá đơn'),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg3.gif"),
                  fit: BoxFit.fitWidth)),
          padding: EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Tên khách hàng',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _searchInvoices(_searchController.text);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 26.0),
              Divider(
                color: Colors.black,
              ),
              Text('Danh sách tìm kiếm hoá đơn',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline)),
              SizedBox(height: 26.0),
              Expanded(
                  child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  Invoice invoice = _searchResults[index];
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
              )),
            ],
          ),
        ));
  }
}
