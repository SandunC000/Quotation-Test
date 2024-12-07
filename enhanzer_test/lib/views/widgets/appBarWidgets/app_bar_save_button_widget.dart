import 'package:enhanzer_test/utilities/global_exports.dart';

class AppBarSaveButton extends StatelessWidget {
  final VoidCallback onTap;
  const AppBarSaveButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: onTap,
        child: const Icon(
          Icons.check_circle_sharp,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
