package alternativa.tanks.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Decal;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class DecalEffect extends PooledObject implements GraphicEffect {
    [Inject]
    public static var battleService:BattleService;

    private var decal:Decal;
    private var position:Vector3 = new Vector3();
    private var projectionOrigin:Vector3 = new Vector3();
    private var material:TextureMaterial;
    private var radius:Number;
    private var lifeTime:int;
    private var fadeTime:int;
    private var fadeTimeLeft:int;

    public function DecalEffect(param1:Pool) {
      super(param1);
    }

    public function init(param1:Vector3, param2:TextureMaterial, param3:Vector3, param4:Number, param5:int, param6:int) : void {
      this.position.copy(param1);
      this.projectionOrigin.copy(param3);
      this.radius = param4;
      this.material = param2;
      this.lifeTime = param5;
      this.fadeTime = param6;
      this.fadeTimeLeft = param6;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.decal = battleService.getBattleScene3D().addPermanentDecal(this.position,this.projectionOrigin,this.radius,this.material);
      if(this.decal == null) {
        this.kill();
      }
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(this.fadeTimeLeft > 0) {
        if(this.lifeTime > 0) {
          this.lifeTime -= param1;
        } else {
          this.fadeTimeLeft -= param1;
          if(this.decal != null) {
            this.decal.alpha = this.fadeTimeLeft / this.fadeTime;
          }
        }
        return true;
      }
      return false;
    }

    public function destroy() : void {
      if(this.decal != null) {
        battleService.getBattleScene3D().removeDecal(this.decal);
        this.decal = null;
      }
      this.material = null;
      recycle();
    }

    public function kill() : void {
      this.fadeTimeLeft = 0;
    }
  }
}
