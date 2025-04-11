package alternativa.tanks.sound {
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.ISound3DEffect;
  import flash.events.Event;
  import flash.media.Sound;
  import flash.media.SoundChannel;
  import flash.media.SoundTransform;
  import flash.utils.Dictionary;

  public class SoundManager implements ISoundManager {
    private static const MAX_SOUNDS:int = 10;
    private static const MAX_SOUNDS_3D:int = 21;
    private static const _position:Vector3 = new Vector3();

    private var effects:Vector.<SoundEffectData> = new Vector.<SoundEffectData>();
    private var numEffects:int;
    private var sounds:Dictionary = new Dictionary();
    private var numSounds:int;
    private var mute:Boolean;

    public function SoundManager() {
      super();
    }

    public static function createSoundManager(param1:Sound) : ISoundManager {
      var local2:SoundChannel = param1.play(0,1,new SoundTransform(0));
      if(local2 != null) {
        local2.stop();
        return new SoundManager();
      }
      return new DummySoundManager();
    }

    public function setMute(param1:Boolean) : void {
      this.mute = param1;
    }

    public function playSound(param1:Sound, param2:int = 0, param3:int = 0, param4:SoundTransform = null) : SoundChannel {
      var local5:SoundChannel = null;
      if(this.canPlaySound(param1)) {
        local5 = param1.play(param2,param3,param4);
        if(local5 != null) {
          this.addSoundChannel(local5);
        }
        return local5;
      }
      return null;
    }

    private function canPlaySound(param1:Sound) : Boolean {
      return !this.mute && this.numSounds < MAX_SOUNDS && param1 != null;
    }

    public function stopSound(param1:SoundChannel) : void {
      if(param1 != null && this.sounds[param1] != null) {
        this.removeSoundChannel(param1);
      }
    }

    public function stopAllSounds() : void {
      var local1:* = undefined;
      for(local1 in this.sounds) {
        this.removeSoundChannel(local1 as SoundChannel);
      }
    }

    public function addEffect(param1:ISound3DEffect) : void {
      if(this.canAddEffect(param1)) {
        param1.enabled = true;
        this.effects.push(SoundEffectData.create(0,param1));
        ++this.numEffects;
      }
    }

    private function canAddEffect(param1:ISound3DEffect) : Boolean {
      return !this.mute && param1 != null && this.getEffectIndex(param1) < 0;
    }

    public function removeEffect(param1:ISound3DEffect) : void {
      var local3:SoundEffectData = null;
      var local2:int = 0;
      while(local2 < this.numEffects) {
        local3 = this.effects[local2];
        if(local3.effect == param1) {
          param1.destroy();
          SoundEffectData.destroy(local3);
          this.effects.splice(local2,1);
          --this.numEffects;
          return;
        }
        local2++;
      }
    }

    public function removeAllEffects() : void {
      var local1:SoundEffectData = null;
      while(this.effects.length > 0) {
        local1 = this.effects.pop();
        local1.effect.destroy();
        SoundEffectData.destroy(local1);
      }
      this.numEffects = 0;
    }

    public function updateSoundEffects(param1:int, param2:GameCamera) : void {
      var local3:int = 0;
      if(this.numEffects > 0) {
        this.sortEffects(param2.position);
        local3 = this.processEffectsInActiveRange(param1,param2);
        this.deactivateRemainingEffects(local3);
      }
    }

    private function processEffectsInActiveRange(param1:int, param2:GameCamera) : int {
      var local3:SoundEffectData = null;
      var local5:int = 0;
      var local6:int = 0;
      var local4:int = 0;
      local5 = 0;
      while(local5 < this.numEffects) {
        local3 = this.effects[local5];
        local6 = int(local3.effect.numSounds);
        if(local6 == 0) {
          local3.effect.destroy();
          SoundEffectData.destroy(local3);
          this.effects.splice(local5,1);
          --this.numEffects;
          local5--;
        } else if(local4 + local6 > MAX_SOUNDS_3D) {
          if(local4 == MAX_SOUNDS_3D) {
            break;
          }
          local3.effect.enabled = false;
        } else {
          local3.effect.enabled = true;
          local3.effect.play(param1,param2);
          local4 += local6;
        }
        local5++;
      }
      return local5;
    }

    private function deactivateRemainingEffects(param1:int) : void {
      var local3:SoundEffectData = null;
      var local2:int = param1;
      while(local2 < this.numEffects) {
        local3 = this.effects[local2];
        local3.effect.enabled = false;
        if(local3.effect.numSounds == 0) {
          local3.effect.destroy();
          SoundEffectData.destroy(local3);
          this.effects.splice(local2,1);
          --this.numEffects;
          local2--;
        }
        local2++;
      }
    }

    private function addSoundChannel(param1:SoundChannel) : void {
      param1.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
      this.sounds[param1] = true;
      ++this.numSounds;
    }

    private function removeSoundChannel(param1:SoundChannel) : void {
      param1.stop();
      param1.removeEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
      delete this.sounds[param1];
      --this.numSounds;
    }

    private function onSoundComplete(param1:Event) : void {
      this.stopSound(param1.target as SoundChannel);
    }

    private function getEffectIndex(param1:ISound3DEffect) : int {
      var local3:SoundEffectData = null;
      var local2:int = 0;
      while(local2 < this.numEffects) {
        local3 = this.effects[local2];
        if(local3.effect == param1) {
          return local2;
        }
        local2++;
      }
      return -1;
    }

    private function sortEffects(param1:Vector3) : void {
      var cameraPos:Vector3 = param1;
      this.updateDistancesToEffects(cameraPos);
      this.effects.sort(function(param1:SoundEffectData, param2:SoundEffectData):Number {
        return param1.distanceSqr - param2.distanceSqr;
      });
    }

    private function updateDistancesToEffects(param1:Vector3) : void {
      var local3:SoundEffectData = null;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local2:int = 0;
      while(local2 < this.numEffects) {
        local3 = this.effects[local2];
        local3.effect.readPosition(_position);
        local4 = param1.x - _position.x;
        local5 = param1.y - _position.y;
        local6 = param1.z - _position.z;
        local3.distanceSqr = local4 * local4 + local5 * local5 + local6 * local6;
        local2++;
      }
    }
  }
}
