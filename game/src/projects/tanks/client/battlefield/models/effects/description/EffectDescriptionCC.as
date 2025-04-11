package projects.tanks.client.battlefield.models.effects.description {
  import platform.client.fp10.core.type.IGameObject;

  public class EffectDescriptionCC {
    private var _category:EffectCategory;
    private var _index:int;
    private var _tank:IGameObject;

    public function EffectDescriptionCC(param1:EffectCategory = null, param2:int = 0, param3:IGameObject = null) {
      super();
      this._category = param1;
      this._index = param2;
      this._tank = param3;
    }

    public function get category() : EffectCategory {
      return this._category;
    }

    public function set category(param1:EffectCategory) : void {
      this._category = param1;
    }

    public function get index() : int {
      return this._index;
    }

    public function set index(param1:int) : void {
      this._index = param1;
    }

    public function get tank() : IGameObject {
      return this._tank;
    }

    public function set tank(param1:IGameObject) : void {
      this._tank = param1;
    }

    public function toString() : String {
      var local1:String = "EffectDescriptionCC [";
      local1 += "category = " + this.category + " ";
      local1 += "index = " + this.index + " ";
      local1 += "tank = " + this.tank + " ";
      return local1 + "]";
    }
  }
}
