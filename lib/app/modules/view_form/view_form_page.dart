import 'package:dynamic_form/app/modules/view_form/view_form_store.dart';
import 'package:dynamic_form/app/shared/models/dynamic_form/index.dart';
import 'package:dynamic_form/app/shared/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/widgets/index.dart';

class ViewFormPage extends StatefulWidget {
  final String title;
  final FormModel form;
  final FormResponseModel? response;
  const ViewFormPage({
    super.key,
    this.title = 'ViewFormPage',
    required this.form,
    this.response,
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
        appBar: AppBar(
          title: Text(widget.form.formName!),
          leading: IconButton(
            onPressed: () {
              if (pageController.page == 0) {
                Modular.to.navigate('/home/');
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
                    child: FormBuilder(
                      key: formKey,
                      child: Column(
                        children: [
                          ...store.formWidgetBuilder!.buildForm(
                            formKey: formKey,
                            formSection: widget.form.sections![index],
                            initialResponses: widget.response,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(onPressed: () {
                            if (formKey.currentState?.saveAndValidate() ==
                                true) {
                              formKey.currentState!.value.forEach(
                                (key, data) {
                                  if (data.runtimeType == List<FileDataModel>) {
                                    store.responseForm[key] =
                                        (data as List<FileDataModel>)
                                            .map(
                                              (e) => e.toMap(),
                                            )
                                            .toList();
                                  } else if (data.runtimeType == DateTime) {
                                    store.responseForm[key] = (data as DateTime)
                                        .millisecondsSinceEpoch;
                                  } else {
                                    store.responseForm[key] = data;
                                  }
                                },
                              );

                              if ((index + 1) != widget.form.sections!.length) {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              } else {
                                if (widget.response != null) {
                                  store.sendEditForm(
                                    form: widget.response!,
                                    context: context,
                                  );
                                } else {
                                  store.sendForm(
                                    response: FormResponseModel(
                                      id: DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString(),
                                      formID: widget.form.id,
                                      user: store.persistentData.user,
                                      response: store.responseForm,
                                    ),
                                    context: context,
                                  );
                                }
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
