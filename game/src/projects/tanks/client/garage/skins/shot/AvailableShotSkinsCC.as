package projects.tanks.client.garage.skins.shot {
  import platform.client.fp10.core.type.IGameObject;

  public class AvailableShotSkinsCC {
    private var _skins:Vector.<IGameObject>;

    public function AvailableShotSkinsCC(param1:Vector.<IGameObject> = null) {
      super();
      this._skins = param1;
    }

    public function get skins() : Vector.<IGameObject> {
      return this._skins;
    }

    public function set skins(param1:Vector.<IGameObject>) : void {
      this._skins = param1;
    }

    public function toString() : String {
      var local1:String = "AvailableShotSkinsCC [";
      local1 += "skins = " + this.skins + " ";
      return local1 + "]";
    }
  }
}
