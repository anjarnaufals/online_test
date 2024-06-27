part of 'contact_cubit.dart';

class ContactState extends Equatable {
  const ContactState({
    this.loading = false,
    this.listContact = const [],
    this.errMsg = '',
  });

  final bool loading;
  final List<ContactModel> listContact;
  final String errMsg;

  @override
  List<Object> get props => [
        loading,
        listContact,
        errMsg,
      ];

  ContactState copyWith({
    bool? loading,
    List<ContactModel>? listContact,
    String? errMsg,
  }) {
    return ContactState(
      loading: loading ?? this.loading,
      listContact: listContact ?? this.listContact,
      errMsg: errMsg ?? this.errMsg,
    );
  }
}
