import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../data/model/contact_model.dart';
import '../../../repository/contact_repository.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(const ContactState());

  final ContactRepository contactRepository = ContactRepository();

  Future<void> getListContact({
    bool isRefresh = false,
  }) async {
    emit(state.copyWith(
      errMsg: '',
      loading: isRefresh ? false : true,
    ));

    var data = await contactRepository.getListContact();

    await Future.delayed(Durations.extralong4);

    if (data.isLeft) {
      emit(state.copyWith(
        loading: false,
        errMsg: data.left.message,
      ));
    } else {
      emit(state.copyWith(
        loading: false,
        listContact: data.right,
      ));
    }
  }

  Future<void> updateContact(ContactModel contact) async {
    final findContact =
        state.listContact.indexWhere((data) => data.id == contact.id);

    if (findContact != -1) {
      List<ContactModel> temp = List<ContactModel>.from(state.listContact);

      temp
        ..removeAt(findContact)
        ..insert(findContact, contact);

      emit(state.copyWith(
        listContact: temp,
      ));
    }
  }

  Future<void> create(ContactModel contact) async {
    List<ContactModel> temp = List<ContactModel>.from(state.listContact);

    temp.insert(0, contact);

    emit(state.copyWith(
      listContact: temp,
    ));
  }
}
