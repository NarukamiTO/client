package alternativa.tanks.models.controlpoints.sound {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import flash.media.Sound;

  public class KeyPointSoundEffects {
    private var battleService:BattleService;
    private var activationSound:Sound;
    private var deactivationSound:Sound;
    private var activationSoundEffect:KeyPointSoundEffect;
    private var deactivationSoundEffect:KeyPointSoundEffect;

    public function KeyPointSoundEffects(param1:BattleService, param2:Sound, param3:Sound) {
      super();
      this.battleService = param1;
      this.activationSound = param2;
      this.deactivationSound = param3;
    }

    public function playActivationSound(param1:Vector3) : void {
      this.stopDeactivationSoundEffect();
      if(this.activationSoundEffect == null) {
        this.activationSoundEffect = KeyPointSoundEffect(this.battleService.getObjectPool().getObject(KeyPointSoundEffect));
        this.activationSoundEffect.init(this.activationSound,param1);
        this.battleService.getBattleRunner().getSoundManager().addEffect(this.activationSoundEffect);
      }
    }

    public function playDeactivationSound(param1:Vector3) : void {
      this.stopActivationSoundEffect();
      if(this.deactivationSoundEffect == null) {
        this.deactivationSoundEffect = KeyPointSoundEffect(this.battleService.getObjectPool().getObject(KeyPointSoundEffect));
        this.deactivationSoundEffect.init(this.deactivationSound,param1);
        this.battleService.getBattleRunner().getSoundManager().addEffect(this.deactivationSoundEffect);
      }
    }

    public function stopSound() : void {
      this.stopActivationSoundEffect();
      this.stopDeactivationSoundEffect();
    }

    private function stopDeactivationSoundEffect() : void {
      if(this.deactivationSoundEffect != null) {
        this.deactivationSoundEffect.kill();
        this.deactivationSoundEffect = null;
      }
    }

    private function stopActivationSoundEffect() : void {
      if(this.activationSoundEffect != null) {
        this.activationSoundEffect.kill();
        this.activationSoundEffect = null;
      }
    }
  }
}
