package alternativa.tanks.models.weapon.healing {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.sfx.MuzzlePositionProvider;
  import alternativa.tanks.sfx.OmniStreamLightEffect;
  import alternativa.tanks.sfx.TubeLightEffect;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisState;

  public class HealingGunEffectsImpl implements HealingGunEffects {
    private var battleService:BattleService;
    private var sfxData:HealingGunSFXData;
    private var turret:Object3D;
    private var localSourcePosition:Vector3;
    private var localHullMeshPosition:Vector3 = new Vector3();
    private var graphicEffect:HealingGunGraphicEffect;
    private var soundEffect:HealingGunSoundEffect;
    private var lightEffect:OmniStreamLightEffect;
    private var beamEffect:TubeLightEffect;
    private var stateLightEffectCreatedFor:IsisState;
    private var buffedMode:Boolean;

    public function HealingGunEffectsImpl(param1:BattleService, param2:HealingGunSFXData) {
      super();
      this.battleService = param1;
      this.sfxData = param2;
    }

    public function init(param1:Object3D, param2:Vector3) : void {
      this.turret = param1;
      this.localSourcePosition = param2.clone();
    }

    public function setLocalEffectsType(param1:IsisState, param2:Tank = null, param3:Vector3 = null) : void {
      this.createEffectsIfNecessary(true,param1);
      this.setGraphicEffectType(param1,param2,param3);
      this.soundEffect.type = param1;
    }

    public function setRemoteEffectsType(param1:IsisState, param2:Tank = null, param3:Vector3 = null) : void {
      this.createEffectsIfNecessary(false,param1);
      this.setGraphicEffectType(param1,param2,param3);
      this.soundEffect.type = param1;
    }

    private function createEffectsIfNecessary(param1:Boolean, param2:IsisState) : void {
      if(this.graphicEffect == null) {
        this.createGraphicEffect(param1);
        this.createSoundEffect();
        this.createLightEffect(param2);
      } else if(param2 != this.stateLightEffectCreatedFor) {
        this.createLightEffect(param2);
      }
    }

    private function createLightEffect(param1:IsisState) : void {
      if(this.lightEffect != null) {
        this.stopLightEffect();
      }
      this.lightEffect = OmniStreamLightEffect(this.battleService.getObjectPool().getObject(OmniStreamLightEffect));
      var local2:MuzzlePositionProvider = MuzzlePositionProvider(this.battleService.getObjectPool().getObject(MuzzlePositionProvider));
      local2.init(this.turret,this.localSourcePosition);
      switch(param1) {
        case IsisState.DAMAGING:
          this.lightEffect.init(local2,this.sfxData.enemyStartLightAnimation,this.sfxData.enemyLoopLightAnimation);
          break;
        case IsisState.HEALING:
          this.lightEffect.init(local2,this.sfxData.friendStartLightAnimation,this.sfxData.friendLoopLightAnimation);
          break;
        default:
          this.lightEffect.init(local2,this.sfxData.startLightAnimation,this.sfxData.loopLightAnimation);
      }
      this.stateLightEffectCreatedFor = param1;
      this.battleService.addGraphicEffect(this.lightEffect);
    }

    private function stopLightEffect() : void {
      this.lightEffect.stop();
      this.lightEffect = null;
    }

    private function createGraphicEffect(param1:Boolean) : void {
      this.graphicEffect = HealingGunGraphicEffect(this.battleService.getObjectPool().getObject(HealingGunGraphicEffect));
      if(param1) {
        this.graphicEffect.initLocal(this.sfxData,this.turret,this.localSourcePosition);
      } else {
        this.graphicEffect.initRemote(this.sfxData,this.turret,this.localSourcePosition);
      }
      this.graphicEffect.setBuffedMode(this.buffedMode);
      this.battleService.addGraphicEffect(this.graphicEffect);
    }

    private function createSoundEffect() : void {
      this.soundEffect = HealingGunSoundEffect(this.battleService.getObjectPool().getObject(HealingGunSoundEffect));
      this.soundEffect.init(this.sfxData,this.turret);
      this.battleService.addSound3DEffect(this.soundEffect);
    }

    private function setGraphicEffectType(param1:IsisState, param2:Tank, param3:Vector3) : void {
      var local4:Mesh = null;
      if(param1 == IsisState.IDLE) {
        this.graphicEffect.setMode(param1);
      } else {
        local4 = param2.getHullMesh();
        this.localHullMeshPosition.copy(param3);
        this.localHullMeshPosition.subtract(param2.getSkinCenterOffset());
        this.graphicEffect.setMode(param1,local4,this.localHullMeshPosition);
      }
      this.createBeamLight(param1,param2,this.localHullMeshPosition);
    }

    private function createBeamLight(param1:IsisState, param2:Tank, param3:Vector3) : void {
      if(this.beamEffect != null) {
        this.beamEffect.kill();
        this.beamEffect = null;
      }
      if(param1 == IsisState.IDLE || param1 == IsisState.OFF) {
        return;
      }
      var local4:MuzzlePositionProvider = MuzzlePositionProvider(this.battleService.getObjectPool().getObject(MuzzlePositionProvider));
      var local5:MuzzlePositionProvider = MuzzlePositionProvider(this.battleService.getObjectPool().getObject(MuzzlePositionProvider));
      local4.init(this.turret,this.localSourcePosition);
      local5.init(param2.getHullMesh(),param3);
      this.beamEffect = TubeLightEffect(this.battleService.getObjectPool().getObject(TubeLightEffect));
      switch(param1) {
        case IsisState.DAMAGING:
          this.beamEffect.init(local4,local5,this.sfxData.enemyBeamAnimation,true);
          break;
        case IsisState.HEALING:
          this.beamEffect.init(local4,local5,this.sfxData.friendBeamAnimation,true);
      }
      this.battleService.addGraphicEffect(this.beamEffect);
    }

    public function stopEffects() : void {
      if(this.graphicEffect != null) {
        this.graphicEffect.stop();
        this.soundEffect.kill();
        this.lightEffect.stop();
        if(this.beamEffect != null) {
          this.beamEffect.kill();
        }
        this.graphicEffect = null;
        this.soundEffect = null;
        this.lightEffect = null;
        this.beamEffect = null;
      }
    }

    public function setBuffedMode(param1:Boolean) : void {
      this.buffedMode = param1;
      if(this.graphicEffect != null) {
        this.graphicEffect.setBuffedMode(param1);
      }
    }
  }
}
