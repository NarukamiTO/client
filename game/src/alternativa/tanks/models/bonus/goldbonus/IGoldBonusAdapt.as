package alternativa.tanks.models.bonus.goldbonus {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;

  public class IGoldBonusAdapt implements IGoldBonus {
    private var object:IGameObject;
    private var impl:IGoldBonus;

    public function IGoldBonusAdapt(param1:IGameObject, param2:IGoldBonus) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getRegions() : Vector.<BonusRegionData> {
      var result:Vector.<BonusRegionData> = null;
      try {
        Model.object = this.object;
        result = this.impl.getRegions();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
