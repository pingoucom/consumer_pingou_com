part of 'screen.dart';

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.close,
              size: 32,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
            Text(
              'Seu carrinho está vazio.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
