import 'package:enhanzer_test/utilities/global_exports.dart';

class AppBarBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const AppBarBackButton({
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
          Icons.reply_sharp,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}