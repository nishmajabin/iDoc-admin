import 'package:flutter/material.dart';
import 'package:idoc_admin_side/data/models/fee_slab_model.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/fee_slab_card/widgets/card_actions.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/fee_slab_card/widgets/card_container.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/fee_slab_card/widgets/card_content.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/fee_slab_card/widgets/fee_slab_icon.dart';

class FeeSlabCard extends StatelessWidget {
  final FeeSlabModel feeSlab;

  const FeeSlabCard({super.key, required this.feeSlab});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const FeeSlabIcon(),
            const SizedBox(width: 16),
            Expanded(child: CardContent(feeSlab: feeSlab)),
            CardActions(feeSlab: feeSlab),
          ],
        ),
      ),
    );
  }
}