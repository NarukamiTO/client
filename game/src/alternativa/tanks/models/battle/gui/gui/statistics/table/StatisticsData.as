package alternativa.tanks.models.battle.gui.gui.statistics.table {
  import alternativa.types.Long;

  public class StatisticsData {
    public var label:Object = null;
    public var icon:Object = null;
    public var id:Long;
    public var rank:int = 0;
    public var uid:String = "";
    public var kills:int = 0;
    public var deaths:int = 0;
    public var score:int = 0;
    public var reward:int = -1;
    public var type:int;
    public var self:Boolean;
    public var loaded:Boolean;
    public var suspicious:Boolean;
    public var stars:int = 0;

    public function StatisticsData() {
      super();
    }
  }
}
