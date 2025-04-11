package projects.tanks.client.tanksservices.model.notifier {
  import alternativa.types.Long;

  public class AbstractNotifier {
    private var _userId:Long;

    public function AbstractNotifier(param1:Long = null) {
      super();
      this._userId = param1;
    }

    public function get userId() : Long {
      return this._userId;
    }

    public function set userId(param1:Long) : void {
      this._userId = param1;
    }

    public function toString() : String {
      var local1:String = "AbstractNotifier [";
      local1 += "userId = " + this.userId + " ";
      return local1 + "]";
    }
  }
}
