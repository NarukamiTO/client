package alternativa.tanks.models.battle.battlefield.mine {
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.osgi.service.dump.IDumpService;
  import alternativa.osgi.service.dump.IDumper;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankLoadedEvent;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.battle.battlefield.BattleSfx;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.models.weapon.WeaponConst;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.LightAnimation;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.utils.GraphicsUtils;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import alternativa.types.Long;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.media.Sound;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.battlefield.mine.BattleMine;
  import projects.tanks.client.battlefield.models.battle.battlefield.mine.BattleMinesModelBase;
  import projects.tanks.client.battlefield.models.battle.battlefield.mine.IBattleMinesModelBase;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  [ModelInfo]
  public class BattleMinesModel extends BattleMinesModelBase implements IBattleMinesModelBase, ObjectLoadListener, ObjectUnloadListener, IDumper, IMineCallback, IBattleMinesModel {
    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var dumperService:IDumpService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private static const MAIN_EXPLOSION_ORIGIN_X:Number = 0.5;
    private static const MAIN_EXPLOSION_ORIGIN_Y:Number = 0.772;
    private static const IDLE_EXPLOSION_ORIGIN_X:Number = 0.5;
    private static const IDLE_EXPLOSION_ORIGIN_Y:Number = 0.9;
    private static const MAIN_EXPLOSION_SCALE:Number = 3;
    private static const IDLE_EXPLOSION_SCALE:Number = 3;
    private static const MINE_ACTIVATION_SOUND_VOLUME:Number = 0.3;
    private static const DECAL_RADIUS:Number = 200;
    private static const projectionOrigin:Vector3 = new Vector3();

    private var mineModelData:MineModelData = new MineModelData();
    private var minesByUser:Dictionary = new Dictionary();
    private var minesOnField:Dictionary = new Dictionary();
    private var mineProximityRadius:Number;
    private var deferredMines:Vector.<BattleMine>;
    private var redMineMaterial:TextureMaterial;
    private var blueMineMaterial:TextureMaterial;
    private var friendlyMineMaterial:TextureMaterial;
    private var enemyMineMaterial:TextureMaterial;
    private var referenceMesh:Mesh;
    private var mainExplosionAnimation:TextureAnimation;
    private var mainExplosionFrameSize:FrameSize = new FrameSize();
    private var idleExplosionAnimation:TextureAnimation;
    private var idleExplosionFrameSize:FrameSize = new FrameSize();
    private var explosionMarkMaterial:TextureMaterial;
    private var mineArmedSound:Sound;
    private var explosionSound:Sound;
    private var deactivationSound:Sound;
    private var impactForce:Number;
    private var battleObject:IGameObject;
    private var battleEventSupport:BattleEventSupport;
    private var loadedTanks:Dictionary = new Dictionary();
    private var localTank:Tank;
    private var minDistanceFromBase:Number;
    private var explosionLightAnimation:LightAnimation;

    public function BattleMinesModel() {
      super();
      MineExplosionCameraEffect.initVars();
      this.initBattleEventListeners();
    }

    private static function addExplosionEffect(param1:Vector3, param2:TextureAnimation, param3:FrameSize, param4:Number, param5:Number) : void {
      var local6:int = 50;
      var local7:ObjectPool = battleService.getObjectPool();
      var local8:StaticObject3DPositionProvider = StaticObject3DPositionProvider(local7.getObject(StaticObject3DPositionProvider));
      local8.init(param1,local6);
      var local9:AnimatedSpriteEffect = AnimatedSpriteEffect(local7.getObject(AnimatedSpriteEffect));
      local9.init(param3.width,param3.height,param2,0,local8,param4,param5);
      battleService.getBattleScene3D().addGraphicEffect(local9);
    }

    private static function addSound3DEffect(param1:Sound, param2:Vector3, param3:Number) : void {
      var local4:Sound3D = null;
      if(param1 != null) {
        local4 = Sound3D.create(param1,param3);
        battleService.getBattleRunner().getSoundManager().addEffect(Sound3DEffect.create(param2,local4,0));
      }
    }

    private static function getExplosionAnimation(param1:MultiframeTextureResource, param2:int, param3:FrameSize) : TextureAnimation {
      var local4:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(textureMaterialRegistry,param1);
      local4.material.resolution = param2;
      param3.height = param1.frameHeight * param2;
      param3.width = param1.frameWidth * param2;
      return local4;
    }

    private static function getTextureMaterial(param1:TextureResource) : TextureMaterial {
      return textureMaterialRegistry.getMaterial(param1.data);
    }

    private function initBattleEventListeners() : void {
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
      this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
      this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.activateHandlers();
    }

    public function getMinDistanceFromBase() : Number {
      return this.minDistanceFromBase;
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      this.battleObject = object;
      dumperService.registerDumper(this);
      this.mineModelData.armedFlashDuration = 100;
      this.mineModelData.armedFlashFadeDuration = 300;
      this.mineModelData.flashChannelOffset = 204;
      this.mineModelData.farRadius = BattleUtils.toClientScale(getInitParam().farVisibilityRadius);
      this.mineModelData.nearRadius = BattleUtils.toClientScale(getInitParam().nearVisibilityRadius);
      this.mineProximityRadius = BattleUtils.toClientScale(getInitParam().radius);
      this.impactForce = getInitParam().impactForce;
      this.mineArmedSound = getInitParam().activateSound.sound;
      this.explosionSound = getInitParam().explosionSound.sound;
      this.deactivationSound = getInitParam().deactivateSound.sound;
      this.minDistanceFromBase = BattleUtils.toClientScale(getInitParam().minDistanceFromBase);
      this.initReferenceMesh(Tanks3DSResource(getInitParam().model3ds));
      this.mainExplosionAnimation = getExplosionAnimation(getInitParam().mainExplosionTexture,MAIN_EXPLOSION_SCALE,this.mainExplosionFrameSize);
      this.idleExplosionAnimation = getExplosionAnimation(getInitParam().idleExplosionTexture,IDLE_EXPLOSION_SCALE,this.idleExplosionFrameSize);
      this.explosionMarkMaterial = getTextureMaterial(getInitParam().explosionMarkTexture);
      this.redMineMaterial = getTextureMaterial(getInitParam().redMineTexture);
      this.blueMineMaterial = getTextureMaterial(getInitParam().blueMineTexture);
      this.friendlyMineMaterial = getTextureMaterial(getInitParam().friendlyMineTexture);
      this.enemyMineMaterial = getTextureMaterial(getInitParam().enemyMineTexture);
      var local1:LightingSfx = BattleSfx(object.adapt(BattleSfx)).getLightingSfx();
      this.explosionLightAnimation = local1.createAnimation("explosion");
      this.initMines(getInitParam().battleMines);
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      dumperService.unregisterDumper(this.dumperName);
      this._removeAllMines();
      this.mineArmedSound = null;
      this.mainExplosionAnimation = null;
      this.idleExplosionAnimation = null;
      this.redMineMaterial = null;
      this.blueMineMaterial = null;
      this.friendlyMineMaterial = null;
      this.enemyMineMaterial = null;
      this.battleObject = null;
      this.localTank = null;
      this.explosionMarkMaterial = null;
      this.loadedTanks = new Dictionary();
    }

    private function initMines(param1:Vector.<BattleMine>) : void {
      var local2:int = 0;
      var local3:int = 0;
      if(param1.length != 0) {
        if(this.deferredMines == null) {
          this.deferredMines = new Vector.<BattleMine>();
        }
        local2 = int(param1.length);
        local3 = 0;
        while(local3 < local2) {
          this.deferredMines.push(param1[local3]);
          local3++;
        }
      }
    }

    [Obfuscation(rename="false")]
    public function putMine(param1:Long, param2:Number, param3:Number, param4:Number, param5:Long) : void {
      var local6:Tank = this.loadedTanks[param5];
      if(local6 == null) {
        if(this.deferredMines == null) {
          this.deferredMines = new Vector.<BattleMine>();
        }
      } else {
        this.addMine(param1,this.mineProximityRadius,new Vector3(param2,param3,param4),param5,local6.teamType,this.getMineMaterial(local6),false);
      }
    }

    [Obfuscation(rename="false")]
    public function activateMine(param1:Long) : void {
      var local3:BattleMine = null;
      var local2:ProximityMine = this.minesOnField[param1];
      if(local2 != null) {
        local2.arm();
        addSound3DEffect(this.mineArmedSound,local2.position,MINE_ACTIVATION_SOUND_VOLUME);
      } else {
        for each(local3 in this.deferredMines) {
          if(local3.mineId == param1) {
            local3.activated = true;
            return;
          }
        }
      }
    }

    [Obfuscation(rename="false")]
    public function removeAllMines(param1:Long) : void {
      var local3:ProximityMine = null;
      var local4:ProximityMine = null;
      var local2:UserMinesList = this.minesByUser[param1];
      if(local2 != null) {
        local3 = local2.head;
        while(local3 != null) {
          local4 = local3;
          local3 = local3.next;
          this.playEffectAndRemoveMine(local4,local2);
        }
      }
    }

    [Obfuscation(rename="false")]
    public function removeMines(param1:Long, param2:Vector.<Long>) : void {
      var local4:Long = null;
      var local5:ProximityMine = null;
      var local3:UserMinesList = this.minesByUser[param1];
      for each(local4 in param2) {
        local5 = this.minesOnField[local4];
        if(local5 != null) {
          this.playEffectAndRemoveMine(local5,local3);
        }
      }
    }

    private function playEffectAndRemoveMine(param1:ProximityMine, param2:UserMinesList) : void {
      addExplosionEffect(param1.position,this.idleExplosionAnimation,this.idleExplosionFrameSize,IDLE_EXPLOSION_ORIGIN_X,IDLE_EXPLOSION_ORIGIN_Y);
      addSound3DEffect(this.deactivationSound,param1.position,0.1);
      this.removeMine(param1,param2);
    }

    [Obfuscation(rename="false")]
    public function explodeMine(param1:Long, param2:Long, param3:Boolean) : void {
      var local5:UserMinesList = null;
      var local6:Tank = null;
      var local4:ProximityMine = this.minesOnField[param1];
      if(local4 != null) {
        local5 = this.minesByUser[local4.ownerId];
        if(local5 != null) {
          addExplosionEffect(local4.position,this.mainExplosionAnimation,this.mainExplosionFrameSize,MAIN_EXPLOSION_ORIGIN_X,MAIN_EXPLOSION_ORIGIN_Y);
          this.addLightingEffect(local4.position,this.explosionLightAnimation);
          this.addExplosionMark(local4);
          addSound3DEffect(this.explosionSound,local4.position,0.5);
          local6 = this.loadedTanks[param2];
          if(!param3 && local6 != null) {
            local6.applyWeaponHit(local4.position,local4.groundNormal,WeaponConst.BASE_IMPACT_FORCE.getNumber() * this.impactForce);
          }
          this.removeMine(local4,local5);
        }
      }
    }

    public function getMinePosition(param1:Long) : Vector3 {
      var local2:ProximityMine = this.minesOnField[param1];
      return local2.position;
    }

    private function addLightingEffect(param1:Vector3, param2:LightAnimation) : void {
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      var local4:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
      local3.init(param1,50);
      local4.init(local3,param2);
      battleService.addGraphicEffect(local4);
    }

    private function addExplosionMark(param1:ProximityMine) : void {
      projectionOrigin.copy(param1.position);
      projectionOrigin.addScaled(100,param1.groundNormal);
      battleService.getBattleScene3D().addDecal(param1.position,projectionOrigin,DECAL_RADIUS,this.explosionMarkMaterial);
    }

    [Obfuscation(rename="false")]
    public function dump(param1:Array) : String {
      var local3:ProximityMine = null;
      var local2:String = "=== Mines ===\n";
      if(this.deferredMines != null) {
        local2 += "Deferred:\n" + this.deferredMines.join("\n") + "\n";
      }
      local2 += "On field:\n";
      for each(local3 in this.minesOnField) {
        local2 += local3 + "\n";
      }
      return local2;
    }

    [Obfuscation(rename="false")]
    public function get dumperName() : String {
      return "mines";
    }

    public function onTouchMine(param1:ProximityMine) : void {
      battleEventDispatcher.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
    }

    private function addMine(param1:Long, param2:Number, param3:Vector3, param4:Long, param5:BattleTeam, param6:Material, param7:Boolean) : void {
      var local9:UserMinesList = null;
      var local10:ProximityMine = null;
      var local8:RayHit = new RayHit();
      if(battleService.getBattleRunner().getCollisionDetector().raycastStatic(param3,Vector3.DOWN,CollisionGroup.STATIC,10000000000,null,local8)) {
        local9 = this.minesByUser[param4];
        if(local9 == null) {
          local9 = new UserMinesList();
          this.minesByUser[param4] = local9;
        }
        local10 = ProximityMine.create(param1,param4,param2,this.referenceMesh,param6,param5,this.mineModelData,this);
        local10.setPosition(local8.position,local8.normal);
        if(param7) {
          local10.arm();
        }
        local9.addMine(local10);
        this.minesOnField[param1] = local10;
        local10.addToGame();
      }
    }

    private function _removeAllMines() : void {
      var local1:* = undefined;
      var local2:ProximityMine = null;
      var local3:UserMinesList = null;
      for(local1 in this.minesOnField) {
        local2 = this.minesOnField[local1];
        local2.removeFromGame();
        delete this.minesOnField[local1];
      }
      for(local1 in this.minesByUser) {
        local3 = this.minesByUser[local1];
        local3.clearMines();
        delete this.minesByUser[local1];
      }
      this.deferredMines = null;
    }

    private function initReferenceMesh(param1:Tanks3DSResource) : void {
      this.referenceMesh = Mesh(param1.objects[0]);
      if(this.referenceMesh.sorting != Sorting.AVERAGE_Z) {
        this.referenceMesh.sorting = Sorting.AVERAGE_Z;
        this.referenceMesh.calculateFacesNormals(true);
      }
    }

    private function removeMine(param1:ProximityMine, param2:UserMinesList) : void {
      delete this.minesOnField[param1.id];
      param1.removeFromGame();
      param2.removeMine(param1);
    }

    private function getMineMaterial(param1:Tank) : Material {
      switch(param1.teamType) {
        case BattleTeam.NONE:
          return param1 == this.localTank ? this.friendlyMineMaterial : this.enemyMineMaterial;
        case BattleTeam.BLUE:
          return this.blueMineMaterial;
        case BattleTeam.RED:
          return this.redMineMaterial;
        default:
          return this.enemyMineMaterial;
      }
    }

    private function onTankLoaded(param1:TankLoadedEvent) : void {
      this.loadedTanks[param1.tank.getUser().id] = param1.tank;
      if(param1.isLocal) {
        this.localTank = param1.tank;
      }
    }

    private function onTankUnloaded(param1:TankUnloadedEvent) : void {
      delete this.loadedTanks[param1.tank.getUser().id];
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      if(param1.tank == this.localTank) {
        this.addReadyMinesToField();
      } else {
        this.addOwnerMinesToField(param1.tank);
      }
    }

    private function addReadyMinesToField() : void {
      var local1:int = 0;
      var local2:BattleMine = null;
      var local3:Tank = null;
      var local4:Vector3 = null;
      if(this.deferredMines != null) {
        local1 = 0;
        while(local1 < this.deferredMines.length) {
          local2 = this.deferredMines[local1];
          local3 = this.loadedTanks[local2.ownerId];
          if(local3 != null) {
            this.deferredMines.splice(local1,1);
            local1--;
            local4 = BattleUtils.getVector3(local2.position);
            this.addMine(local2.mineId,this.mineProximityRadius,local4,local2.ownerId,local3.teamType,this.getMineMaterial(local3),local2.activated);
          }
          local1++;
        }
      }
    }

    private function addOwnerMinesToField(param1:Tank) : void {
      var local2:int = 0;
      var local3:BattleMine = null;
      var local4:Vector3 = null;
      if(this.deferredMines != null) {
        local2 = 0;
        while(local2 < this.deferredMines.length) {
          local3 = this.deferredMines[local2];
          if(local3.ownerId == param1.getUser().id) {
            this.deferredMines.splice(local2,1);
            local2--;
            local4 = BattleUtils.getVector3(local3.position);
            this.addMine(local3.mineId,this.mineProximityRadius,local4,local3.ownerId,param1.teamType,this.getMineMaterial(param1),local3.activated);
          }
          local2++;
        }
      }
    }

    [Obfuscation(rename="false")]
    private function onBattleFinish(param1:BattleFinishEvent) : void {
      this._removeAllMines();
    }
  }
}
