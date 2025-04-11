package alternativa.engine3d.primitives {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;

  use namespace alternativa3d;

  public class Plane extends Mesh {
    public function Plane(param1:Number = 100, param2:Number = 100, param3:uint = 1, param4:uint = 1, param5:Boolean = true, param6:Boolean = false, param7:Boolean = false, param8:Material = null, param9:Material = null) {
      var local10:int = 0;
      var local11:int = 0;
      var local12:int = 0;
      super();
      if(param3 < 1) {
        throw new ArgumentError(param3 + " width segments not enough.");
      }
      if(param4 < 1) {
        throw new ArgumentError(param4 + " length segments not enough.");
      }
      var local13:int = param3 + 1;
      var local14:int = param4 + 1;
      var local15:Number = param1 * 0.5;
      var local16:Number = param2 * 0.5;
      var local17:Number = 1 / param3;
      var local18:Number = 1 / param4;
      var local19:Number = param1 / param3;
      var local20:Number = param2 / param4;
      var local21:Vector.<Vertex> = new Vector.<Vertex>();
      var local22:int = 0;
      local10 = 0;
      while(local10 < local13) {
        local11 = 0;
        while(local11 < local14) {
          var local23:* = local22++;
          local21[local23] = this.createVertex(local10 * local19 - local15,local11 * local20 - local16,0,local10 * local17,(param4 - local11) * local18);
          local11++;
        }
        local10++;
      }
      local10 = 0;
      while(local10 < local13) {
        local11 = 0;
        while(local11 < local14) {
          if(local10 < param3 && local11 < param4) {
            this.createFace(local21[local10 * local14 + local11],local21[(local10 + 1) * local14 + local11],local21[(local10 + 1) * local14 + local11 + 1],local21[local10 * local14 + local11 + 1],0,0,1,0,param6,param7,param9);
          }
          local11++;
        }
        local10++;
      }
      if(param5) {
        local22 = 0;
        local10 = 0;
        while(local10 < local13) {
          local11 = 0;
          while(local11 < local14) {
            local23 = local22++;
            local21[local23] = this.createVertex(local10 * local19 - local15,local11 * local20 - local16,0,(param3 - local10) * local17,(param4 - local11) * local18);
            local11++;
          }
          local10++;
        }
        local10 = 0;
        while(local10 < local13) {
          local11 = 0;
          while(local11 < local14) {
            if(local10 < param3 && local11 < param4) {
              this.createFace(local21[(local10 + 1) * local14 + local11 + 1],local21[(local10 + 1) * local14 + local11],local21[local10 * local14 + local11],local21[local10 * local14 + local11 + 1],0,0,-1,0,param6,param7,param8);
            }
            local11++;
          }
          local10++;
        }
      }
      boundMinX = -local15;
      boundMinY = -local16;
      boundMinZ = 0;
      boundMaxX = local15;
      boundMaxY = local16;
      boundMaxZ = 0;
    }

    private function createVertex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Vertex {
      var local6:Vertex = new Vertex();
      local6.x = param1;
      local6.y = param2;
      local6.z = param3;
      local6.u = param4;
      local6.v = param5;
      local6.alternativa3d::next = alternativa3d::vertexList;
      alternativa3d::vertexList = local6;
      return local6;
    }

    private function createFace(param1:Vertex, param2:Vertex, param3:Vertex, param4:Vertex, param5:Number, param6:Number, param7:Number, param8:Number, param9:Boolean, param10:Boolean, param11:Material) : void {
      var local12:Vertex = null;
      var local13:Face = null;
      if(param9) {
        param5 = -param5;
        param6 = -param6;
        param7 = -param7;
        param8 = -param8;
        local12 = param1;
        param1 = param4;
        param4 = local12;
        local12 = param2;
        param2 = param3;
        param3 = local12;
      }
      if(param10) {
        local13 = new Face();
        local13.material = param11;
        local13.alternativa3d::wrapper = new Wrapper();
        local13.alternativa3d::wrapper.alternativa3d::vertex = param1;
        local13.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
        local13.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = param2;
        local13.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
        local13.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = param3;
        local13.alternativa3d::normalX = param5;
        local13.alternativa3d::normalY = param6;
        local13.alternativa3d::normalZ = param7;
        local13.alternativa3d::offset = param8;
        local13.alternativa3d::next = alternativa3d::faceList;
        alternativa3d::faceList = local13;
        local13 = new Face();
        local13.material = param11;
        local13.alternativa3d::wrapper = new Wrapper();
        local13.alternativa3d::wrapper.alternativa3d::vertex = param1;
        local13.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
        local13.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = param3;
        local13.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
        local13.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = param4;
        local13.alternativa3d::normalX = param5;
        local13.alternativa3d::normalY = param6;
        local13.alternativa3d::normalZ = param7;
        local13.alternativa3d::offset = param8;
        local13.alternativa3d::next = alternativa3d::faceList;
        alternativa3d::faceList = local13;
      } else {
        local13 = new Face();
        local13.material = param11;
        local13.alternativa3d::wrapper = new Wrapper();
        local13.alternativa3d::wrapper.alternativa3d::vertex = param1;
        local13.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
        local13.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = param2;
        local13.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
        local13.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = param3;
        local13.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next = new Wrapper();
        local13.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = param4;
        local13.alternativa3d::normalX = param5;
        local13.alternativa3d::normalY = param6;
        local13.alternativa3d::normalZ = param7;
        local13.alternativa3d::offset = param8;
        local13.alternativa3d::next = alternativa3d::faceList;
        alternativa3d::faceList = local13;
      }
    }

    override public function clone() : Object3D {
      var local1:Plane = new Plane();
      local1.clonePropertiesFrom(this);
      return local1;
    }
  }
}
