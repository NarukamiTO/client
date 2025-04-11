package alternativa.tanks.models.weapon.terminator.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.tank.LocalTankInfoService;
  import alternativa.tanks.models.weapon.railgun.IRailgunEffects;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherEffects;
  import alternativa.tanks.models.weapon.terminator.*;
  import alternativa.tanks.sfx.MobileSound3DEffect;
  import alternativa.tanks.sfx.Sound3D;
  import platform.client.fp10.core.type.AutoClosable;

  public class TerminatorEffects implements AutoClosable, TerminatorToggleCallback {
    [Inject]
    public static var localTankService:LocalTankInfoService;

    [Inject]
    public static var battleService:BattleService;

    private var recoilEffect:Array;
    private var openEffect:TerminatorOpenEffect;
    private var weaponObject:TerminatorObject;
    private var _rocketLauncherEffects:RocketLauncherEffects;
    private var _railgunEffects:IRailgunEffects;
    private var sfxData:TerminatorSFXData;
    private var turret3D:Object3D;
    private var soundEffect:MobileSound3DEffect;
    private var effectsState:int = 1;

    public function TerminatorEffects(param1:TerminatorObject, param2:TerminatorSFXData, param3:Object3D, param4:RocketLauncherEffects, param5:IRailgunEffects) {
      super();
      this.weaponObject = param1;
      this.sfxData = param2;
      this.turret3D = param3;
      this._rocketLauncherEffects = param4;
      this._railgunEffects = param5;
      this.recoilEffect = [new TerminatorRecoilEffect(param1.getSkin().getBarrel3DByIndex(0)),new TerminatorRecoilEffect(param1.getSkin().getBarrel3DByIndex(1))];
      this.openEffect = new TerminatorOpenEffect(param1.getSkin().getLeftBox3D(),param1.getSkin().getRightBox3D(),this);
    }

    public function createRecoilEffect(param1:int) : void {
      this.recoilEffect[param1].run(param1);
    }

    public function createOpenEffect() : void {
      this.effectsState = TerminatorEffectsState.OPENING;
      this.openEffect.turnOn();
      this.playServoSoundEffect();
    }

    public function createHideEffect() : void {
      if(this.effectsState == TerminatorEffectsState.OPENED || this.effectsState == TerminatorEffectsState.OPENING) {
        this.effectsState = TerminatorEffectsState.CLOSING;
        this.openEffect.turnOff();
        this.playServoSoundEffect();
      }
    }

    private function stopToggleSound() : void {
      if(this.soundEffect != null) {
        this.soundEffect.kill();
      }
    }

    private function playOpenedSound() : void {
      this.stopToggleSound();
      this.soundEffect = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
      this.soundEffect.init(Sound3D.create(this.sfxData.openedSound),this.turret3D);
      battleService.addSound3DEffect(this.soundEffect);
    }

    private function playClosedSound() : void {
      this.stopToggleSound();
      this.soundEffect = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
      this.soundEffect.init(Sound3D.create(this.sfxData.closedSound),this.turret3D);
      battleService.addSound3DEffect(this.soundEffect);
    }

    private function playServoSoundEffect() : void {
      this.stopToggleSound();
      this.soundEffect = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
      this.soundEffect.init(Sound3D.create(this.sfxData.servoSound),this.turret3D);
      battleService.addSound3DEffect(this.soundEffect);
    }

    public function close() : void {
      this.stopToggleSound();
      this.openEffect.destroy();
      this.weaponObject = null;
      this.recoilEffect = null;
      this.openEffect = null;
      this._rocketLauncherEffects = null;
      this._railgunEffects = null;
    }

    public function reset() : void {
      this.stopToggleSound();
      this.openEffect.reset();
      this.effectsState = TerminatorEffectsState.CLOSED;
      this.recoilEffect[0].reset();
      this.recoilEffect[1].reset();
    }

    public function get rocketLauncherEffects() : RocketLauncherEffects {
      return this._rocketLauncherEffects;
    }

    public function get railgunEffects() : IRailgunEffects {
      return this._railgunEffects;
    }

    public function onOpened() : void {
      this.effectsState = TerminatorEffectsState.OPENED;
      this.playOpenedSound();
    }

    public function onClosed() : void {
      this.effectsState = TerminatorEffectsState.CLOSED;
      this.playClosedSound();
    }

    public function forceClosing() : void {
      this.createHideEffect();
    }
  }
}
