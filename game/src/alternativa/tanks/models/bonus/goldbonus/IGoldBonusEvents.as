package alternativa.tanks.models.bonus.goldbonus {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;

  public class IGoldBonusEvents implements IGoldBonus {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IGoldBonusEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getRegions() : Vector.<BonusRegionData> {
      var result:Vector.<BonusRegionData> = null;
      var i:int = 0;
      var m:IGoldBonus = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IGoldBonus(this.impl[i]);
          result = m.getRegions();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
