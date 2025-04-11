package alternativa.engine3d.primitives {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;

  use namespace alternativa3d;

  public class Box extends Mesh {
    public function Box(param1:Number = 100, param2:Number = 100, param3:Number = 100, param4:uint = 1, param5:uint = 1, param6:uint = 1, param7:Boolean = false, param8:Boolean = false, param9:Material = null, param10:Material = null, param11:Material = null, param12:Material = null, param13:Material = null, param14:Material = null) {
      var local15:int = 0;
      var local16:int = 0;
      var local17:int = 0;
      super();
      if(param4 < 1) {
        throw new ArgumentError(param4 + " width segments not enough.");
      }
      if(param5 < 1) {
        throw new ArgumentError(param5 + " length segments not enough.");
      }
      if(param6 < 1) {
        throw new ArgumentError(param6 + " height segments not enough.");
      }
      var local18:int = param4 + 1;
      var local19:int = param5 + 1;
      var local20:int = param6 + 1;
      var local21:Number = param1 * 0.5;
      var local22:Number = param2 * 0.5;
      var local23:Number = param3 * 0.5;
      var local24:Number = 1 / param4;
      var local25:Number = 1 / param5;
      var local26:Number = 1 / param6;
      var local27:Number = param1 / param4;
      var local28:Number = param2 / param5;
      var local29:Number = param3 / param6;
      var local30:Vector.<Vertex> = new Vector.<Vertex>();
      var local31:int = 0;
      local15 = 0;
      while(local15 < local18) {
        local16 = 0;
        while(local16 < local19) {
          var local33:* = local31++;
          local30[local33] = this.createVertex(local15 * local27 - local21,local16 * local28 - local22,-local23,(param4 - local15) * local24,(param5 - local16) * local25);
          local16++;
        }
        local15++;
      }
      local15 = 0;
      while(local15 < local18) {
        local16 = 0;
        while(local16 < local19) {
          if(local15 < param4 && local16 < param5) {
            this.createFace(local30[(local15 + 1) * local19 + local16 + 1],local30[(local15 + 1) * local19 + local16],local30[local15 * local19 + local16],local30[local15 * local19 + local16 + 1],0,0,-1,local23,param7,param8,param13);
          }
          local16++;
        }
        local15++;
      }
      var local32:uint = uint(local18 * local19);
      local15 = 0;
      while(local15 < local18) {
        local16 = 0;
        while(local16 < local19) {
          local33 = local31++;
          local30[local33] = this.createVertex(local15 * local27 - local21,local16 * local28 - local22,local23,local15 * local24,(param5 - local16) * local25);
          local16++;
        }
        local15++;
      }
      local15 = 0;
      while(local15 < local18) {
        local16 = 0;
        while(local16 < local19) {
          if(local15 < param4 && local16 < param5) {
            this.createFace(local30[local32 + local15 * local19 + local16],local30[local32 + (local15 + 1) * local19 + local16],local30[local32 + (local15 + 1) * local19 + local16 + 1],local30[local32 + local15 * local19 + local16 + 1],0,0,1,local23,param7,param8,param14);
          }
          local16++;
        }
        local15++;
      }
      local32 += local18 * local19;
      local15 = 0;
      while(local15 < local18) {
        local17 = 0;
        while(local17 < local20) {
          local33 = local31++;
          local30[local33] = this.createVertex(local15 * local27 - local21,-local22,local17 * local29 - local23,local15 * local24,(param6 - local17) * local26);
          local17++;
        }
        local15++;
      }
      local15 = 0;
      while(local15 < local18) {
        local17 = 0;
        while(local17 < local20) {
          if(local15 < param4 && local17 < param6) {
            this.createFace(local30[local32 + local15 * local20 + local17],local30[local32 + (local15 + 1) * local20 + local17],local30[local32 + (local15 + 1) * local20 + local17 + 1],local30[local32 + local15 * local20 + local17 + 1],0,-1,0,local22,param7,param8,param11);
          }
          local17++;
        }
        local15++;
      }
      local32 += local18 * local20;
      local15 = 0;
      while(local15 < local18) {
        local17 = 0;
        while(local17 < local20) {
          local33 = local31++;
          local30[local33] = this.createVertex(local15 * local27 - local21,local22,local17 * local29 - local23,(param4 - local15) * local24,(param6 - local17) * local26);
          local17++;
        }
        local15++;
      }
      local15 = 0;
      while(local15 < local18) {
        local17 = 0;
        while(local17 < local20) {
          if(local15 < param4 && local17 < param6) {
            this.createFace(local30[local32 + local15 * local20 + local17],local30[local32 + local15 * local20 + local17 + 1],local30[local32 + (local15 + 1) * local20 + local17 + 1],local30[local32 + (local15 + 1) * local20 + local17],0,1,0,local22,param7,param8,param12);
          }
          local17++;
        }
        local15++;
      }
      local32 += local18 * local20;
      local16 = 0;
      while(local16 < local19) {
        local17 = 0;
        while(local17 < local20) {
          local33 = local31++;
          local30[local33] = this.createVertex(-local21,local16 * local28 - local22,local17 * local29 - local23,(param5 - local16) * local25,(param6 - local17) * local26);
          local17++;
        }
        local16++;
      }
      local16 = 0;
      while(local16 < local19) {
        local17 = 0;
        while(local17 < local20) {
          if(local16 < param5 && local17 < param6) {
            this.createFace(local30[local32 + local16 * local20 + local17],local30[local32 + local16 * local20 + local17 + 1],local30[local32 + (local16 + 1) * local20 + local17 + 1],local30[local32 + (local16 + 1) * local20 + local17],-1,0,0,local21,param7,param8,param9);
          }
          local17++;
        }
        local16++;
      }
      local32 += local19 * local20;
      local16 = 0;
      while(local16 < local19) {
        local17 = 0;
        while(local17 < local20) {
          local33 = local31++;
          local30[local33] = this.createVertex(local21,local16 * local28 - local22,local17 * local29 - local23,local16 * local25,(param6 - local17) * local26);
          local17++;
        }
        local16++;
      }
      local16 = 0;
      while(local16 < local19) {
        local17 = 0;
        while(local17 < local20) {
          if(local16 < param5 && local17 < param6) {
            this.createFace(local30[local32 + local16 * local20 + local17],local30[local32 + (local16 + 1) * local20 + local17],local30[local32 + (local16 + 1) * local20 + local17 + 1],local30[local32 + local16 * local20 + local17 + 1],1,0,0,local21,param7,param8,param10);
          }
          local17++;
        }
        local16++;
      }
      boundMinX = -local21;
      boundMinY = -local22;
      boundMinZ = -local23;
      boundMaxX = local21;
      boundMaxY = local22;
      boundMaxZ = local23;
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
      var local1:Box = new Box();
      local1.clonePropertiesFrom(this);
      return local1;
    }
  }
}
