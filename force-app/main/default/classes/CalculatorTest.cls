@isTest
public with sharing class CalculatorTest {
  @IsTest
  static void doAddTest() {
    Integer actualValue = Calculator.doAdd(10, 5);
    System.assert(actualValue == 15, 'Error Message - doAdd method failed');
  }
  @IsTest
  static void doSubTest() {
    Integer actualValue = Calculator.doSub(10, 5);
    System.assert(actualValue == 5, 'Error Message - doAdd method failed');
  }
  @IsTest
  static void doMulTest() {
    Integer actualValue = Calculator.doMul(10, 5);
    System.assert(actualValue == 50, 'Error Message - doAdd method failed');
  }
  @IsTest
  static void doDivTest() {
    Integer actualValue = Calculator.doDiv(10, 5);
    System.assert(actualValue == 2, 'Error Message - doAdd method failed');
  }
}
