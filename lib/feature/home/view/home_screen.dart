import 'package:product_app/core/service_locator/service_locator.dart';
import 'package:product_app/feature/home/view/screen_details.dart';
import 'package:product_app/feature/home/view/widgets/product_item.dart';
import 'package:product_app/feature/logic/cubit/product_cubit.dart';
import 'package:product_app/feature/logic/cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductsCubit>()..fetchAllProducts(),
      child: Scaffold(
        body: BlocBuilder<ProductsCubit, ProductState>(
          builder: (context, state) {
            if (state is LoadingProductState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessProductState) {
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: context.read<ProductsCubit>().fetchAllProducts,
                  child: ListView.separated(
                    itemCount: state.listProductModel.length,
                    itemBuilder: (context, int index) => ProductCard(
                      titleProduct: state.listProductModel[index].title,
                      image: state.listProductModel[index].image,
                      description: state.listProductModel[index].description,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScreenDetails(
                                title: state.listProductModel[index].title,
                                image: state.listProductModel[index].image,
                                description:
                                    state.listProductModel[index].description,
                                price: context
                                    .read<ProductsCubit>()
                                    .price
                                    .toString(),
                              ),
                            ));
                      },
                    ),
                    separatorBuilder: (context, int index) =>
                        14.h.verticalSpace,
                  ),
                ),
              );
            } else if (state is ErrorProductState) {
              return Center(child: Text(state.error));
            }
            return Center(child: Container());
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    context.read<ProductsCubit>().cancelLister();
  }
}
