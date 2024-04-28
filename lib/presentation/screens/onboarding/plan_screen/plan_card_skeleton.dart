part of 'screen.dart';

class _PlanCardSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 1),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card.outlined(
            surfaceTintColor: Colors.white,
            margin: EdgeInsets.zero,
            child: Container(
              padding: const EdgeInsets.only(
                top: 36,
                bottom: 28,
                left: 28,
                right: 28,
              ),
              child: const SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SkeletonShape(
                          width: 80,
                          height: 28,
                          borderRadius: 4,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SkeletonShape(
                          width: 120,
                          height: 20,
                          borderRadius: 4,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    SkeletonShape(
                      width: 120,
                      height: 20,
                      borderRadius: 4,
                    ),
                    SizedBox(height: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonShape(
                          width: 200,
                          height: 18,
                          borderRadius: 4,
                        ),
                        SizedBox(height: 4),
                        SkeletonShape(
                          width: 140,
                          height: 18,
                          borderRadius: 4,
                        ),
                        SizedBox(height: 4),
                        SkeletonShape(
                          width: 180,
                          height: 18,
                          borderRadius: 4,
                        ),
                        SizedBox(height: 5),
                        SkeletonShape(
                          width: 120,
                          height: 18,
                          borderRadius: 4,
                        ),
                        SizedBox(height: 5),
                        SkeletonShape(
                          width: 80,
                          height: 18,
                          borderRadius: 4,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    SkeletonShape(
                      width: 200,
                      height: 48,
                      borderRadius: 48,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            top: -18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SkeletonShape(
                  width: 150,
                  height: 40,
                  borderRadius: 44,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
