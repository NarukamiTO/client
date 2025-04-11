package alternativa.tanks.models.tank.bosstate {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;

  public class IBossStateEvents implements IBossState {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IBossStateEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function role() : BossRelationRole {
      var result:BossRelationRole = null;
      var i:int = 0;
      var m:IBossState = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBossState(this.impl[i]);
          result = m.role();
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
