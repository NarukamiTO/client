package alternativa.tanks.models.weapon.artillery.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import platform.client.fp10.core.type.AutoClosable;

  public class ArtilleryTrailEffect extends PooledObject implements AutoClosable {
    [Inject]
    public static var battleService:BattleService;

    private static const SMOKE_INTERVAL:Number = 0.001;

    private var smokeTime:Number;
    private var shellMesh:Mesh;
    private var smokeMaterial:TextureMaterial;

    public function ArtilleryTrailEffect(param1:Pool) {
      super(param1);
    }

    public function init(param1:Mesh, param2:ArtillerySfxData) : void {
      this.shellMesh = param1;
      this.smokeMaterial = param2.trail;
      this.smokeTime = 0;
    }

    public function update(param1:Number) : void {
      var local2:ArtillerySmoke = null;
      this.smokeTime += param1;
      if(this.smokeTime >= SMOKE_INTERVAL) {
        local2 = ArtillerySmoke(battleService.getObjectPool().getObject(ArtillerySmoke));
        local2.init(this.shellMesh,this.smokeMaterial);
        battleService.addGraphicEffect(local2);
        this.smokeTime = 0;
      }
    }

    public function close() : void {
      this.shellMesh = null;
      this.smokeMaterial = null;
      recycle();
    }
  }
}
