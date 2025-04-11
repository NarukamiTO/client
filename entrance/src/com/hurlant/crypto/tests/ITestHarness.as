package com.hurlant.crypto.tests {
  public interface ITestHarness {
    function beginTestCase(param1:String) : void;
    function endTestCase() : void;
    function beginTest(param1:String) : void;
    function passTest() : void;
    function failTest(param1:String) : void;
  }
}
