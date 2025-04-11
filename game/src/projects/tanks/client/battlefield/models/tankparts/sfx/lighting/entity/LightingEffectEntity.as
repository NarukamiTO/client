package projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity {
  public class LightingEffectEntity {
    private var _effectName:String;
    private var _items:Vector.<LightEffectItem>;

    public function LightingEffectEntity(param1:String = null, param2:Vector.<LightEffectItem> = null) {
      super();
      this._effectName = param1;
      this._items = param2;
    }

    public function get effectName() : String {
      return this._effectName;
    }

    public function set effectName(param1:String) : void {
      this._effectName = param1;
    }

    public function get items() : Vector.<LightEffectItem> {
      return this._items;
    }

    public function set items(param1:Vector.<LightEffectItem>) : void {
      this._items = param1;
    }

    public function toString() : String {
      var local1:String = "LightingEffectEntity [";
      local1 += "effectName = " + this.effectName + " ";
      local1 += "items = " + this.items + " ";
      return local1 + "]";
    }
  }
}
