package alternativa.tanks.sfx.drone {
  import flash.media.Sound;
  import platform.client.fp10.core.type.AutoClosable;
  import projects.tanks.client.battlefield.models.drone.DroneSFXCC;

  public class DroneSFXData implements AutoClosable {
    public var activationSound:Sound;

    public function DroneSFXData(param1:DroneSFXCC) {
      super();
      this.activationSound = param1.activationSound.sound;
    }

    public function close() : void {
      this.activationSound = this.activationSound;
    }
  }
}
