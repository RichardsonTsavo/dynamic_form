import 'package:brasil_fields/brasil_fields.dart';
import 'package:dynamic_form/app/shared/models/index.dart';
import 'package:dynamic_form/app/shared/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormWidgetBuilder {
  final BoxConstraints constraints;
  const FormWidgetBuilder({required this.constraints});

  List<Widget> buildForm({
    required GlobalKey<FormBuilderState> formKey,
    required FormSectionModel formSection,
  }) {
    List<Widget> widgets = [
      Text(
        formSection.title!,
        style: TextStyle(
          color: Colors.white,
          fontSize: constraints.maxWidth * 0.06,
          fontWeight: FontWeight.bold,
        ),
      ),
      if (formSection.description != null)
        Text(
          formSection.description!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
    ];

    for (var element in formSection.fields!) {
      switch (element.fieldType) {
        case 'TEXT':
          widgets.add(
            buildField(
              field: element,
              widget: CustomTextFormField(
                name: element.id!,
                initialValue: element.value,
                labelText: element.label ?? "Digite um Texto",
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo não pode ser vazio!";
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'LONGTEXT':
          widgets.add(
            buildField(
              field: element,
              widget: CustomTextFormField(
                name: element.id!,
                initialValue: element.value,
                labelText: element.label ?? "Digite um Texto",
                maxLines: 5,
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo não pode ser vazio!";
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'CPF':
          widgets.add(
            buildField(
              field: element,
              widget: CustomTextFormField(
                name: element.id!,
                initialValue: element.value,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                keyboardType: TextInputType.number,
                labelText: "Digite um CPF",
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null ||
                            !UtilBrasilFields.isCPFValido(value)) {
                          return "CPF invalido!";
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'CNPJ':
          widgets.add(
            buildField(
              field: element,
              widget: CustomTextFormField(
                name: element.id!,
                initialValue: element.value,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CnpjInputFormatter(),
                ],
                keyboardType: TextInputType.number,
                labelText: "Digite um CNPJ",
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null ||
                            !UtilBrasilFields.isCNPJValido(value)) {
                          return "CNPJ invalido!";
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'CEP':
          widgets.add(
            buildField(
              field: element,
              widget: CustomTextFormField(
                name: element.id!,
                initialValue: element.value,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
                keyboardType: TextInputType.number,
                labelText: "Digite um cep",
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'O CEP é obrigatório';
                        }
                        final regex = RegExp(r'^\d{5}-\d{3}\$');

                        if (!regex.hasMatch(value)) {
                          return 'O CEP deve estar no formato 99999-999';
                        }

                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'PHONE':
          widgets.add(
            buildField(
              field: element,
              widget: CustomTextFormField(
                name: element.id!,
                initialValue: element.value,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                keyboardType: TextInputType.number,
                labelText: "Digite um Telefone",
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'O número de telefone é obrigatório';
                        }

                        final regex = RegExp(r'^\(\d{2}\) \d{5}-\d{4}\$');

                        if (!regex.hasMatch(value)) {
                          return 'O número de telefone deve estar no formato (99) 99999-9999';
                        }

                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'CURRENCY':
          widgets.add(
            buildField(
              field: element,
              widget: CustomTextFormField(
                name: element.id!,
                initialValue: element.value,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CentavosInputFormatter(),
                ],
                keyboardType: TextInputType.number,
                labelText: "Digite um valor",
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'O Campo é obrigatório';
                        }

                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'CARPLATE':
          widgets.add(
            buildField(
              field: element,
              widget: CustomTextFormField(
                name: element.id!,
                initialValue: element.value,
                inputFormatters: [
                  PlacaVeiculoInputFormatter(),
                ],
                labelText: "Digite uma placa de carro",
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'A placa do carro é obrigatória';
                        }
                        final regex = RegExp(r'^[A-Z]{3}-\d{4}\$');
                        if (!regex.hasMatch(value)) {
                          return 'A placa do carro deve estar no formato AAA-1234';
                        }

                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'BANKCARD':
          widgets.add(
            buildField(
              field: element,
              widget: CustomTextFormField(
                name: element.id!,
                initialValue: element.value,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CartaoBancarioInputFormatter(),
                ],
                keyboardType: TextInputType.number,
                labelText: "Digite o número do cartão",
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'O número do cartão é obrigatório';
                        }
                        final regex = RegExp(r'^(\d{4} ){4}\d{4}\$');
                        if (!regex.hasMatch(value)) {
                          return 'O número do cartão deve estar no formato 0000 1111 2222 3333 4444';
                        }

                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'CHECKBOX':
          widgets.add(
            buildField(
              field: element,
              widget: CustomCheckbox(
                name: element.id!,
                title: element.label!,
                initialValue: element.value,
                validator: element.isRequired == true
                    ? (value) {
                        if (value == false) {
                          return "Campo Obrigatório";
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'DROPDOWN':
          widgets.add(
            buildField(
              field: element,
              widget: CustomDropdown(
                name: element.id!,
                title: element.label ?? 'Selecione uma opção',
                items: List.generate(
                  element.fieldOptions!.length,
                  (index) => DropdownMenuItem(
                    value: element.fieldOptions![index],
                    child: Text(
                      element.fieldOptions![index],
                    ),
                  ),
                ),
                initialValue: element.value,
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null) {
                          return 'Selecione uma opção';
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'SWITCH':
          widgets.add(
            buildField(
              field: element,
              widget: CustomSwitch(
                name: element.id!,
                title: element.label!,
                initialValue: element.value,
                validator: element.isRequired == true
                    ? (value) {
                        if (value == false) {
                          return "Campo Obrigatório";
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'CHECKBOXGROUP':
          widgets.add(
            buildField(
              field: element,
              widget: CustomCheckboxGroup(
                name: element.id!,
                initialValue: element.value,
                options: List.generate(
                  element.fieldOptions!.length,
                  (index) => FormBuilderFieldOption(
                    value: element.fieldOptions![index],
                  ),
                ),
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'Selecione uma opção';
                        }
                        if (value.length < element.min!) {
                          return 'Selecione no mínimo ${element.min!.toInt()} opções';
                        }
                        if (value.length > element.max!) {
                          return 'Selecione no máximo ${element.max!.toInt()} opções';
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'SLIDER':
          widgets.add(
            buildField(
              field: element,
              widget: CustomSlider(
                name: element.id!,
                initialValue: element.value,
                min: element.min!,
                max: element.max!,
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null) {
                          return 'Campo Obrigatório';
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'DATE':
          widgets.add(
            buildField(
              field: element,
              widget: CustomDateTimePicker(
                name: element.id!,
                initialValue: element.value,
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null) {
                          return 'Campo Obrigatório';
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        case 'FILE':
          widgets.add(
            buildField(
              field: element,
              widget: CustomFilePicker(
                name: element.id!,
                initialValue: element.value,
                allowMultiple: element.max! > 1,
                allowedExtensions: element.fileTypes,
                validator: element.isRequired == true
                    ? (value) {
                        if (value == null) {
                          return 'Campo Obrigatório';
                        }
                        if (value.length < element.min!) {
                          return 'Selecione no mínimo ${element.min!.toInt()} arquivos';
                        }
                        if (value.length > element.max!) {
                          return 'Selecione no máximo ${element.max!.toInt()} arquivos';
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          );
          break;
        default:
      }
    }
    return widgets;
  }

  Widget buildField({
    required FormFieldModel field,
    required Widget widget,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${field.title!}:",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: constraints.maxWidth * 0.04,
            ),
          ),
          if (field.description != null)
            Text(
              field.description!,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: widget,
          ),
        ],
      ),
    );
  }
}
