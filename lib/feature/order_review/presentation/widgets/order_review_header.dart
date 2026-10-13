
import 'package:am_adel_dashboard/core/utils/app_imports.dart';

class OrderReviewHeader extends StatelessWidget {
  const OrderReviewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'إدارة التقييمات',
                    style: StyleManager.font19Weight700(context),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'تابع آراء العملاء وجودة الخدمة',
                    style: StyleManager.font12Weight500(context),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
