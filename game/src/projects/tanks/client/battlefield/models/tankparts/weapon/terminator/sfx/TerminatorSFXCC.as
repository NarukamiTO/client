package projects.tanks.client.battlefield.models.tankparts.weapon.terminator.sfx {
  import platform.client.fp10.core.resource.types.SoundResource;

  public class TerminatorSFXCC {
    private var _closedSound:SoundResource;
    private var _openedSound:SoundResource;
    private var _servoSound:SoundResource;

    public function TerminatorSFXCC(param1:SoundResource = null, param2:SoundResource = null, param3:SoundResource = null) {
      super();
      this._closedSound = param1;
      this._openedSound = param2;
      this._servoSound = param3;
    }

    public function get closedSound() : SoundResource {
      return this._closedSound;
    }

    public function set closedSound(param1:SoundResource) : void {
      this._closedSound = param1;
    }

    public function get openedSound() : SoundResource {
      return this._openedSound;
    }

    public function set openedSound(param1:SoundResource) : void {
      this._openedSound = param1;
    }

    public function get servoSound() : SoundResource {
      return this._servoSound;
    }

    public function set servoSound(param1:SoundResource) : void {
      this._servoSound = param1;
    }

    public function toString() : String {
      var local1:String = "TerminatorSFXCC [";
      local1 += "closedSound = " + this.closedSound + " ";
      local1 += "openedSound = " + this.openedSound + " ";
      local1 += "servoSound = " + this.servoSound + " ";
      return local1 + "]";
    }
  }
}
