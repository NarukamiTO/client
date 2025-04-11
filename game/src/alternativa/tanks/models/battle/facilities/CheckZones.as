package alternativa.tanks.models.battle.facilities {
  import alternativa.math.Vector3;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.physics.CollisionGroup;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;

  public class CheckZones {
    private var zones:Dictionary = new Dictionary();
    private var collisionDetector:CollisionDetector;

    public function CheckZones(param1:CollisionDetector) {
      super();
      this.collisionDetector = param1;
    }

    public static function checkZoneBordersCrossed(param1:CheckZone, param2:Vector3, param3:Vector3, param4:CollisionDetector = null) : Boolean {
      var local5:Boolean = pointInZone(param2,param1) && pointIsReachable(param2,param1,param4);
      var local6:Boolean = pointInZone(param3,param1) && pointIsReachable(param3,param1,param4);
      return local5 && !local6 || !local5 && local6;
    }

    private static function pointIsReachable(param1:Vector3, param2:CheckZone, param3:CollisionDetector) : Boolean {
      return !param2.checkRaycast || param3 != null && checkRaycast(param2.position,param1,param3);
    }

    private static function pointInZone(param1:Vector3, param2:CheckZone) : Boolean {
      return param1.distanceToSquared(param2.position) <= param2.radiusSqr;
    }

    private static function checkRaycast(param1:Vector3, param2:Vector3, param3:CollisionDetector) : Boolean {
      var local4:Vector3 = param2.clone().subtract(param1);
      return !param3.raycastStatic(param1,local4,CollisionGroup.STATIC,1,null,new RayHit());
    }

    public function remove(param1:IGameObject) : CheckZone {
      var local2:CheckZone = this.zones[param1];
      delete this.zones[param1];
      return local2;
    }

    public function add(param1:IGameObject, param2:Vector3, param3:Number, param4:Boolean) : CheckZone {
      var local5:CheckZone = CheckZone.create(param2,param3,param4);
      this.zones[param1] = local5;
      return local5;
    }

    public function addDynamic(param1:IGameObject, param2:Tank, param3:Number, param4:Boolean) : CheckZone {
      var local5:CheckZone = CheckZone.createDynamic(param2,param3,param4);
      this.zones[param1] = local5;
      return local5;
    }

    public function checkZoneChanged(param1:Vector3, param2:Vector3) : Boolean {
      var local3:Object = null;
      var local4:CheckZone = null;
      for(local3 in this.zones) {
        local4 = this.zones[local3];
        if(checkZoneBordersCrossed(local4,param1,param2,this.collisionDetector)) {
          return true;
        }
      }
      return false;
    }
  }
}
