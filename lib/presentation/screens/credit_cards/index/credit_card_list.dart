part of 'screen.dart';

class _CreditCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreditCardProvider>(
      builder: (context, creditCardProvider, _) {
        if (!creditCardProvider.hasLoadedInitialData) {
          return ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) => _CreditCardItem.skeleton(context),
          );
        }

        if (creditCardProvider.userCreditCards.isEmpty) {
          return _EmptyState();
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: creditCardProvider.userCreditCards.length,
          itemBuilder: (context, index) => _CreditCardItem(
            creditCard: creditCardProvider.userCreditCards.elementAt(index),
            selectedCreditCardId: creditCardProvider.selectedCreditCardId!,
            length: creditCardProvider.userCreditCards.length,
          ),
        );
      },
    );
  }
}

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
              'Você ainda não tem cartões.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _CreditCardItem extends StatefulWidget {
  final CreditCard creditCard;
  final String selectedCreditCardId;
  final int length;

  const _CreditCardItem({
    required this.creditCard,
    required this.selectedCreditCardId,
    required this.length,
  });

  @override
  State<_CreditCardItem> createState() => _CreditCardItemState();

  static Widget skeleton(BuildContext context) {
    return CreditCardCard.skeleton(
      context,
      const Padding(
        padding: EdgeInsets.only(right: 8),
        child: SkeletonShape(
          width: 40,
          height: 40,
          borderRadius: 20,
        ),
      ),
    );
  }
}

class _CreditCardItemState extends State<_CreditCardItem> {
  bool _isDeleting = false;

  Future<void> _deleteCreditCard(BuildContext context) async {
    setState(() {
      _isDeleting = true;
    });

    await context
        .read<CreditCardProvider>()
        .deleteCreditCard(widget.creditCard);

    setState(() {
      _isDeleting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CreditCardCard(
      creditCard: widget.creditCard,
      onTap: _isDeleting
          ? null
          : () => context
              .read<CreditCardProvider>()
              .setSelectedCreditCard(widget.creditCard),
      isSelected: widget.creditCard.id == widget.selectedCreditCardId,
      trailing: widget.length > 1
          ? IconButton(
              onPressed: _isDeleting
                  ? null
                  : () async => await _deleteCreditCard(context),
              icon: _isDeleting
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(),
                    )
                  : const Icon(Icons.delete),
            )
          : null,
    );
  }
}
