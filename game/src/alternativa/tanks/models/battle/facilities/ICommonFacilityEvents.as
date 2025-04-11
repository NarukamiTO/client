package alternativa.tanks.models.battle.facilities {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class ICommonFacilityEvents implements ICommonFacility {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ICommonFacilityEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPosition() : Vector3 {
      var result:Vector3 = null;
      var i:int = 0;
      var m:ICommonFacility = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICommonFacility(this.impl[i]);
          result = m.getPosition();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCenter() : Vector3 {
      var result:Vector3 = null;
      var i:int = 0;
      var m:ICommonFacility = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICommonFacility(this.impl[i]);
          result = m.getCenter();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTeam() : BattleTeam {
      var result:BattleTeam = null;
      var i:int = 0;
      var m:ICommonFacility = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICommonFacility(this.impl[i]);
          result = m.getTeam();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getOwner() : IGameObject {
      var result:IGameObject = null;
      var i:int = 0;
      var m:ICommonFacility = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICommonFacility(this.impl[i]);
          result = m.getOwner();
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
