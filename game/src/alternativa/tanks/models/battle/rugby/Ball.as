package alternativa.tanks.models.battle.rugby {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;
  import alternativa.physics.PhysicsMaterial;
  import alternativa.physics.collision.primitives.CollisionSphere;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.bonuses.BonusConst;
  import alternativa.tanks.bonuses.BonusObject3DBase;
  import alternativa.tanks.bonuses.Cords;
  import alternativa.tanks.bonuses.ISpawnableObject;
  import alternativa.tanks.bonuses.Parachute;
  import alternativa.tanks.bonuses.ParachuteDetachAnimation;
  import alternativa.tanks.bonuses.SpawnAnimation;
  import alternativa.tanks.models.battle.commonflag.*;
  import alternativa.tanks.models.battle.gui.markers.PointIndicatorStateProvider;
  import alternativa.tanks.models.controlpoints.hud.KeyPointView;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BitmapData;
  import org1.osflash.signals.ISignal;
  import org1.osflash.signals.Signal;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagState;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class Ball extends CommonFlag implements ISpawnableObject, PointIndicatorStateProvider {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var materialRegistry:TextureMaterialRegistry;

    public const onDestroy:ISignal = new Signal();

    private const BALL_HANDLE_FREQ_X:Number = 0.0005;
    private const BALL_HANDLE_FREQ_Y:Number = 0.0003;

    private var parachute:Parachute;
    private var vec:Vector3 = new Vector3();
    private var eulerAngles:Vector3 = new Vector3();
    private var parachuteIn:Mesh;
    private var parachuteOut:Mesh;
    private var cordsMaterial:TextureMaterial;
    private var cords:Cords;
    private var materials:Vector.<TextureMaterial> = new Vector.<TextureMaterial>();
    private var flagWrapper:BonusObject3DBase;
    private var radius:Number;

    public function Ball(param1:int, param2:Number, param3:Tanks3DSResource, param4:Tanks3DSResource, param5:Tanks3DSResource, param6:TextureResource) {
      super(param1,BattleTeam.NONE,NO_POSITION);
      skinObject = this.getMeshFromResource(param3);
      this.flagWrapper = new BonusObject3DBase();
      this.radius = param2;
      this.flagWrapper.object = skinObject;
      skinObject.calculateBounds();
      this.setupCollisionPrimitive(param2);
      mountPointOffsetZ = 50;
      this.parachuteOut = this.getMeshFromResource(param4);
      this.parachuteIn = this.getMeshFromResource(param5);
      this.cordsMaterial = materialRegistry.getMaterial(param6.data);
      this.materials.push(this.cordsMaterial);
      _state = FlagState.EXILED;
    }

    private static function getMeshFromResource(param1:Tanks3DSResource) : Mesh {
      var local2:Mesh = Mesh(param1.objects[0]);
      var local3:BitmapData = param1.getTextureForObject(0);
      var local4:Mesh = Mesh(local2.clone());
      var local5:TextureMaterial = materialRegistry.getMaterial(local3);
      local5.resolution = 1;
      local4.setMaterialToAllFaces(local5);
      return local4;
    }

    private function setupCollisionPrimitive(param1:Number) : void {
      collisionPrimitive = new CollisionSphere(param1,CollisionGroup.TANK,PhysicsMaterial.DEFAULT_MATERIAL);
    }

    private function getMeshFromResource(param1:Tanks3DSResource) : Mesh {
      var local2:Mesh = Mesh(param1.objects[0]);
      var local3:BitmapData = param1.getTextureForObject(0);
      var local4:Mesh = Mesh(local2.clone());
      var local5:TextureMaterial = materialRegistry.getMaterial(local3);
      this.materials.push(local5);
      local4.setMaterialToAllFaces(local5);
      return local4;
    }

    override protected function initFalling() : void {
      this.initParachute();
      this.addParachuteToScene();
      this.startSpawnAnimation();
    }

    override public function stopFalling() : void {
      super.stopFalling();
      if(_state == FlagState.DROPPED) {
        this.detachParachute();
      }
    }

    private function detachParachute() : void {
      var local1:ParachuteDetachAnimation = null;
      if(this.parachute != null) {
        local1 = ParachuteDetachAnimation(battleService.getObjectPool().getObject(ParachuteDetachAnimation));
        local1.start(this.parachute,this.cords,flyingData.instantSpeed / 2);
        this.parachute = null;
        this.cords = null;
      }
    }

    private function startSpawnAnimation() : void {
      var local1:SpawnAnimation = SpawnAnimation(battleService.getObjectPool().getObject(SpawnAnimation));
      local1.start(this);
    }

    private function addParachuteToScene() : void {
      this.parachute.addToScene();
      this.cords.addToScene();
    }

    private function initParachute() : void {
      if(this.parachute == null) {
        this.parachute = new Parachute(this.parachuteOut,this.parachuteIn);
        this.cords = new Cords(Parachute.RADIUS,this.radius,Parachute.NUM_STRAPS,this.cordsMaterial);
        this.cords.init(this.flagWrapper,this.parachute);
      }
    }

    override protected function renderImpl(param1:int, param2:int, param3:FlagStatus) : void {
      var local4:Quaternion = null;
      skinObject.visible = state != FlagState.EXILED;
      moveObjects(param3.position);
      if(state == FlagState.CARRIED) {
        local4 = param3.rotation.clone().normalize();
        local4.prepend(Quaternion.createFromAxisAngle(Vector3.X_AXIS,-this.BALL_HANDLE_FREQ_X * param1 * Math.PI));
        local4.prepend(Quaternion.createFromAxisAngle(Vector3.Y_AXIS,this.BALL_HANDLE_FREQ_Y * param1 * Math.PI));
        local4.prepend(Quaternion.createFromAxisAngle(Vector3.Z_AXIS,0.5 * Math.PI));
        local4.getEulerAngles(this.eulerAngles);
        skinObject.rotationX = this.eulerAngles.x;
        skinObject.rotationY = this.eulerAngles.y;
        skinObject.rotationZ = this.eulerAngles.z;
      } else {
        param3.rotation.normalize().getEulerAngles(this.eulerAngles);
        skinObject.rotationX = this.eulerAngles.x;
        skinObject.rotationY = this.eulerAngles.y;
        skinObject.rotationZ = this.eulerAngles.z;
      }
      if(this.parachute != null) {
        this.vec.copy(param3.position);
        this.vec.z += BonusConst.BONUS_OFFSET_Z + BonusConst.PARACHUTE_OFFSET_Z;
        this.parachute.setPosition(this.vec);
        this.cords.updateVertices();
      }
    }

    override public function dispose() : void {
      var local1:TextureMaterial = null;
      super.dispose();
      for each(local1 in this.materials) {
        materialRegistry.releaseMaterial(local1);
      }
      this.onDestroy.dispatch();
      this.onDestroy.removeAll();
      if(Boolean(this.parachute)) {
        this.parachute.removeFromScene();
        this.cords.removeFromScene();
        this.parachute = null;
        this.cords = null;
      }
    }

    public function addSignal(param1:Function) : void {
      this.onDestroy.add(param1);
    }

    public function removeSignal(param1:Function) : void {
      this.onDestroy.remove(param1);
    }

    override public function setAlpha(param1:Number) : void {
      super.setAlpha(param1);
      if(Boolean(this.parachute)) {
        this.parachute.setAlpha(param1);
        this.cords.setAlpha(param1);
      }
    }

    override public function positionChanged(param1:Vector3, param2:Quaternion) : void {
      if(_state == FlagState.DROPPED || _state == FlagState.FLYING) {
        collisionPrimitive.transform.m03 = param1.x;
        collisionPrimitive.transform.m13 = param1.y;
        collisionPrimitive.transform.m23 = param1.z;
        collisionPrimitive.calculateAABB();
      }
      lightSource.x = param1.x;
      lightSource.y = param1.y;
      lightSource.z = param1.z;
    }

    public function isIndicatorActive(param1:Vector3 = null) : Boolean {
      readPosition(this.vec);
      return _state == FlagState.DROPPED || _state == FlagState.FLYING && flyingData.isMarked() || param1 != null && _state == FlagState.CARRIED && param1.distanceTo(this.vec) > MARKER_HIDE_DISTANCE && !isLocalCarrier;
    }

    public function zOffset() : Number {
      if(_state == FlagState.CARRIED) {
        return 0;
      }
      return KeyPointView.CIRCLE_ASCENSION;
    }
  }
}
