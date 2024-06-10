part of 'screen.dart';

class _SkeletonProductWidget extends StatelessWidget {
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
            width: 250,
            height: 250,
            color: Colors.grey[400], // Cor do esqueleto
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150, // Largura do esqueleto
                  height: 20, // Altura do esqueleto
                  color: Colors.grey[400], // Cor do esqueleto
                ),
                SizedBox(height: 8),
                Container(
                  width: 200, // Largura do esqueleto
                  height: 16, // Altura do esqueleto
                  color: Colors.grey[400], // Cor do esqueleto
                ),
                SizedBox(height: 8),
                Container(
                  width: 100, // Largura do esqueleto
                  height: 20, // Altura do esqueleto
                  color: Colors.grey[400], // Cor do esqueleto
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
