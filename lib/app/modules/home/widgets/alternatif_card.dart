import 'package:flutter/material.dart';
import 'package:penilaian/app/data/models/ktm_model.dart';

class AlternatifCard extends StatelessWidget {
  const AlternatifCard({
    super.key,
    required this.data,
    required this.number,
    this.onDelete,
    this.onEdit,
    this.onTap,
  });

  final KtmModel data;
  final int number;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onTap;

  String toTitleCase(String text) {
    if (text.isEmpty) return text;

    return text.toLowerCase().split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) {
        onDelete?.call();
      },
      confirmDismiss: (direction) async {
        bool delete = false;
        final snackbarController = ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Delete Data ${data.nama}?'),
            action:
                SnackBarAction(label: 'Delete', onPressed: () => delete = true),
          ),
        );
        await snackbarController.closed;
        return delete;
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFffa5a5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.asset(
          'assets/img/delete.png',
          width: 24,
          height: 24,
        ),
      ),
      child: Column(children: [
        GestureDetector(
          onTap: onEdit,
          child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color(0xffDDDBFF).withOpacity(0.5), width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xffDDDBFF).withOpacity(1),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(2, 3)),
                      ],
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/img/image4.png',
                        fit: BoxFit.cover,
                        width: 45,
                        height: 60,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(toTitleCase(data.nama),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Today',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                              Text('1 page',
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ]),
    );
  }
}
