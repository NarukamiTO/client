package alternativa.tanks.battle.objects.tank {
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.PhysicsMaterial;
  import alternativa.physics.collision.primitives.CollisionBox;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.physics.TankBody;
  import alternativa.tanks.utils.MathUtils;

  public class CollisionBoxesBuilder {
    private static const NORMAL_FRICTION_MATERIAL:PhysicsMaterial = new PhysicsMaterial(0,1);
    private static const LOW_FRICTION_MATERIAL:PhysicsMaterial = new PhysicsMaterial(0,0.2);

    public function CollisionBoxesBuilder() {
      super();
    }

    public static function createStaticCollisionBoxes(param1:Vector3, param2:Number, param3:TankBody) : void {
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local4:Number = param2 - 10;
      var local5:Number = param1.y;
      var local6:Number = local4 / 2;
      var local7:Number = 0.82;
      var local8:Number = 1 - (1 - local7) * (1 - local7) * local5 * local5 / (local6 * local6);
      if(local8 > 0) {
        local8 = Math.sqrt(local8);
      } else {
        local8 = 1 - (1 - local7) * local5 / local6;
      }
      var local9:Number = (local7 - 1) * local5 / ((1 + local8) * local6);
      var local10:Number = local8 * local6 - local9 * local5;
      var local11:Number = (1 - local7) * local5 / ((1 + local8) * local6);
      var local12:Number = (1 - local8) * local6 / ((1 - local7) * local5);
      if(MathUtils.numbersEqual(local11,local12,0.00001) || local11 < local12) {
        local13 = local7 * local5;
        local14 = local9 * local13 + local10;
      } else {
        local13 = (1 - local8) * local6 / local9 + local5;
        local14 = local6;
      }
      var local15:Number = local14 - local8 * local6;
      var local16:Number = local5 - local13;
      var local17:Number = Math.sqrt(local15 * local15 + local16 * local16) / 2;
      local15 = (1 + local8) * local6;
      local16 = (1 - local7) * local5;
      var local18:Number = Math.sqrt(local15 * local15 + local16 * local16) / 2;
      var local19:CollisionBox = new CollisionBox(new Vector3(param1.x,local17,local18),CollisionGroup.STATIC,LOW_FRICTION_MATERIAL);
      var local20:Matrix4 = new Matrix4();
      var local21:Number = Math.atan(local11);
      local20.setRotationMatrix(-local21,0,0);
      var local22:Number = local7 * local5 + local18 * Math.sin(local21) - local17 * Math.cos(local21);
      var local23:Number = -local6 + local18 * Math.cos(local21) + local17 * Math.sin(local21) - (param1.z - local4 / 2);
      local20.setPosition(new Vector3(0,local22,local23));
      param3.body.addCollisionShape(local19,local20);
      param3.staticShapes.push(local19);
      local19 = new CollisionBox(new Vector3(param1.x,local17,local18),CollisionGroup.STATIC,LOW_FRICTION_MATERIAL);
      local20.setRotationMatrix(local21,0,0);
      local20.setPosition(new Vector3(0,-local22,local23));
      param3.body.addCollisionShape(local19,local20);
      param3.staticShapes.push(local19);
      var local24:Number = param2 * 3 / 4;
      var local25:Vector3 = new Vector3(param1.x,param1.y * local7,local24 / 2);
      var local26:Matrix4 = new Matrix4();
      local26.m23 = local25.z - param1.z;
      var local27:CollisionBox = new CollisionBox(local25,CollisionGroup.STATIC,LOW_FRICTION_MATERIAL);
      param3.body.addCollisionShape(local27,local26);
      param3.staticShapes.push(local27);
      var local28:Number = param2 * 3 / 4;
      var local29:Vector3 = new Vector3(param1.x,param1.y * local7,local28 / 2);
      var local30:Matrix4 = new Matrix4();
      local30.m23 = param2 - local29.z - param1.z;
      var local31:CollisionBox = new CollisionBox(local29,CollisionGroup.STATIC,NORMAL_FRICTION_MATERIAL);
      param3.body.addCollisionShape(local31,local30);
      param3.staticShapes.push(local31);
    }

    public static function createTankCollisionBox(param1:Vector3, param2:Number, param3:TankBody) : void {
      var local4:Vector3 = new Vector3(param1.x,param1.y,param2 / 2);
      var local5:CollisionBox = new CollisionBox(local4,0,LOW_FRICTION_MATERIAL);
      var local6:Matrix4 = new Matrix4();
      local6.m23 = param2 / 2 - param1.z;
      param3.body.addCollisionShape(local5,local6);
      param3.tankCollisionBox = local5;
    }
  }
}
