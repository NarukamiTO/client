package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import flash.geom.Vector3D;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class EllipsoidCollider {
    public var radiusX:Number;
    public var radiusY:Number;
    public var radiusZ:Number;
    public var threshold:Number = 0.001;

    private var matrix:Object3D = new Object3D();
    private var faces:Vector.<Face> = new Vector.<Face>();
    private var facesLength:int;
    private var radius:Number;
    private var src:Vector3D = new Vector3D();
    private var displ:Vector3D = new Vector3D();
    private var dest:Vector3D = new Vector3D();
    private var collisionPoint:Vector3D = new Vector3D();
    private var collisionPlane:Vector3D = new Vector3D();
    private var vCenter:Vector3D = new Vector3D();
    private var vA:Vector3D = new Vector3D();
    private var vB:Vector3D = new Vector3D();
    private var vC:Vector3D = new Vector3D();
    private var vD:Vector3D = new Vector3D();

    public function EllipsoidCollider(param1:Number, param2:Number, param3:Number) {
      super();
      this.radiusX = param1;
      this.radiusY = param2;
      this.radiusZ = param3;
    }

    private function prepare(param1:Vector3D, param2:Vector3D, param3:Object3D, param4:Dictionary, param5:Boolean) : void {
      var local6:Number = NaN;
      this.radius = this.radiusX;
      if(this.radiusY > this.radius) {
        this.radius = this.radiusY;
      }
      if(this.radiusZ > this.radius) {
        this.radius = this.radiusZ;
      }
      this.matrix.scaleX = this.radiusX / this.radius;
      this.matrix.scaleY = this.radiusY / this.radius;
      this.matrix.scaleZ = this.radiusZ / this.radius;
      this.matrix.x = param1.x;
      this.matrix.y = param1.y;
      this.matrix.z = param1.z;
      this.matrix.alternativa3d::composeMatrix();
      this.matrix.alternativa3d::invertMatrix();
      this.src.x = 0;
      this.src.y = 0;
      this.src.z = 0;
      this.displ.x = this.matrix.alternativa3d::ma * param2.x + this.matrix.alternativa3d::mb * param2.y + this.matrix.alternativa3d::mc * param2.z;
      this.displ.y = this.matrix.alternativa3d::me * param2.x + this.matrix.alternativa3d::mf * param2.y + this.matrix.alternativa3d::mg * param2.z;
      this.displ.z = this.matrix.alternativa3d::mi * param2.x + this.matrix.alternativa3d::mj * param2.y + this.matrix.alternativa3d::mk * param2.z;
      this.dest.x = this.src.x + this.displ.x;
      this.dest.y = this.src.y + this.displ.y;
      this.dest.z = this.src.z + this.displ.z;
      if(param5) {
        this.vCenter.x = this.displ.x / 2;
        this.vCenter.y = this.displ.y / 2;
        this.vCenter.z = this.displ.z / 2;
        local6 = this.radius + this.displ.length / 2;
      } else {
        this.vCenter.x = 0;
        this.vCenter.y = 0;
        this.vCenter.z = 0;
        local6 = this.radius + this.displ.length;
      }
      this.vA.x = -local6;
      this.vA.y = -local6;
      this.vA.z = -local6;
      this.vB.x = local6;
      this.vB.y = -local6;
      this.vB.z = -local6;
      this.vC.x = local6;
      this.vC.y = local6;
      this.vC.z = -local6;
      this.vD.x = -local6;
      this.vD.y = local6;
      this.vD.z = -local6;
      param3.alternativa3d::composeAndAppend(this.matrix);
      param3.alternativa3d::collectPlanes(this.vCenter,this.vA,this.vB,this.vC,this.vD,this.faces,param4);
      this.facesLength = this.faces.length;
    }

    public function calculateDestination(param1:Vector3D, param2:Vector3D, param3:Object3D, param4:Dictionary = null) : Vector3D {
      var local5:int = 0;
      var local6:int = 0;
      var local7:Number = NaN;
      if(param2.length <= this.threshold) {
        return param1.clone();
      }
      this.prepare(param1,param2,param3,param4,false);
      if(this.facesLength > 0) {
        local5 = 50;
        local6 = 0;
        while(local6 < local5) {
          if(!this.checkCollision()) {
            break;
          }
          local7 = this.radius + this.threshold + this.collisionPlane.w - this.dest.x * this.collisionPlane.x - this.dest.y * this.collisionPlane.y - this.dest.z * this.collisionPlane.z;
          this.dest.x += this.collisionPlane.x * local7;
          this.dest.y += this.collisionPlane.y * local7;
          this.dest.z += this.collisionPlane.z * local7;
          this.src.x = this.collisionPoint.x + this.collisionPlane.x * (this.radius + this.threshold);
          this.src.y = this.collisionPoint.y + this.collisionPlane.y * (this.radius + this.threshold);
          this.src.z = this.collisionPoint.z + this.collisionPlane.z * (this.radius + this.threshold);
          this.displ.x = this.dest.x - this.src.x;
          this.displ.y = this.dest.y - this.src.y;
          this.displ.z = this.dest.z - this.src.z;
          if(this.displ.length < this.threshold) {
            break;
          }
          local6++;
        }
        this.faces.length = 0;
        this.matrix.alternativa3d::composeMatrix();
        return new Vector3D(this.matrix.alternativa3d::ma * this.dest.x + this.matrix.alternativa3d::mb * this.dest.y + this.matrix.alternativa3d::mc * this.dest.z + this.matrix.alternativa3d::md,this.matrix.alternativa3d::me * this.dest.x + this.matrix.alternativa3d::mf * this.dest.y + this.matrix.alternativa3d::mg * this.dest.z + this.matrix.alternativa3d::mh,this.matrix.alternativa3d::mi * this.dest.x + this.matrix.alternativa3d::mj * this.dest.y + this.matrix.alternativa3d::mk * this.dest.z + this.matrix.alternativa3d::ml);
      }
      return new Vector3D(param1.x + param2.x,param1.y + param2.y,param1.z + param2.z);
    }

    public function getCollision(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Vector3D, param5:Object3D, param6:Dictionary = null) : Boolean {
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      if(param2.length <= this.threshold) {
        return false;
      }
      this.prepare(param1,param2,param5,param6,true);
      if(this.facesLength > 0) {
        if(this.checkCollision()) {
          this.matrix.alternativa3d::composeMatrix();
          param3.x = this.matrix.alternativa3d::ma * this.collisionPoint.x + this.matrix.alternativa3d::mb * this.collisionPoint.y + this.matrix.alternativa3d::mc * this.collisionPoint.z + this.matrix.alternativa3d::md;
          param3.y = this.matrix.alternativa3d::me * this.collisionPoint.x + this.matrix.alternativa3d::mf * this.collisionPoint.y + this.matrix.alternativa3d::mg * this.collisionPoint.z + this.matrix.alternativa3d::mh;
          param3.z = this.matrix.alternativa3d::mi * this.collisionPoint.x + this.matrix.alternativa3d::mj * this.collisionPoint.y + this.matrix.alternativa3d::mk * this.collisionPoint.z + this.matrix.alternativa3d::ml;
          if(this.collisionPlane.x < this.collisionPlane.y) {
            if(this.collisionPlane.x < this.collisionPlane.z) {
              local7 = 0;
              local8 = -this.collisionPlane.z;
              local9 = this.collisionPlane.y;
            } else {
              local7 = -this.collisionPlane.y;
              local8 = this.collisionPlane.x;
              local9 = 0;
            }
          } else if(this.collisionPlane.y < this.collisionPlane.z) {
            local7 = this.collisionPlane.z;
            local8 = 0;
            local9 = -this.collisionPlane.x;
          } else {
            local7 = -this.collisionPlane.y;
            local8 = this.collisionPlane.x;
            local9 = 0;
          }
          local10 = this.collisionPlane.z * local8 - this.collisionPlane.y * local9;
          local11 = this.collisionPlane.x * local9 - this.collisionPlane.z * local7;
          local12 = this.collisionPlane.y * local7 - this.collisionPlane.x * local8;
          local13 = this.matrix.alternativa3d::ma * local7 + this.matrix.alternativa3d::mb * local8 + this.matrix.alternativa3d::mc * local9;
          local14 = this.matrix.alternativa3d::me * local7 + this.matrix.alternativa3d::mf * local8 + this.matrix.alternativa3d::mg * local9;
          local15 = this.matrix.alternativa3d::mi * local7 + this.matrix.alternativa3d::mj * local8 + this.matrix.alternativa3d::mk * local9;
          local16 = this.matrix.alternativa3d::ma * local10 + this.matrix.alternativa3d::mb * local11 + this.matrix.alternativa3d::mc * local12;
          local17 = this.matrix.alternativa3d::me * local10 + this.matrix.alternativa3d::mf * local11 + this.matrix.alternativa3d::mg * local12;
          local18 = this.matrix.alternativa3d::mi * local10 + this.matrix.alternativa3d::mj * local11 + this.matrix.alternativa3d::mk * local12;
          param4.x = local15 * local17 - local14 * local18;
          param4.y = local13 * local18 - local15 * local16;
          param4.z = local14 * local16 - local13 * local17;
          param4.normalize();
          param4.w = param3.x * param4.x + param3.y * param4.y + param3.z * param4.z;
          this.faces.length = 0;
          return true;
        }
        this.faces.length = 0;
        return false;
      }
      return false;
    }

    private function checkCollision() : Boolean {
      var local4:Face = null;
      var local5:Wrapper = null;
      var local6:Vertex = null;
      var local7:Vertex = null;
      var local8:Vertex = null;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Number = NaN;
      var local26:Number = NaN;
      var local27:Number = NaN;
      var local28:Boolean = false;
      var local29:Wrapper = null;
      var local30:Number = NaN;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Number = NaN;
      var local34:Number = NaN;
      var local35:Number = NaN;
      var local36:Number = NaN;
      var local37:Number = NaN;
      var local38:Number = NaN;
      var local39:Number = NaN;
      var local40:Number = NaN;
      var local41:Number = NaN;
      var local42:Number = NaN;
      var local43:Number = NaN;
      var local44:Number = NaN;
      var local45:Number = NaN;
      var local46:Number = NaN;
      var local1:Number = 1;
      var local2:Number = this.displ.length;
      var local3:int = 0;
      while(local3 < this.facesLength) {
        local4 = this.faces[local3];
        local5 = local4.alternativa3d::wrapper;
        local6 = local5.alternativa3d::vertex;
        local5 = local5.alternativa3d::next;
        local7 = local5.alternativa3d::vertex;
        local5 = local5.alternativa3d::next;
        local8 = local5.alternativa3d::vertex;
        local9 = local7.alternativa3d::cameraX - local6.alternativa3d::cameraX;
        local10 = local7.alternativa3d::cameraY - local6.alternativa3d::cameraY;
        local11 = local7.alternativa3d::cameraZ - local6.alternativa3d::cameraZ;
        local12 = local8.alternativa3d::cameraX - local6.alternativa3d::cameraX;
        local13 = local8.alternativa3d::cameraY - local6.alternativa3d::cameraY;
        local14 = local8.alternativa3d::cameraZ - local6.alternativa3d::cameraZ;
        local15 = local14 * local10 - local13 * local11;
        local16 = local12 * local11 - local14 * local9;
        local17 = local13 * local9 - local12 * local10;
        local18 = local15 * local15 + local16 * local16 + local17 * local17;
        if(local18 > 0.001) {
          local18 = 1 / Math.sqrt(local18);
          local15 *= local18;
          local16 *= local18;
          local17 *= local18;
          local19 = local6.alternativa3d::cameraX * local15 + local6.alternativa3d::cameraY * local16 + local6.alternativa3d::cameraZ * local17;
          local20 = this.src.x * local15 + this.src.y * local16 + this.src.z * local17 - local19;
          if(local20 < this.radius) {
            local21 = this.src.x - local15 * local20;
            local22 = this.src.y - local16 * local20;
            local23 = this.src.z - local17 * local20;
          } else {
            local33 = (local20 - this.radius) / (local20 - this.dest.x * local15 - this.dest.y * local16 - this.dest.z * local17 + local19);
            local21 = this.src.x + this.displ.x * local33 - local15 * this.radius;
            local22 = this.src.y + this.displ.y * local33 - local16 * this.radius;
            local23 = this.src.z + this.displ.z * local33 - local17 * this.radius;
          }
          local27 = 1e+22;
          local28 = true;
          local29 = local4.alternativa3d::wrapper;
          while(local29 != null) {
            local6 = local29.alternativa3d::vertex;
            local7 = local29.alternativa3d::next != null ? local29.alternativa3d::next.alternativa3d::vertex : local4.alternativa3d::wrapper.alternativa3d::vertex;
            local9 = local7.alternativa3d::cameraX - local6.alternativa3d::cameraX;
            local10 = local7.alternativa3d::cameraY - local6.alternativa3d::cameraY;
            local11 = local7.alternativa3d::cameraZ - local6.alternativa3d::cameraZ;
            local12 = local21 - local6.alternativa3d::cameraX;
            local13 = local22 - local6.alternativa3d::cameraY;
            local14 = local23 - local6.alternativa3d::cameraZ;
            local34 = local14 * local10 - local13 * local11;
            local35 = local12 * local11 - local14 * local9;
            local36 = local13 * local9 - local12 * local10;
            if(local34 * local15 + local35 * local16 + local36 * local17 < 0) {
              local37 = local9 * local9 + local10 * local10 + local11 * local11;
              local38 = (local34 * local34 + local35 * local35 + local36 * local36) / local37;
              if(local38 < local27) {
                local37 = Math.sqrt(local37);
                local9 /= local37;
                local10 /= local37;
                local11 /= local37;
                local33 = local9 * local12 + local10 * local13 + local11 * local14;
                if(local33 < 0) {
                  local39 = local12 * local12 + local13 * local13 + local14 * local14;
                  if(local39 < local27) {
                    local27 = local39;
                    local24 = Number(local6.alternativa3d::cameraX);
                    local25 = Number(local6.alternativa3d::cameraY);
                    local26 = Number(local6.alternativa3d::cameraZ);
                  }
                } else if(local33 > local37) {
                  local12 = local21 - local7.alternativa3d::cameraX;
                  local13 = local22 - local7.alternativa3d::cameraY;
                  local14 = local23 - local7.alternativa3d::cameraZ;
                  local39 = local12 * local12 + local13 * local13 + local14 * local14;
                  if(local39 < local27) {
                    local27 = local39;
                    local24 = Number(local7.alternativa3d::cameraX);
                    local25 = Number(local7.alternativa3d::cameraY);
                    local26 = Number(local7.alternativa3d::cameraZ);
                  }
                } else {
                  local27 = local38;
                  local24 = local6.alternativa3d::cameraX + local9 * local33;
                  local25 = local6.alternativa3d::cameraY + local10 * local33;
                  local26 = local6.alternativa3d::cameraZ + local11 * local33;
                }
              }
              local28 = false;
            }
            local29 = local29.alternativa3d::next;
          }
          if(local28) {
            local24 = local21;
            local25 = local22;
            local26 = local23;
          }
          local30 = this.src.x - local24;
          local31 = this.src.y - local25;
          local32 = this.src.z - local26;
          if(local30 * this.displ.x + local31 * this.displ.y + local32 * this.displ.z <= 0) {
            local40 = -this.displ.x / local2;
            local41 = -this.displ.y / local2;
            local42 = -this.displ.z / local2;
            local43 = local30 * local30 + local31 * local31 + local32 * local32;
            local44 = local30 * local40 + local31 * local41 + local32 * local42;
            local45 = this.radius * this.radius - local43 + local44 * local44;
            if(local45 > 0) {
              local46 = (local44 - Math.sqrt(local45)) / local2;
              if(local46 < local1) {
                local1 = local46;
                this.collisionPoint.x = local24;
                this.collisionPoint.y = local25;
                this.collisionPoint.z = local26;
                if(local28) {
                  this.collisionPlane.x = local15;
                  this.collisionPlane.y = local16;
                  this.collisionPlane.z = local17;
                  this.collisionPlane.w = local19;
                } else {
                  local43 = Math.sqrt(local43);
                  this.collisionPlane.x = local30 / local43;
                  this.collisionPlane.y = local31 / local43;
                  this.collisionPlane.z = local32 / local43;
                  this.collisionPlane.w = this.collisionPoint.x * this.collisionPlane.x + this.collisionPoint.y * this.collisionPlane.y + this.collisionPoint.z * this.collisionPlane.z;
                }
              }
            }
          }
        }
        local3++;
      }
      return local1 < 1;
    }
  }
}
