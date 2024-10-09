import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_app/feature/home/view/widgets/price_real_time_widget.dart';

class ProductCard extends StatelessWidget {
  final String titleProduct;
  final String image;
  final String description;
  final void Function()? onTap;

  const ProductCard(
      {super.key,
      required this.titleProduct,
      required this.image,
      required this.description,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 110.h,
            width: 110.w,
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: Container(
                  height: 110.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.grey[200]),
                ),
              ),
              imageUrl: image,
            ),
          ),
          16.w.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: .55.sw,
                child: Text(
                  titleProduct,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff151515),
                  ),
                ),
              ),
              8.w.verticalSpace,
              SizedBox(
                width: .66.sw,
                child: Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff9E9E9E),
                  ),
                ),
              ),
              10.h.verticalSpace,
              const PriceRealTimeWidget(),
            ],
          )
        ],
      ),
    );
  }
}
