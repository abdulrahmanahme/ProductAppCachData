import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_app/feature/logic/cubit/product_cubit.dart';

class PriceRealTimeWidget extends StatelessWidget {
  const PriceRealTimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('price').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No price yet.'));
        }
        var prices = snapshot.data!.docs;
        return Container(
          height: 60.w,
          width: 150.w,
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 5.h),
            itemCount: 1,
            itemBuilder: (context, index) {
              var data = prices[index];
              Map<String, dynamic> parseData =
                  data.data() as Map<String, dynamic>;
              int price = parseData['price'];
              context.read<ProductsCubit>().price = price.toDouble();
              return Row(
                children: [
                  Text(
                    'Price: ',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    price.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
