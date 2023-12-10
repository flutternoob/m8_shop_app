import 'dart:math';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:m8_shop_app/providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem? order;

  const OrderItem(this.order, {Key? key}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _expanded? min(widget.order!.products!.length * 20.0 + 110.0, 200.0): 95,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "\$${widget.order!.amount}",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              subtitle: Text(
                DateFormat("dd/MM/yyyy hh:mm").format(widget.order!.dateTime!),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded? min(widget.order!.products!.length * 20.0 + 100.0, 100.0): 0,
              child: ListView(
                children: widget.order!.products!
                    .map((prod) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      prod.title!,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${prod.quantity!} x \$${prod.price!}",
                      style: const TextStyle(
                          fontSize: 14, color: Colors.grey),
                    )
                  ],
                ))
                    .toList(),
              ),
            ),
            if (_expanded) ...[

            ]
          ],
        ),
      ),
    );
  }
}
