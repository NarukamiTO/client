package projects.tanks.client.battlefield.models.effects.activationsfx {
  public class TankEffectSFXCC {
    private var _effects:Vector.<EffectSFXRecordCC>;

    public function TankEffectSFXCC(param1:Vector.<EffectSFXRecordCC> = null) {
      super();
      this._effects = param1;
    }

    public function get effects() : Vector.<EffectSFXRecordCC> {
      return this._effects;
    }

    public function set effects(param1:Vector.<EffectSFXRecordCC>) : void {
      this._effects = param1;
    }

    public function toString() : String {
      var local1:String = "TankEffectSFXCC [";
      local1 += "effects = " + this.effects + " ";
      return local1 + "]";
    }
  }
}
