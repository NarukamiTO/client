package alternativa.tanks.models.battle.battlefield.map {
  import alternativa.engine3d.containers.KDContainer;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.objects.BSP;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.osgi.service.command.CommandService;
  import alternativa.osgi.service.command.FormattedOutput;
  import alternativa.osgi.service.console.variables.ConsoleVarInt;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.primitives.CollisionBox;
  import alternativa.physics.collision.primitives.CollisionRect;
  import alternativa.physics.collision.primitives.CollisionTriangle;
  import alternativa.physics.collision.types.AABB;
  import alternativa.proplib.PropLibRegistry;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.hidablegraphicobjects.HidableObject3DWrapper;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.sfx.christmas.ChristmasTreeToyEffect;
  import alternativa.tanks.utils.DataValidator;
  import alternativa.tanks.utils.StaticCollisionBoxValidator;
  import alternativa.tanks.utils.StaticCollisionTriangleValidator;
  import alternativa.tanks.utils.StaticCollisoinRectValidator;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BitmapData;
  import flash.events.Event;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.type.AutoClosable;

  public class MapBuilder implements AutoClosable {
    [Inject]
    public static var dataValidator:DataValidator;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var commandService:CommandService;

    private static const conMapDelay:ConsoleVarInt = new ConsoleVarInt("map_delay",0,0,600);
    private static const KDTREE_THRESHOLD:Number = 0.1;
    private static const TEXTURE_BUILDER_BATCH_SIZE:int = 20;

    private var materialRegistry:TextureMaterialRegistry;
    private var propLibRegistry:PropLibRegistry;
    private var texturesBuilder:MapTexturesBuilder;
    private var mapContainer:KDContainer;
    private var buildCompleteCallback:Function;
    private var mapBounds:AABB;
    private var textures:Vector.<BitmapData>;
    private var mapGeometryParser:MapGeometryParser;
    private var completeTimeoutId:uint;
    private var texturesReady:Boolean;
    private var isComplete:Boolean;

    public function MapBuilder(param1:TextureMaterialRegistry, param2:PropLibRegistry) {
      super();
      this.materialRegistry = param1;
      this.propLibRegistry = param2;
    }

    private function forceComplete(param1:FormattedOutput) : void {
    }

    public function getMapContainer() : Object3DContainer {
      return this.mapContainer;
    }

    public function build(param1:XML, param2:Function) : void {
      this.buildCompleteCallback = param2;
      this.initPhysicsGeometry(param1);
      this.parseMapGeometry(param1);
      this.buildTextures();
    }

    private function initPhysicsGeometry(param1:XML) : void {
      var local2:Vector.<CollisionShape> = CollisionGeometryParser.parse(param1);
      var local3:BattleRunner = battleService.getBattleRunner();
      local3.initStaticGeometry(local2);
      this.addMapValidators(local2);
    }

    private function addMapValidators(param1:Vector.<CollisionShape>) : void {
      var local2:CollisionShape = null;
      for each(local2 in param1) {
        if(local2 is CollisionBox) {
          dataValidator.addValidator(new StaticCollisionBoxValidator(CollisionBox(local2)));
        } else if(local2 is CollisionRect) {
          dataValidator.addValidator(new StaticCollisoinRectValidator(CollisionRect(local2)));
        } else if(local2 is CollisionTriangle) {
          dataValidator.addValidator(new StaticCollisionTriangleValidator(CollisionTriangle(local2)));
        }
      }
    }

    private function parseMapGeometry(param1:XML) : void {
      this.mapGeometryParser = new MapGeometryParser(this.propLibRegistry);
      this.mapGeometryParser.parse(param1);
      this.mapBounds = this.mapGeometryParser.getMapBounds();
    }

    private function buildTextures() : void {
      this.texturesBuilder = new MapTexturesBuilder(this.materialRegistry,TEXTURE_BUILDER_BATCH_SIZE);
      this.texturesBuilder.addEventListener(Event.COMPLETE,this.onTexturesReady);
      this.texturesBuilder.run(this.mapGeometryParser.getTexturedPropsCollections());
    }

    private function onTexturesReady(param1:Event) : void {
      var local2:int = 0;
      this.texturesReady = true;
      this.texturesBuilder.removeEventListener(Event.COMPLETE,this.onTexturesReady);
      this.completeTimeoutId = setTimeout(this.complete,local2);
    }

    private function complete() : void {
      this.isComplete = true;
      clearTimeout(this.completeTimeoutId);
      this.textures = this.texturesBuilder.getTextures();
      this.setupChristmasTree();
      this.createMap();
      this.setupBillboards();
      this.setupChristmasTreeToys();
      this.mapGeometryParser.clear();
      this.mapGeometryParser = null;
      this.texturesBuilder = null;
      this.materialRegistry = null;
      this.propLibRegistry = null;
      this.buildCompleteCallback();
    }

    private function setupChristmasTree() : void {
      if(this.mapGeometryParser.getChristmasTree() == null) {
        return;
      }
      (this.mapGeometryParser.getChristmasTree() as BSP).faces[0].material.alphaTestThreshold = 0.5;
    }

    private function setupChristmasTreeToys() : void {
      var local1:int = 0;
      var local2:Object3D = null;
      var local6:Vector3 = null;
      var local7:Vector3 = null;
      var local8:StaticObject3DPositionProvider = null;
      var local9:ChristmasTreeToyEffect = null;
      if(this.mapGeometryParser.getChristmasTree() == null) {
        return;
      }
      var local3:Vector.<Object3D> = this.mapGeometryParser.getChristmasTreeToys();
      var local4:int = int(local3.length);
      var local5:ObjectPool = battleService.getObjectPool();
      local6 = new Vector3();
      local1 = 0;
      while(local1 < local4) {
        local2 = local3[local1];
        local6.x += local2.x;
        local6.y += local2.y;
        local6.z += local2.z;
        local1++;
      }
      local6.x /= local4;
      local6.y /= local4;
      local6.z /= local4;
      local7 = new Vector3();
      local1 = 0;
      while(local1 < local4) {
        local2 = local3[local1];
        local7.x = local2.x;
        local7.y = local2.y;
        local7.z = local2.z;
        local8 = StaticObject3DPositionProvider(local5.getObject(StaticObject3DPositionProvider));
        local8.init(local7,150);
        local9 = ChristmasTreeToyEffect(local5.getObject(ChristmasTreeToyEffect));
        local9.init(local2 as Sprite3D,local8,local6);
        battleService.getBattleScene3D().addGraphicEffect(local9);
        local1++;
      }
    }

    private function createMap() : void {
      var local3:Object3D = null;
      this.mapContainer = new KDContainer();
      this.mapContainer.threshold = KDTREE_THRESHOLD;
      this.mapContainer.ignoreChildrenInCollider = true;
      var local1:Vector.<Object3D> = this.mapGeometryParser.getObjects();
      local1.push(new HelperMesh());
      this.mapContainer.createTree(local1,this.mapGeometryParser.getOccluders());
      var local2:BattleScene3D = battleService.getBattleScene3D();
      for each(local3 in this.mapGeometryParser.getSprites()) {
        this.mapContainer.addChild(local3);
        local2.hidableGraphicObjects.add(new HidableObject3DWrapper(local3));
      }
      this.mapContainer.calculateBounds();
      local2.setMapContainer(this.mapContainer);
    }

    private function setupBillboards() : void {
      var local3:Mesh = null;
      var local1:Vector.<Mesh> = this.mapGeometryParser.getBillboards();
      var local2:BattleScene3D = battleService.getBattleScene3D();
      for each(local3 in local1) {
        local2.addBillboard(local3);
      }
    }

    public function getMapBounds() : AABB {
      return this.mapBounds;
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      clearTimeout(this.completeTimeoutId);
      if(this.mapContainer != null) {
        this.mapContainer.destroyTree();
        this.mapContainer = null;
      }
      if(this.texturesBuilder != null) {
        this.texturesBuilder.removeEventListener(Event.COMPLETE,this.onTexturesReady);
        this.texturesBuilder.destroy();
        this.texturesBuilder = null;
      }
      if(this.mapGeometryParser != null) {
        this.mapGeometryParser.clear();
        this.mapGeometryParser = null;
      }
      this.buildCompleteCallback = null;
      this.disposeTextures();
    }

    private function disposeTextures() : void {
      var local2:BitmapData = null;
      var local1:int = 0;
      for each(local2 in this.textures) {
        local2.dispose();
        local1++;
      }
      this.textures = null;
    }
  }
}
