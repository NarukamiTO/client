package alternativa.tanks.models.weapon.terminator.sfx {
  import flash.media.Sound;
  import platform.client.fp10.core.type.AutoClosable;
  import projects.tanks.client.battlefield.models.tankparts.weapon.terminator.sfx.TerminatorSFXCC;

  public class TerminatorSFXData implements AutoClosable {
    public var servoSound:Sound;
    public var openedSound:Sound;
    public var closedSound:Sound;

    public function TerminatorSFXData(param1:TerminatorSFXCC) {
      super();
      this.servoSound = param1.servoSound.sound;
      this.openedSound = param1.openedSound.sound;
      this.closedSound = param1.closedSound.sound;
    }

    public function close() : void {
      this.servoSound = null;
      this.openedSound = null;
      this.closedSound = null;
    }
  }
}
