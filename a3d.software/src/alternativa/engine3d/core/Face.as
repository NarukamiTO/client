package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.materials.Material;
  import flash.geom.Point;
  import flash.geom.Vector3D;

  use namespace alternativa3d;

  public class Face {
    alternativa3d static var collector:Face;

    public var material:Material;
    public var smoothingGroups:uint = 0;

    alternativa3d var normalX:Number;
    alternativa3d var normalY:Number;
    alternativa3d var normalZ:Number;
    alternativa3d var offset:Number;
    alternativa3d var wrapper:Wrapper;
    alternativa3d var next:Face;
    alternativa3d var processNext:Face;
    alternativa3d var processNegative:Face;
    alternativa3d var processPositive:Face;
    alternativa3d var distance:Number;
    alternativa3d var geometry:VG;

    public var id:Object;

    public function Face() {
      super();
    }

    alternativa3d static function create() : Face {
      var local1:Face = null;
      if(alternativa3d::collector != null) {
        local1 = alternativa3d::collector;
        alternativa3d::collector = local1.alternativa3d::next;
        local1.alternativa3d::next = null;
        return local1;
      }
      return new Face();
    }

    alternativa3d function create() : Face {
      var local1:Face = null;
      if(alternativa3d::collector != null) {
        local1 = alternativa3d::collector;
        alternativa3d::collector = local1.alternativa3d::next;
        local1.alternativa3d::next = null;
        return local1;
      }
      return new Face();
    }

    public function get normal() : Vector3D {
      var local1:Wrapper = this.alternativa3d::wrapper;
      var local2:Vertex = local1.alternativa3d::vertex;
      local1 = local1.alternativa3d::next;
      var local3:Vertex = local1.alternativa3d::vertex;
      local1 = local1.alternativa3d::next;
      var local4:Vertex = local1.alternativa3d::vertex;
      var local5:Number = local3.x - local2.x;
      var local6:Number = local3.y - local2.y;
      var local7:Number = local3.z - local2.z;
      var local8:Number = local4.x - local2.x;
      var local9:Number = local4.y - local2.y;
      var local10:Number = local4.z - local2.z;
      var local11:Number = local10 * local6 - local9 * local7;
      var local12:Number = local8 * local7 - local10 * local5;
      var local13:Number = local9 * local5 - local8 * local6;
      var local14:Number = local11 * local11 + local12 * local12 + local13 * local13;
      if(local14 > 0.001) {
        local14 = 1 / Math.sqrt(local14);
        local11 *= local14;
        local12 *= local14;
        local13 *= local14;
      }
      return new Vector3D(local11,local12,local13,local2.x * local11 + local2.y * local12 + local2.z * local13);
    }

    public function get vertices() : Vector.<Vertex> {
      var local1:Vector.<Vertex> = new Vector.<Vertex>();
      var local2:int = 0;
      var local3:Wrapper = this.alternativa3d::wrapper;
      while(local3 != null) {
        local1[local2] = local3.alternativa3d::vertex;
        local2++;
        local3 = local3.alternativa3d::next;
      }
      return local1;
    }

    public function getUV(param1:Vector3D) : Point {
      var local2:Vertex = this.alternativa3d::wrapper.alternativa3d::vertex;
      var local3:Vertex = this.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex;
      var local4:Vertex = this.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex;
      var local5:Number = local3.x - local2.x;
      var local6:Number = local3.y - local2.y;
      var local7:Number = local3.z - local2.z;
      var local8:Number = local3.u - local2.u;
      var local9:Number = local3.v - local2.v;
      var local10:Number = local4.x - local2.x;
      var local11:Number = local4.y - local2.y;
      var local12:Number = local4.z - local2.z;
      var local13:Number = local4.u - local2.u;
      var local14:Number = local4.v - local2.v;
      var local15:Number = -this.alternativa3d::normalX * local11 * local7 + local10 * this.alternativa3d::normalY * local7 + this.alternativa3d::normalX * local6 * local12 - local5 * this.alternativa3d::normalY * local12 - local10 * local6 * this.alternativa3d::normalZ + local5 * local11 * this.alternativa3d::normalZ;
      var local16:Number = (-this.alternativa3d::normalY * local12 + local11 * this.alternativa3d::normalZ) / local15;
      var local17:Number = (this.alternativa3d::normalX * local12 - local10 * this.alternativa3d::normalZ) / local15;
      var local18:Number = (-this.alternativa3d::normalX * local11 + local10 * this.alternativa3d::normalY) / local15;
      var local19:Number = (local2.x * this.alternativa3d::normalY * local12 - this.alternativa3d::normalX * local2.y * local12 - local2.x * local11 * this.alternativa3d::normalZ + local10 * local2.y * this.alternativa3d::normalZ + this.alternativa3d::normalX * local11 * local2.z - local10 * this.alternativa3d::normalY * local2.z) / local15;
      var local20:Number = (this.alternativa3d::normalY * local7 - local6 * this.alternativa3d::normalZ) / local15;
      var local21:Number = (-this.alternativa3d::normalX * local7 + local5 * this.alternativa3d::normalZ) / local15;
      var local22:Number = (this.alternativa3d::normalX * local6 - local5 * this.alternativa3d::normalY) / local15;
      var local23:Number = (this.alternativa3d::normalX * local2.y * local7 - local2.x * this.alternativa3d::normalY * local7 + local2.x * local6 * this.alternativa3d::normalZ - local5 * local2.y * this.alternativa3d::normalZ - this.alternativa3d::normalX * local6 * local2.z + local5 * this.alternativa3d::normalY * local2.z) / local15;
      var local24:Number = local8 * local16 + local13 * local20;
      var local25:Number = local8 * local17 + local13 * local21;
      var local26:Number = local8 * local18 + local13 * local22;
      var local27:Number = local8 * local19 + local13 * local23 + local2.u;
      var local28:Number = local9 * local16 + local14 * local20;
      var local29:Number = local9 * local17 + local14 * local21;
      var local30:Number = local9 * local18 + local14 * local22;
      var local31:Number = local9 * local19 + local14 * local23 + local2.v;
      return new Point(local24 * param1.x + local25 * param1.y + local26 * param1.z + local27,local28 * param1.x + local29 * param1.y + local30 * param1.z + local31);
    }

    public function toString() : String {
      return "[Face " + this.id + "]";
    }

    alternativa3d function calculateBestSequenceAndNormal() : void {
      var local1:Wrapper = null;
      var local2:Vertex = null;
      var local3:Vertex = null;
      var local4:Vertex = null;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Wrapper = null;
      var local17:Wrapper = null;
      var local18:Wrapper = null;
      var local19:Wrapper = null;
      var local20:Wrapper = null;
      if(this.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next != null) {
        local15 = -1e+22;
        local1 = this.alternativa3d::wrapper;
        while(local1 != null) {
          local19 = local1.alternativa3d::next != null ? local1.alternativa3d::next : this.alternativa3d::wrapper;
          local20 = local19.alternativa3d::next != null ? local19.alternativa3d::next : this.alternativa3d::wrapper;
          local2 = local1.alternativa3d::vertex;
          local3 = local19.alternativa3d::vertex;
          local4 = local20.alternativa3d::vertex;
          local5 = local3.x - local2.x;
          local6 = local3.y - local2.y;
          local7 = local3.z - local2.z;
          local8 = local4.x - local2.x;
          local9 = local4.y - local2.y;
          local10 = local4.z - local2.z;
          local11 = local10 * local6 - local9 * local7;
          local12 = local8 * local7 - local10 * local5;
          local13 = local9 * local5 - local8 * local6;
          local14 = local11 * local11 + local12 * local12 + local13 * local13;
          if(local14 > local15) {
            local15 = local14;
            local16 = local1;
          }
          local1 = local1.alternativa3d::next;
        }
        if(local16 != this.alternativa3d::wrapper) {
          local17 = this.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next;
          while(local17.alternativa3d::next != null) {
            local17 = local17.alternativa3d::next;
          }
          local18 = this.alternativa3d::wrapper;
          while(local18.alternativa3d::next != local16 && local18.alternativa3d::next != null) {
            local18 = local18.alternativa3d::next;
          }
          local17.alternativa3d::next = this.alternativa3d::wrapper;
          local18.alternativa3d::next = null;
          this.alternativa3d::wrapper = local16;
        }
      }
      local1 = this.alternativa3d::wrapper;
      local2 = local1.alternativa3d::vertex;
      local1 = local1.alternativa3d::next;
      local3 = local1.alternativa3d::vertex;
      local1 = local1.alternativa3d::next;
      local4 = local1.alternativa3d::vertex;
      local5 = local3.x - local2.x;
      local6 = local3.y - local2.y;
      local7 = local3.z - local2.z;
      local8 = local4.x - local2.x;
      local9 = local4.y - local2.y;
      local10 = local4.z - local2.z;
      local11 = local10 * local6 - local9 * local7;
      local12 = local8 * local7 - local10 * local5;
      local13 = local9 * local5 - local8 * local6;
      local14 = local11 * local11 + local12 * local12 + local13 * local13;
      if(local14 > 0) {
        local14 = 1 / Math.sqrt(local14);
        local11 *= local14;
        local12 *= local14;
        local13 *= local14;
        this.alternativa3d::normalX = local11;
        this.alternativa3d::normalY = local12;
        this.alternativa3d::normalZ = local13;
      }
      this.alternativa3d::offset = local2.x * local11 + local2.y * local12 + local2.z * local13;
    }
  }
}
