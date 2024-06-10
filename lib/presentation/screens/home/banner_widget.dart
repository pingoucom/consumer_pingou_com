part of 'screen.dart';

class _BannerWidget extends StatelessWidget {
  final Banner_class banner;

  const _BannerWidget({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Add a GestureDetector for click handling
      onTap: () => GoRouter.of(context).replace('/store'),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF6F0E7),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(5),
        child: SizedBox(
          height: 205,
          width: 380,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              banner.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
