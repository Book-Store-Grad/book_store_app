import 'package:book_store/Const/component/component.dart';
import 'package:book_store/controller/Cubit/Author/author_cubit.dart';
import 'package:book_store/view/Screens/Autor/add_image.dart';
import 'package:book_store/view/widgets/buttonfield.dart';
import 'package:book_store/view/widgets/dropmenu.dart';
import 'package:book_store/view/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBook extends StatelessWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController booknameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    const List<String> items = [
      'Business',
      'Classic',
      'Technology',
      'Fiction',
      'History',
      'Education',
      'Entertainment',
      'Science',
      'Political'
    ];
    return BlocProvider(
      create: (context) => AuthorCubit(),
      child: BlocConsumer<AuthorCubit, AuthorState>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthorCubit cubit = AuthorCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: const Text(
                "Add a Book to Your Library",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Form(
                        key: formKey,
                        child: Center(
                          child: Column(
                            children: [
                              TextFieldWidget(
                                width: 300.w,
                                validation: (v) {
                                  if (v!.isEmpty) {
                                    return 'required';
                                  }
                                },
                                hintText: "Enter Book Name !",
                                controller: booknameController,
                                title: 'Book Name',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFieldWidget(
                                width: 300.w,
                                validation: (v) {
                                  if (v!.isEmpty) {
                                    return 'required';
                                  }
                                },
                                hintText: "Enter price !",
                                controller: priceController,
                                title: 'Price',
                              ),
                              StatefulBuilder(
                                builder: (context, setState) => DropMenu(
                                  width: 300.w,
                                  items: items,
                                  title: 'Category',
                                  value: cubit.category!,
                                  onChange: (value) {
                                    setState(() {
                                      cubit.category = value!;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFieldWidget(
                                width: 300.w,
                                maxLines: 10,
                                validation: (v) {
                                  if (v!.isEmpty) {
                                    return 'required';
                                  }
                                },
                                hintText: "Enter Book Description !",
                                controller: descriptionController,
                                title: 'Description',
                              ),
                              state is AddBookLoading?
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: DefaultButton(
                                        height: 40.w,
                                        width: 300.w,
                                        radius: 10,
                                        textSize: 14.sp,
                                        textWeight: FontWeight.bold,
                                        textColor: Colors.white,
                                        text: 'Next',
                                        function: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.addBook(
                                                context: context,
                                                name: booknameController.text,
                                                description:
                                                    descriptionController.text,
                                                price: int.parse(
                                                    priceController.text));
                                            print("clicked!");
                                          }
                                        },
                                      ),
                                    ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
