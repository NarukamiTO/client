package alternativa.tanks.sfx.drone {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.utils.GraphicsUtils;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battlefield.models.drone.demoman.DroneExplosionModelBase;
  import projects.tanks.client.battlefield.models.drone.demoman.IDroneExplosionModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;

  [ModelInfo]
  public class DroneExplosionModel extends DroneExplosionModelBase implements IDroneExplosionModelBase, ObjectLoadListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    private static const EXPLOSION_OFFSET_TO_CAMERA:Number = 110;

    private var textureAnimation:TextureAnimation;

    public function DroneExplosionModel() {
      super();
    }

    public function objectLoaded() : void {
      this.textureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,getInitParam().explosionTexture);
    }

    public function addExplosionEffect(param1:Vector3d, param2:Number) : void {
      var local3:AnimatedSpriteEffect = AnimatedSpriteEffect(battleService.getObjectPool().getObject(AnimatedSpriteEffect));
      local3.init(param2 * 2,param2 * 2,this.textureAnimation,0,this.createPositionProvider(new Vector3(param1.x,param1.y,param1.z)),0.5,0.75);
      battleService.addGraphicEffect(local3);
    }

    private function createPositionProvider(param1:Vector3) : StaticObject3DPositionProvider {
      var local2:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      local2.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
      return local2;
    }
  }
}
