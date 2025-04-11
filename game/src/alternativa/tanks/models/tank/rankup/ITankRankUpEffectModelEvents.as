package alternativa.tanks.models.tank.rankup {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ITankRankUpEffectModelEvents implements ITankRankUpEffectModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ITankRankUpEffectModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function showRankUpEffect(param1:int) : void {
      var i:int = 0;
      var m:ITankRankUpEffectModel = null;
      var rankIndex:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankRankUpEffectModel(this.impl[i]);
          m.showRankUpEffect(rankIndex);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
