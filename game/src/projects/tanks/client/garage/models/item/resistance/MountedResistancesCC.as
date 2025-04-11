package projects.tanks.client.garage.models.item.resistance {
  import platform.client.fp10.core.type.IGameObject;

  public class MountedResistancesCC {
    private var _resistances:Vector.<IGameObject>;

    public function MountedResistancesCC(param1:Vector.<IGameObject> = null) {
      super();
      this._resistances = param1;
    }

    public function get resistances() : Vector.<IGameObject> {
      return this._resistances;
    }

    public function set resistances(param1:Vector.<IGameObject>) : void {
      this._resistances = param1;
    }

    public function toString() : String {
      var local1:String = "MountedResistancesCC [";
      local1 += "resistances = " + this.resistances + " ";
      return local1 + "]";
    }
  }
}
