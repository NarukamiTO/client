package alternativa.engine3d.primitives {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;

  use namespace alternativa3d;

  public class Sphere extends Mesh {
    public function Sphere(param1:Number = 100, param2:uint = 8, param3:uint = 8, param4:Boolean = false, param5:Material = null) {
      var local9:uint = 0;
      var local10:uint = 0;
      var local12:Vertex = null;
      var local13:Vertex = null;
      var local14:Vertex = null;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      super();
      if(param2 < 3) {
        throw new ArgumentError(param2 + " radial segments not enough.");
      }
      if(param3 < 2) {
        throw new ArgumentError(param3 + " height segments not enough.");
      }
      param1 = param1 < 0 ? 0 : param1;
      var local6:Object = new Object();
      var local7:Number = Math.PI * 2 / param2;
      var local8:Number = Math.PI * 2 / (param3 << 1);
      local10 = 0;
      while(local10 <= param3) {
        local15 = local8 * local10;
        local16 = Math.sin(local15) * param1;
        local17 = Math.cos(local15) * param1;
        local9 = 0;
        while(local9 <= param2) {
          local18 = local7 * local9;
          this.createVertex(-Math.sin(local18) * local16,Math.cos(local18) * local16,local17,local9 / param2,local10 / param3,local9 + "_" + local10,local6);
          local9++;
        }
        local10++;
      }
      var local11:uint = 0;
      local9 = 1;
      while(local9 <= param2) {
        local10 = 0;
        while(local10 < param3) {
          if(local10 < param3 - 1) {
            local12 = local6[local11 + "_" + local10];
            local13 = local6[local11 + "_" + (local10 + 1)];
            local14 = local6[local9 + "_" + (local10 + 1)];
            if(param4) {
              this.createFace(local12,local14,local13,param5);
            } else {
              this.createFace(local12,local13,local14,param5);
            }
          }
          if(local10 > 0) {
            local12 = local6[local9 + "_" + (local10 + 1)];
            local13 = local6[local9 + "_" + local10];
            local14 = local6[local11 + "_" + local10];
            if(param4) {
              this.createFace(local12,local14,local13,param5);
            } else {
              this.createFace(local12,local13,local14,param5);
            }
          }
          local10++;
        }
        local11 = local9;
        local9++;
      }
      calculateFacesNormals(true);
      boundMinX = -param1;
      boundMinY = -param1;
      boundMinZ = -param1;
      boundMaxX = param1;
      boundMaxY = param1;
      boundMaxZ = param1;
    }

    private function createVertex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:String, param7:Object) : Vertex {
      var local8:Vertex = new Vertex();
      local8.x = param1;
      local8.y = param2;
      local8.z = param3;
      local8.u = param4;
      local8.v = param5;
      local8.alternativa3d::next = alternativa3d::vertexList;
      alternativa3d::vertexList = local8;
      param7[param6] = local8;
      return local8;
    }

    private function createFace(param1:Vertex, param2:Vertex, param3:Vertex, param4:Material) : void {
      var local5:Face = new Face();
      local5.material = param4;
      local5.alternativa3d::wrapper = new Wrapper();
      local5.alternativa3d::wrapper.alternativa3d::vertex = param1;
      local5.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
      local5.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = param2;
      local5.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
      local5.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = param3;
      local5.alternativa3d::next = alternativa3d::faceList;
      alternativa3d::faceList = local5;
    }

    override public function clone() : Object3D {
      var local1:Sphere = new Sphere();
      local1.clonePropertiesFrom(this);
      return local1;
    }
  }
}
