package projects.tanks.client.battlefield.models.battle.pointbased.rugby {
  import platform.client.fp10.core.resource.types.SoundResource;

  public class RugbySoundFX {
    private var _ballDropNegativeSound:SoundResource;
    private var _ballDropPositiveSound:SoundResource;
    private var _ballFaceOffSound:SoundResource;
    private var _ballTakeNegativeSound:SoundResource;
    private var _ballTakePositiveSound:SoundResource;
    private var _goalNegativeSound:SoundResource;
    private var _goalPositiveSound:SoundResource;

    public function RugbySoundFX(param1:SoundResource = null, param2:SoundResource = null, param3:SoundResource = null, param4:SoundResource = null, param5:SoundResource = null, param6:SoundResource = null, param7:SoundResource = null) {
      super();
      this._ballDropNegativeSound = param1;
      this._ballDropPositiveSound = param2;
      this._ballFaceOffSound = param3;
      this._ballTakeNegativeSound = param4;
      this._ballTakePositiveSound = param5;
      this._goalNegativeSound = param6;
      this._goalPositiveSound = param7;
    }

    public function get ballDropNegativeSound() : SoundResource {
      return this._ballDropNegativeSound;
    }

    public function set ballDropNegativeSound(param1:SoundResource) : void {
      this._ballDropNegativeSound = param1;
    }

    public function get ballDropPositiveSound() : SoundResource {
      return this._ballDropPositiveSound;
    }

    public function set ballDropPositiveSound(param1:SoundResource) : void {
      this._ballDropPositiveSound = param1;
    }

    public function get ballFaceOffSound() : SoundResource {
      return this._ballFaceOffSound;
    }

    public function set ballFaceOffSound(param1:SoundResource) : void {
      this._ballFaceOffSound = param1;
    }

    public function get ballTakeNegativeSound() : SoundResource {
      return this._ballTakeNegativeSound;
    }

    public function set ballTakeNegativeSound(param1:SoundResource) : void {
      this._ballTakeNegativeSound = param1;
    }

    public function get ballTakePositiveSound() : SoundResource {
      return this._ballTakePositiveSound;
    }

    public function set ballTakePositiveSound(param1:SoundResource) : void {
      this._ballTakePositiveSound = param1;
    }

    public function get goalNegativeSound() : SoundResource {
      return this._goalNegativeSound;
    }

    public function set goalNegativeSound(param1:SoundResource) : void {
      this._goalNegativeSound = param1;
    }

    public function get goalPositiveSound() : SoundResource {
      return this._goalPositiveSound;
    }

    public function set goalPositiveSound(param1:SoundResource) : void {
      this._goalPositiveSound = param1;
    }

    public function toString() : String {
      var local1:String = "RugbySoundFX [";
      local1 += "ballDropNegativeSound = " + this.ballDropNegativeSound + " ";
      local1 += "ballDropPositiveSound = " + this.ballDropPositiveSound + " ";
      local1 += "ballFaceOffSound = " + this.ballFaceOffSound + " ";
      local1 += "ballTakeNegativeSound = " + this.ballTakeNegativeSound + " ";
      local1 += "ballTakePositiveSound = " + this.ballTakePositiveSound + " ";
      local1 += "goalNegativeSound = " + this.goalNegativeSound + " ";
      local1 += "goalPositiveSound = " + this.goalPositiveSound + " ";
      return local1 + "]";
    }
  }
}
