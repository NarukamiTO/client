package alternativa.tanks.models.tank.rankup {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ITankRankUpEffectModelAdapt implements ITankRankUpEffectModel {
    private var object:IGameObject;
    private var impl:ITankRankUpEffectModel;

    public function ITankRankUpEffectModelAdapt(param1:IGameObject, param2:ITankRankUpEffectModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function showRankUpEffect(param1:int) : void {
      var rankIndex:int = param1;
      try {
        Model.object = this.object;
        this.impl.showRankUpEffect(rankIndex);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
