import 'package:enhanzer_test/utilities/global_exports.dart';

class AppBarLeading extends StatelessWidget {
  final VoidCallback onTap;
  const AppBarLeading({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.file_open,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}