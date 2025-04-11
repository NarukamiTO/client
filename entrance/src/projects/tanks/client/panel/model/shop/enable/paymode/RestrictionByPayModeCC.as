package projects.tanks.client.panel.model.shop.enable.paymode {
  import platform.client.fp10.core.type.IGameObject;

  public class RestrictionByPayModeCC {
    private var _payMode:IGameObject;

    public function RestrictionByPayModeCC(param1:IGameObject = null) {
      super();
      this._payMode = param1;
    }

    public function get payMode() : IGameObject {
      return this._payMode;
    }

    public function set payMode(param1:IGameObject) : void {
      this._payMode = param1;
    }

    public function toString() : String {
      var local1:String = "RestrictionByPayModeCC [";
      local1 += "payMode = " + this.payMode + " ";
      return local1 + "]";
    }
  }
}
