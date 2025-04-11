package alternativa.tanks.models.drones {
  import alternativa.engine3d.core.Object3D;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.sfx.MobileSound3DEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.drone.DroneSFXData;
  import platform.client.fp10.core.type.AutoClosable;

  public class DroneEffects implements AutoClosable {
    [Inject]
    public static var battleService:BattleService;

    private var sfxData:DroneSFXData;
    private var soundEffect:MobileSound3DEffect;
    private var object3D:Object3D;

    public function DroneEffects(param1:DroneSFXData, param2:Object3D) {
      super();
      this.sfxData = param1;
      this.object3D = param2;
    }

    public function close() : void {
      this.sfxData = null;
    }

    public function playActivationSound() : void {
      this.soundEffect = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
      this.soundEffect.init(Sound3D.create(this.sfxData.activationSound),this.object3D);
      battleService.addSound3DEffect(this.soundEffect);
    }

    public function stopSound() : void {
      if(this.soundEffect != null) {
        this.soundEffect.kill();
      }
    }
  }
}
