import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardWithCounter extends StatefulWidget {
  final String id;
  final String name;
  final String description;
  final String readyTime;
  final String imageUrl;
  final double price;
  final int initialQuantity;

  final Function(String id, int quantity) onIncrement;
  final Function(String id, int quantity) onDecrement;
  final Function(String id) onZero;

  const ProductCardWithCounter({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.readyTime,
    required this.imageUrl,
    required this.price,
    this.initialQuantity = 0,
    required this.onIncrement,
    required this.onDecrement,
    required this.onZero,
  });

  @override
  State<ProductCardWithCounter> createState() => _ProductCardWithCounterState();
}

class _ProductCardWithCounterState extends State<ProductCardWithCounter> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void increment() {
    setState(() {
      quantity++;
    });

    widget.onIncrement(widget.id, quantity);
  }

  void decrement() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });

      widget.onDecrement(widget.id, quantity);

      if (quantity == 0) {
        widget.onZero(widget.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.price * quantity;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.orange),
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.orange),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                widget.imageUrl,
                width: 99.w,
                height: 93.h,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 10.w),

          // Right Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "\$${totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                Text(
                  widget.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.sp),
                ),

                SizedBox(height: 4.h),

                Text(
                  "Pickup Time: ${widget.readyTime}",
                  style: TextStyle(fontSize: 12.sp),
                ),

                SizedBox(height: 8.h),

                // Counter
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 88.w,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8.r,
                          spreadRadius: 1.r,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Minus
                        InkWell(
                          onTap: decrement,
                          child: Icon(Icons.remove_rounded, size: 14.w),
                        ),

                        // Quantity
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        // Plus
                        InkWell(
                          onTap: increment,
                          child: Icon(Icons.add_rounded, size: 14.w),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
