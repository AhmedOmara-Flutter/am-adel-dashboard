
import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import '../view_model/view_model/order_review_cubit.dart';
import '../widgets/order_review_body.dart';

class OrderReviewView extends StatelessWidget {
  const OrderReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: const OrderReviewBody(),

    );
  }
}
