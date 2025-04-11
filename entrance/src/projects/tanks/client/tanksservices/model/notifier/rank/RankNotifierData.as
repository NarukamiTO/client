package projects.tanks.client.tanksservices.model.notifier.rank {
  import projects.tanks.client.tanksservices.model.notifier.AbstractNotifier;

  public class RankNotifierData extends AbstractNotifier {
    private var _rank:int;

    public function RankNotifierData(param1:int = 0) {
      super();
      this._rank = param1;
    }

    public function get rank() : int {
      return this._rank;
    }

    public function set rank(param1:int) : void {
      this._rank = param1;
    }

    override public function toString() : String {
      var local1:String = "RankNotifierData [";
      local1 += "rank = " + this.rank + " ";
      local1 += super.toString();
      return local1 + "]";
    }
  }
}
