import 'package:flutter/material.dart';

class ExpenseFromWidget extends StatelessWidget {
  final int? rupee;
  final String? category;
  final String? note;
  final ValueChanged<int> OnChangedRupee;
  final ValueChanged<String> OnChangedCategory;
  final ValueChanged<String> OnChangedNote;

  const ExpenseFromWidget({
    Key? key,
    this.rupee = 0,
    this.category = '',
    this.note = '',
    required this.OnChangedRupee,
    required this.OnChangedCategory,
    required this.OnChangedNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //  buildRupee(),
            const SizedBox(height: 4),

            buildNotes(),
            const SizedBox(height: 8),
            buildCategory(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
/*Widget buildRupee() => TextFormField(
        maxLines: 1,
        initialValue: rupee,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '0',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (rupee) => rupee != null && rupee.isEmpty
            ? 'The Rupee cannot be empty'
            : null,
        onChanged:OnChangedRupee ,
      );

*/

  Widget buildCategory() => TextFormField(
        maxLines: 1,
        initialValue: category,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Category',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (category) => category != null && category.isEmpty
            ? 'The category cannot be empty'
            : null,
        onChanged: OnChangedCategory,
      );

  Widget buildNotes() => TextFormField(
        maxLines: 5,
        initialValue: note,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (note) =>
            note != null && note.isEmpty ? 'The Note cannot be empty' : null,
        onChanged: OnChangedNote,
      );

  /*Widget buildrupeee() => TextFormField(
        maxLines: 5,
        initialValue: rupee.toString(),
        style: TextStyle(color: Colors.white60, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.white),
        ),
        validator: (rupee) =>
            rupee != null && rupee.isEmpty ? 'The Note cannot be empty' : null,
        onChanged: OnChangedRupee,
      );
*/

}
