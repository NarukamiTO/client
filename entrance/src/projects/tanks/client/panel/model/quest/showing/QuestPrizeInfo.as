package projects.tanks.client.panel.model.quest.showing {
  import alternativa.types.Long;

  public class QuestPrizeInfo {
    private var _count:int;
    private var _name:String;
    private var _prizeObject:Long;

    public function QuestPrizeInfo(param1:int = 0, param2:String = null, param3:Long = null) {
      super();
      this._count = param1;
      this._name = param2;
      this._prizeObject = param3;
    }

    public function get count() : int {
      return this._count;
    }

    public function set count(param1:int) : void {
      this._count = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function get prizeObject() : Long {
      return this._prizeObject;
    }

    public function set prizeObject(param1:Long) : void {
      this._prizeObject = param1;
    }

    public function toString() : String {
      var local1:String = "QuestPrizeInfo [";
      local1 += "count = " + this.count + " ";
      local1 += "name = " + this.name + " ";
      local1 += "prizeObject = " + this.prizeObject + " ";
      return local1 + "]";
    }
  }
}
