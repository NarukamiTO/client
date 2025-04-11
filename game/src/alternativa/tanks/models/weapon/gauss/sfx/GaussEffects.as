package alternativa.tanks.models.weapon.gauss.sfx {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.gauss.GaussTurretSkin;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.aim.AimSoundEffect;
  import alternativa.tanks.sfx.MobileSound3DEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import flash.media.Sound;

  public class GaussEffects implements AimSoundEffect {
    [Inject]
    public static var battleService:BattleService;

    public static const ANTENNA_UP_SOUND_DURATION:int = 400;
    public static const ANTENNA_DOWN_SOUND_DURATION:int = 400;

    private var antennaEffect:GaussAntennaAimingEffect;
    private var weaponPlatform:WeaponPlatform;
    private var sfxData:GaussSFXData;
    private var antennaToggleSoundEffect:MobileSound3DEffect;
    private var aimingEffect:MobileSound3DEffect;

    public function GaussEffects(param1:WeaponObject, param2:GaussTurretSkin, param3:WeaponPlatform, param4:GaussSFXData) {
      super();
      this.weaponPlatform = param3;
      this.sfxData = param4;
      this.antennaEffect = new GaussAntennaAimingEffect(param2.getAntenna());
    }

    public function playAimingSoundEffect() : void {
      this.killAimingSoundEffect();
      this.aimingEffect = this.getSoundEffect();
      this.aimingEffect.init(Sound3D.create(this.sfxData.startAimingSound),this.weaponPlatform.getTurret3D());
      battleService.addSound3DEffect(this.aimingEffect);
    }

    public function playTargetLostSoundEffect() : void {
      this.killAimingSoundEffect();
      this.aimingEffect = this.getSoundEffect();
      this.aimingEffect.init(Sound3D.create(this.sfxData.targetLostSound),this.weaponPlatform.getTurret3D());
      battleService.addSound3DEffect(this.aimingEffect);
    }

    public function playTargetLockSoundEffect() : void {
      var local1:MobileSound3DEffect = this.getSoundEffect();
      local1.init(Sound3D.create(this.sfxData.targetLockSound),this.weaponPlatform.getTurret3D());
      battleService.addSound3DEffect(local1);
    }

    private function killToggleSound() : void {
      if(this.antennaToggleSoundEffect != null) {
        this.antennaToggleSoundEffect.kill();
        this.antennaToggleSoundEffect = null;
      }
    }

    public function killAimingSoundEffect() : void {
      if(this.aimingEffect != null) {
        this.aimingEffect.kill();
        this.aimingEffect = null;
      }
    }

    public function playOpenEffect() : void {
      this.killToggleSound();
      this.antennaEffect.turnOn();
      this.playAntennaToggleSound(this.sfxData.antennaUpSound,ANTENNA_UP_SOUND_DURATION);
    }

    public function playHideEffect() : void {
      this.killToggleSound();
      this.antennaEffect.turnOff();
      this.playAntennaToggleSound(this.sfxData.antennaDownSound,ANTENNA_DOWN_SOUND_DURATION);
    }

    private function playAntennaToggleSound(param1:Sound, param2:int) : void {
      this.antennaToggleSoundEffect = this.getSoundEffect();
      var local3:int = param2 - this.antennaEffect.getRemainingTimeMs();
      this.antennaToggleSoundEffect.init(Sound3D.create(param1),this.weaponPlatform.getTurret3D(),0,1,local3);
      battleService.addSound3DEffect(this.antennaToggleSoundEffect);
    }

    public function playSoundEffect(param1:Sound, param2:Vector3) : void {
      battleService.addSound3DEffect(Sound3DEffect.create(param2,Sound3D.create(param1)));
    }

    private function getSoundEffect() : MobileSound3DEffect {
      return MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
    }

    public function playCommonShotEffect(param1:Vector3, param2:Vector3, param3:WeaponForces) : void {
      this.weaponPlatform.getBody().addWorldForceScaled(param1,param2,-param3.getRecoilForce());
      this.weaponPlatform.addDust();
      var local4:GaussMuzzleEffect = this.getMuzzleEffect();
      local4.init(this.sfxData,this.weaponPlatform);
      battleService.addGraphicEffect(local4);
    }

    public function playPowerShotEffect(param1:Body, param2:Vector3) : void {
      var local3:GaussPowerShotEffect = this.getPowerShotEffect();
      local3.init(this.sfxData,this.weaponPlatform,param1,param2);
      battleService.addGraphicEffect(local3);
    }

    private function getObjectPool() : ObjectPool {
      return battleService.getObjectPool();
    }

    private function getMuzzleEffect() : GaussMuzzleEffect {
      return GaussMuzzleEffect(this.getObjectPool().getObject(GaussMuzzleEffect));
    }

    private function getPowerShotEffect() : GaussPowerShotEffect {
      return GaussPowerShotEffect(battleService.getObjectPool().getObject(GaussPowerShotEffect));
    }

    public function reset() : void {
      this.antennaEffect.reset();
    }
  }
}
