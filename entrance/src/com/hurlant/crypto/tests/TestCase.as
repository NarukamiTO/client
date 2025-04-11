package com.hurlant.crypto.tests {
  public class TestCase {
    public var harness:ITestHarness;

    public function TestCase(param1:ITestHarness, param2:String) {
      super();
      this.harness = param1;
      this.harness.beginTestCase(param2);
    }

    public function assert(param1:String, param2:Boolean) : void {
      if(param2) {
        return;
      }
      throw new Error("Test Failure:" + param1);
    }

    public function runTest(param1:Function, param2:String) : void {
      var f:Function = param1;
      var title:String = param2;
      this.harness.beginTest(title);
      try {
        f();
      }
      catch(e:Error) {
        harness.failTest(e.toString());
        return;
      }
      this.harness.passTest();
    }
  }
}
