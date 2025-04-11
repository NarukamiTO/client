package alternativa.engine3d.loaders.collada {
  public class DaeLogger {
    public function DaeLogger() {
      super();
    }

    private function logMessage(param1:String, param2:XML) : void {
      var local3:int = 0;
      var local4:String = param2.nodeKind() == "attribute" ? "@" + param2.localName() : param2.localName() + (local3 > 0 ? "[" + local3 + "]" : "");
      var local5:* = param2.parent();
      while(local5 != null) {
        local4 = local5.localName() + (local3 > 0 ? "[" + local3 + "]" : "") + "." + local4;
        local5 = local5.parent();
      }
    }

    private function logError(param1:String, param2:XML) : void {
      this.logMessage("[ERROR] " + param1,param2);
    }

    public function logExternalError(param1:XML) : void {
      this.logError("External urls don\'t supported",param1);
    }

    public function logSkewError(param1:XML) : void {
      this.logError("<skew> don\'t supported",param1);
    }

    public function logJointInAnotherSceneError(param1:XML) : void {
      this.logError("Joints in different scenes don\'t supported",param1);
    }

    public function logInstanceNodeError(param1:XML) : void {
      this.logError("<instance_node> don\'t supported",param1);
    }

    public function logNotFoundError(param1:XML) : void {
      this.logError("Element with url \"" + param1.toString() + "\" not found",param1);
    }

    public function logNotEnoughDataError(param1:XML) : void {
      this.logError("Not enough data",param1);
    }
  }
}
