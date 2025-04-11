package projects.tanks.client.battlefield.models.tankparts.armor.rankup {
  import platform.client.fp10.core.resource.types.SoundResource;

  public class TankRankUpEffectCC {
    private var _rankUpSound:SoundResource;

    public function TankRankUpEffectCC(param1:SoundResource = null) {
      super();
      this._rankUpSound = param1;
    }

    public function get rankUpSound() : SoundResource {
      return this._rankUpSound;
    }

    public function set rankUpSound(param1:SoundResource) : void {
      this._rankUpSound = param1;
    }

    public function toString() : String {
      var local1:String = "TankRankUpEffectCC [";
      local1 += "rankUpSound = " + this.rankUpSound + " ";
      return local1 + "]";
    }
  }
}
