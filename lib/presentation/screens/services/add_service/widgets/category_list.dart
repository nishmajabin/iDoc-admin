import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/category/category_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/category/category_state.dart';
import 'package:idoc_admin_side/presentation/screens/services/add_service/widgets/category_card.dart';
import 'package:idoc_admin_side/presentation/screens/services/add_service/widgets/empty_category_view.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'All Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF6FCA78),
                    ),
                  ),
                ),
              );
            }

            if (state is CategoryLoaded) {
              if (state.categories.isEmpty) {
                return const EmptyCategoryView();
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return CategoryCard(category: category);
                },
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}