part of 'screen.dart';

class _SkeletonBannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300], // Cor do esqueleto
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 308,
            height: 205,
            color: Colors.grey[400], // Cor do esqueleto
          ),
        ],
      ),
    );
  }
}
