package alternativa.tanks.models.tank.ultimate.hunter {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.TankControlLockBits;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.TankSet;
  import alternativa.tanks.models.tank.hullcommon.HullCommon;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.utils.TextureMaterialRegistry;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battlefield.models.ultimate.effects.hunter.ITankStunModelBase;
  import projects.tanks.client.battlefield.models.ultimate.effects.hunter.TankStunModelBase;

  [ModelInfo]
  public class TankStunModel extends TankStunModelBase implements ITankStunModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var battleService:BattleService;

    public function TankStunModel() {
      super();
    }

    public function objectLoadedPost() : void {
      if(getInitParam().stunned) {
        this.stun();
      }
    }

    public function stun() : void {
      var local1:ITankModel = this.getTankModel();
      var local2:TankSet = local1.getTankSet();
      var local3:Tank = local1.getTank();
      var local4:Boolean = Boolean(local1.isLocal());
      var local5:HullCommon = HullCommon(local2.hull.adapt(HullCommon));
      var local6:Sound3D = Sound3D.create(local5.getStunSound());
      var local7:TextureMaterial = textureMaterialRegistry.getMaterial(local5.getStunEffectTexture());
      var local8:Mesh = local3.getSkin().getHullMesh();
      var local9:ElectroEffect = ElectroEffect(battleService.getObjectPool().getObject(ElectroEffect));
      local9.init(local7,local8,local6);
      battleService.addGraphicEffect(local9);
      putData(ElectroEffect,local9);
      local3.stunned = true;
      UltimateStunListener(local2.turret.event(UltimateStunListener)).onStun(local3,local4);
      UltimateStunListener(object.event(UltimateStunListener)).onStun(local3,local4);
      this.getTankModel().lockMovementControl(TankControlLockBits.STUN);
      this.getTankModel().getWeaponController().lockWeapon(TankControlLockBits.STUN,false);
    }

    public function calm(param1:int) : void {
      var local2:ITankModel = this.getTankModel();
      var local3:TankSet = local2.getTankSet();
      var local4:Tank = local2.getTank();
      var local5:Boolean = Boolean(local2.isLocal());
      this.stopElectroEffect();
      local4.stunned = false;
      UltimateStunListener(local3.turret.event(UltimateStunListener)).onCalm(local4,local5,param1);
      UltimateStunListener(object.event(UltimateStunListener)).onCalm(local4,local5,param1);
      this.getTankModel().unlockMovementControl(TankControlLockBits.STUN);
      this.getTankModel().getWeaponController().unlockWeapon(TankControlLockBits.STUN);
    }

    private function stopElectroEffect() : void {
      var local1:ElectroEffect = ElectroEffect(getData(ElectroEffect));
      if(local1 != null) {
        local1.stop();
        clearData(ElectroEffect);
      }
    }

    private function getTankModel() : ITankModel {
      return ITankModel(object.adapt(ITankModel));
    }

    public function objectUnloaded() : void {
      this.stopElectroEffect();
    }
  }
}
