package projects.tanks.client.battlefield.models.bonus.bonus.battlebonuses.crystal {
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;

  public class BattleGoldBonusCC {
    private var _sound:SoundResource;
    private var _sprite:TextureResource;

    public function BattleGoldBonusCC(param1:SoundResource = null, param2:TextureResource = null) {
      super();
      this._sound = param1;
      this._sprite = param2;
    }

    public function get sound() : SoundResource {
      return this._sound;
    }

    public function set sound(param1:SoundResource) : void {
      this._sound = param1;
    }

    public function get sprite() : TextureResource {
      return this._sprite;
    }

    public function set sprite(param1:TextureResource) : void {
      this._sprite = param1;
    }

    public function toString() : String {
      var local1:String = "BattleGoldBonusCC [";
      local1 += "sound = " + this.sound + " ";
      local1 += "sprite = " + this.sprite + " ";
      return local1 + "]";
    }
  }
}
