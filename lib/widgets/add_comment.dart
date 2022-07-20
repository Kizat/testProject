import 'package:flutter/material.dart';
import 'package:test_project/models/add_comment_model.dart';
import 'package:test_project/services/strings.dart';

class AddComment extends StatefulWidget {
  const AddComment({
    Key? key,
    required this.postId,
  }) : super(key: key);

  final String postId;

  Future<AddCommentModel?> show(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (context) => this,
    );
    return result;
  }

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController commentTextEditingController =
      TextEditingController();

  final FocusNode namefocusNode = FocusNode();
  final FocusNode emailfocusNode = FocusNode();
  final FocusNode commentfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    commentfocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            margin: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(12),
                        labelText: "Комментарий",
                        hintText: "Введите комментарий",
                      ),
                      controller: commentTextEditingController,
                      focusNode: commentfocusNode,
                      textInputAction: TextInputAction.next,
                      onChanged: (val) => setState(() {}),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(12),
                        labelText: "Имя",
                        hintText: "Введите имя",
                      ),
                      controller: nameTextEditingController,
                      focusNode: namefocusNode,
                      textInputAction: TextInputAction.next,
                      onChanged: (val) => setState(() {}),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(12),
                        labelText: "Почта",
                        hintText: "Введите почту",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailTextEditingController,
                      focusNode: emailfocusNode,
                      textInputAction: TextInputAction.done,
                      onChanged: (val) => setState(() {}),
                      onFieldSubmitted: (val) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 45.0,
                      child: ElevatedButton(
                        onPressed: nameTextEditingController.text == '' ||
                                emailTextEditingController.text == '' ||
                                commentTextEditingController.text == ''
                            ? null
                            : () {
                                Navigator.of(context).pop(
                                  AddCommentModel(
                                    name: nameTextEditingController.text,
                                    email: emailTextEditingController.text,
                                    comment: commentTextEditingController.text,
                                  ),
                                );
                              },
                        child: Center(
                          child: Text(Strings.addComment),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
