package alternativa.tanks.sound {
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.ISound3DEffect;
  import flash.media.Sound;
  import flash.media.SoundChannel;
  import flash.media.SoundTransform;

  public class DummySoundManager implements ISoundManager {
    public function DummySoundManager() {
      super();
    }

    public function set maxDistance(param1:Number) : void {
    }

    public function playSound(param1:Sound, param2:int = 0, param3:int = 0, param4:SoundTransform = null) : SoundChannel {
      return null;
    }

    public function stopSound(param1:SoundChannel) : void {
    }

    public function stopAllSounds() : void {
    }

    public function addEffect(param1:ISound3DEffect) : void {
    }

    public function removeEffect(param1:ISound3DEffect) : void {
    }

    public function removeAllEffects() : void {
    }

    public function updateSoundEffects(param1:int, param2:GameCamera) : void {
    }

    public function setMute(param1:Boolean) : void {
    }
  }
}
