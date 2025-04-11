package alternativa.tanks.battle.scene3d {
  import alternativa.engine3d.containers.KDContainer;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Decal;
  import alternativa.math.Vector3;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.*;
  import alternativa.tanks.physics.CollisionGroup;
  import flash.geom.Vector3D;

  public class DecalFactory {
    private static const ANGLE_LIMIT:Number = 85 * Math.PI / 180;
    private static const rayHit:RayHit = new RayHit();
    private static const direction:Vector3 = new Vector3();
    private static const right:Vector3 = new Vector3();
    private static const up:Vector3 = new Vector3();
    private static const normal:Vector3 = new Vector3();
    private static const origins:Vector.<Vector3> = Vector.<Vector3>([new Vector3(),new Vector3(),new Vector3(),new Vector3(),new Vector3()]);
    private static const position3D:Vector3D = new Vector3D();
    private static const normal3D:Vector3D = new Vector3D();

    private var collisionDetector:CollisionDetector;

    public function DecalFactory(param1:CollisionDetector) {
      super();
      this.collisionDetector = param1;
    }

    public function createDecal(param1:Vector3, param2:Vector3, param3:Number, param4:TextureMaterial, param5:KDContainer, param6:RotationState) : Decal {
      var local8:Vector3 = null;
      var local9:Number = NaN;
      direction.diff(param1,param2);
      var local7:Number = direction.length() + 200;
      direction.normalize();
      right.cross2(direction,Vector3.Z_AXIS).normalize();
      up.cross2(right,direction);
      Vector3(origins[4]).copy(param2);
      Vector3(origins[0]).copy(param2).addScaled(50,right);
      Vector3(origins[1]).copy(param2).addScaled(50,up);
      Vector3(origins[2]).copy(param2).addScaled(-50,right);
      Vector3(origins[3]).copy(param2).addScaled(-50,up);
      normal.reset(0,0,0);
      for each(local8 in origins) {
        if(this.collisionDetector.raycastStatic(local8,direction,CollisionGroup.STATIC,local7,null,rayHit)) {
          normal.add(rayHit.normal);
        }
      }
      normal.normalize();
      BattleUtils.copyToVector3D(param1,position3D);
      BattleUtils.copyToVector3D(normal,normal3D);
      local9 = this.getRotation(param6);
      return param5.createDecal(position3D,normal3D,param3,local9,ANGLE_LIMIT,300,param4);
    }

    private function getRotation(param1:RotationState) : Number {
      switch(param1) {
        case RotationState.WITHOUT_ROTATION:
          return 0;
        default:
          return Math.random() * 2 * Math.PI;
      }
    }
  }
}
