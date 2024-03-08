import 'package:flutter/material.dart';
import 'package:usos/styles/colors.dart';

import '../../../../data/models/grade.dart';

class GradeWidget extends StatelessWidget {
  const GradeWidget(this.grade, {super.key});

  final Grade grade;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: UsosColors.primaryColor,
              width: 5.0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    grade.course.courseName,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    grade.course.courseId,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            Container(
              width: 60,
              height: 50,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: UsosColors.primaryColor,
                //rounded corners
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Column(
                children: [
                  Text(
                    grade.gradeString,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text("ECTS: ${grade.ectsString}", style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
