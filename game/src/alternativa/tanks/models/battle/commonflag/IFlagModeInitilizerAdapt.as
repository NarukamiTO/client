package alternativa.tanks.models.battle.commonflag {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;

  public class IFlagModeInitilizerAdapt implements IFlagModeInitilizer {
    private var object:IGameObject;
    private var impl:IFlagModeInitilizer;

    public function IFlagModeInitilizerAdapt(param1:IGameObject, param2:IFlagModeInitilizer) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function init(param1:Vector.<ClientFlag>, param2:Vector.<ClientTeamPoint>) : void {
      var flags:Vector.<ClientFlag> = param1;
      var points:Vector.<ClientTeamPoint> = param2;
      try {
        Model.object = this.object;
        this.impl.init(flags,points);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
