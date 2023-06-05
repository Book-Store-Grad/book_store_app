import 'package:book_store/controller/Cubit/Author/author_cubit.dart';
import 'package:book_store/view/Screens/Auth/login.dart';
import 'package:book_store/view/Screens/Autor/add_book.dart';
import 'package:book_store/view/Screens/Profile/profile.dart';
import 'package:book_store/view/widgets/bookItem.dart';
import 'package:book_store/view/widgets/buttonfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthHome extends StatelessWidget {
  const AuthHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthorCubit()..getAuthorBooks(),
      child: BlocConsumer<AuthorCubit, AuthorState>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthorCubit cubit = AuthorCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'My Books',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              backgroundColor: Colors.white,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                    },
                    child: const Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
            body: cubit.booksModel == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : cubit.booksModel!.content!.books!.isEmpty
                    ? Center(
                        child: Text(
                          'Add Some Books to Your Gallery!',
                          style: GoogleFonts.akayaKanadaka(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: DefaultButton(
                              text: 'Add Book',
                              function: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddBook()),
                                );
                              },
                              background: Colors.blue,
                              textColor: Colors.white,
                              textSize: 20,
                              width: 150,
                              height: 40,
                            ),
                          ),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 1.0,
                              childAspectRatio: 1 / 1.2,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              children: List.generate(
                                  cubit.booksModel!.content!.books!.length,
                                      (index) =>
                                          AuthorBook(bookId: cubit.booksModel!.content!.books![index].bId!,
                                              price: cubit.booksModel!.content!.books![index].bPrice!,
                                              bookImageUrl: cubit.booksModel!.content!.books![index].coverImageUrl!,
                                              bookName: cubit.booksModel!.content!.books![index].bName!)),
                            ),
                          )
                        ],
                      ),
          );
        },
      ),
    );
  }
}
