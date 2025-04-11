package alternativa.tanks.models.battle.battlefield {
  import alternativa.tanks.sound.ISoundManager;
  import flash.media.Sound;
  import flash.media.SoundChannel;
  import flash.media.SoundTransform;

  public class AmbientSound {
    private var sound:Sound;
    private var soundManager:ISoundManager;
    private var soundChannel:SoundChannel;

    public function AmbientSound(param1:Sound, param2:ISoundManager) {
      super();
      this.sound = param1;
      this.soundManager = param2;
    }

    public function play(param1:Boolean) : void {
      if(param1) {
        if(this.soundChannel == null) {
          this.soundChannel = this.soundManager.playSound(this.sound,0,100000,new SoundTransform(0.5));
        }
      } else if(this.soundChannel != null) {
        this.soundManager.stopSound(this.soundChannel);
        this.soundChannel = null;
      }
    }
  }
}
