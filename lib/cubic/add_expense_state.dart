import 'package:flutter/material.dart';

@immutable
abstract class AddExpenseState {}

class AddExpenseInitial extends AddExpenseState{}

class AddExpenseLoading extends AddExpenseState{}

class AddExpenseSuccess extends AddExpenseState{}

class AddExpenseFailure extends AddExpenseState{

  final String errorMessage;

  AddExpenseFailure(this.errorMessage);

}