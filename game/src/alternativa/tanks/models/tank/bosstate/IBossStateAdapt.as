package alternativa.tanks.models.tank.bosstate {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;

  public class IBossStateAdapt implements IBossState {
    private var object:IGameObject;
    private var impl:IBossState;

    public function IBossStateAdapt(param1:IGameObject, param2:IBossState) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function role() : BossRelationRole {
      var result:BossRelationRole = null;
      try {
        Model.object = this.object;
        result = this.impl.role();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
