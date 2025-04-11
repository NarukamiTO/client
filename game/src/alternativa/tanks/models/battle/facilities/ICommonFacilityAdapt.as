package alternativa.tanks.models.battle.facilities {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class ICommonFacilityAdapt implements ICommonFacility {
    private var object:IGameObject;
    private var impl:ICommonFacility;

    public function ICommonFacilityAdapt(param1:IGameObject, param2:ICommonFacility) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPosition() : Vector3 {
      var result:Vector3 = null;
      try {
        Model.object = this.object;
        result = this.impl.getPosition();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCenter() : Vector3 {
      var result:Vector3 = null;
      try {
        Model.object = this.object;
        result = this.impl.getCenter();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTeam() : BattleTeam {
      var result:BattleTeam = null;
      try {
        Model.object = this.object;
        result = this.impl.getTeam();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getOwner() : IGameObject {
      var result:IGameObject = null;
      try {
        Model.object = this.object;
        result = this.impl.getOwner();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
