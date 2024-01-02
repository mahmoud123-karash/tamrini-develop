import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/home_provider.dart';
import 'package:tamrini/provider/questions_proviser.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class QuestionDetailsScreen extends StatefulWidget {
  final int indexs;
  const QuestionDetailsScreen({Key? key, required this.indexs})
      : super(key: key);

  @override
  State<QuestionDetailsScreen> createState() => _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: globalAppBar(" تفاصيل السؤال"),
        body: Consumer<QuestionsProvider>(builder: (context, _, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _.filteredQuestions[widget.indexs].title,
                          style: TextStyle(
                              fontSize: 25.spMin,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(DateTime.parse(_
                              .filteredQuestions[widget.indexs].date
                              .toDate()
                              .toString())),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Provider.of<UserProvider>(context, listen: false).isAdmin
                          ? IconButton(
                              onPressed: () {
                                _.deleteQuestion(
                                    _.filteredQuestions[widget.indexs].id);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.white12,
                      thickness: 1,
                    ),
                  ),

                  Text(
                    _.filteredQuestions[widget.indexs].body,
                    style: TextStyle(
                        fontSize: 18.spMin, fontWeight: FontWeight.normal),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _.filteredQuestions[widget.indexs].name!,
                          style: TextStyle(fontSize: 13.spMin),
                        ),
                      ),
                      Provider.of<UserProvider>(context, listen: false).isAdmin
                          ? IconButton(
                              onPressed: () {
                                Provider.of<HomeProvider>(context,
                                        listen: false)
                                    .banUser(
                                        username: _
                                            .filteredQuestions[widget.indexs]
                                            .askerUsername);
                              },
                              icon: const Icon(
                                Icons.no_accounts_sharp,
                                color: Colors.red,
                              ),
                            )
                          : Container(),
                    ],
                  ),

                  //  const Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Divider(
                  //     color: Colors.white12,
                  //     thickness:1,
                  //   ),
                  // ),

                  Row(
                    children: [
                      const Icon(Icons.question_answer),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "الإجابات",
                        style: TextStyle(fontSize: 25.spMin),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "(${_.filteredQuestions[widget.indexs].answers.length})",
                        style: TextStyle(fontSize: 25.spMin),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.white12,
                      thickness: 1,
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        _.filteredQuestions[widget.indexs].answers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _.filteredQuestions[widget.indexs]
                                          .answers[index].answer!,
                                    ),
                                  ),
                                ),
                                // const Spacer(),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        _.filteredQuestions[widget.indexs]
                                            .answers[index].username!,
                                        style: TextStyle(fontSize: 13.spMin),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(_
                                                  .filteredQuestions[
                                                      widget.indexs]
                                                  .answers[index]
                                                  .date!
                                                  .toDate()
                                                  .toString())),
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Provider.of<UserProvider>(context,
                                                listen: false)
                                            .isAdmin
                                        ? IconButton(
                                            onPressed: () {
                                              _.deleteAnswer(
                                                  _.filteredQuestions[
                                                      widget.indexs],
                                                  _
                                                      .filteredQuestions[
                                                          widget.indexs]
                                                      .answers[index]);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          )
                                        : Container(),
                                    Provider.of<UserProvider>(context,
                                                listen: false)
                                            .isAdmin
                                        ? IconButton(
                                            onPressed: () {
                                              Provider.of<HomeProvider>(context,
                                                      listen: false)
                                                  .banUser(
                                                      username: _
                                                          .filteredQuestions[
                                                              widget.indexs]
                                                          .answers[index]
                                                          .username!);
                                            },
                                            icon: const Icon(
                                              Icons.no_accounts_sharp,
                                              color: Colors.red,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  //
                  // const Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Divider(
                  //     color: Colors.black,
                  //     thickness:0.25,
                  //   ),
                  // ),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          maxLines: 5,
                          minLines: 1,
                          decoration: const InputDecoration(
                            hintText: "إضافة إجابة",
                            border: OutlineInputBorder(
                                // borderSide: BorderSide(color: Colors.white),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _.addAnswer(_.filteredQuestions[widget.indexs],
                              controller.text);
                          controller.clear();
                        },
                        child: const Text(
                          "إضافة",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
