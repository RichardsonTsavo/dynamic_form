import 'package:dynamic_form/app/modules/view_form/view_form_store.dart';
import 'package:dynamic_form/app/shared/models/index.dart';
import 'package:dynamic_form/app/shared/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/widgets/index.dart';

class ViewFormPage extends StatefulWidget {
  final String title;
  final FormModel form;
  const ViewFormPage({
    super.key,
    this.title = 'ViewFormPage',
    required this.form,
  });
  @override
  ViewFormPageState createState() => ViewFormPageState();
}

class ViewFormPageState extends State<ViewFormPage> {
  final ViewFormStore store = Modular.get();
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      store.formWidgetBuilder ??= FormWidgetBuilder(
        constraints: constraints,
        context: context,
      );
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(widget.form.formName!),
          leading: IconButton(
            onPressed: () {
              if (pageController.page == 0) {
                Navigator.of(context).pop();
              } else {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
        ),
        body: FutureBuilder<FormModel>(
          future: store.getForm(widget.form),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoadingWidget(),
              );
            }
            if (snapshot.hasError) {
              return ErrorWidgetState(errorMensage: snapshot.error.toString());
            }
            return PageView.builder(
              controller: pageController,
              itemCount: widget.form.sections!.length,
              itemBuilder: (context, index) {
                GlobalKey<FormBuilderState> formKey =
                    GlobalKey<FormBuilderState>();
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ...store.formWidgetBuilder!.buildForm(
                          formKey: formKey,
                          formSection: widget.form.sections![index],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(onPressed: () {
                          if (formKey.currentState?.saveAndValidate() == true) {
                            if ((index + 1) != widget.form.sections!.length) {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            } else {
                              store.sendForm(formKey.currentState!.value);
                            }
                          }
                        }, child: Observer(builder: (_) {
                          if (store.isLoading) {
                            return const LoadingWidget(
                              loadingColor: Colors.black,
                            );
                          }
                          return Text(
                              (index + 1) == widget.form.sections!.length
                                  ? "Enviar"
                                  : "Avançar");
                        }))
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }
}
