package projects.tanks.client.tanksservices.model.notifier.uid {
  import projects.tanks.client.tanksservices.model.notifier.AbstractNotifier;

  public class UidNotifierData extends AbstractNotifier {
    private var _uid:String;

    public function UidNotifierData(param1:String = null) {
      super();
      this._uid = param1;
    }

    public function get uid() : String {
      return this._uid;
    }

    public function set uid(param1:String) : void {
      this._uid = param1;
    }

    override public function toString() : String {
      var local1:String = "UidNotifierData [";
      local1 += "uid = " + this.uid + " ";
      local1 += super.toString();
      return local1 + "]";
    }
  }
}
