package alternativa.tanks.models.battle.commonflag {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;

  public class IFlagModeInitilizerEvents implements IFlagModeInitilizer {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IFlagModeInitilizerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function init(param1:Vector.<ClientFlag>, param2:Vector.<ClientTeamPoint>) : void {
      var i:int = 0;
      var m:IFlagModeInitilizer = null;
      var flags:Vector.<ClientFlag> = param1;
      var points:Vector.<ClientTeamPoint> = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IFlagModeInitilizer(this.impl[i]);
          m.init(flags,points);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
