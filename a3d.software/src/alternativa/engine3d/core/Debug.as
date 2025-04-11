package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;

  use namespace alternativa3d;

  public class Debug {
    public static const BOUNDS:int = 8;
    public static const EDGES:int = 16;
    public static const NODES:int = 128;
    public static const LIGHTS:int = 256;
    public static const BONES:int = 512;

    private static const boundVertexList:Vertex = Vertex.alternativa3d::createList(8);
    private static const nodeVertexList:Vertex = Vertex.alternativa3d::createList(4);

    public function Debug() {
      super();
    }

    alternativa3d static function drawEdges(param1:Camera3D, param2:Canvas, param3:Face, param4:int) : void {
      var local7:Number = NaN;
      var local9:Wrapper = null;
      var local10:Vertex = null;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local5:Number = Number(param1.alternativa3d::viewSizeX);
      var local6:Number = Number(param1.alternativa3d::viewSizeY);
      param2.alternativa3d::gfx.lineStyle(0,param4);
      var local8:Face = param3;
      while(local8 != null) {
        local9 = local8.alternativa3d::wrapper;
        local10 = local9.alternativa3d::vertex;
        local7 = 1 / local10.alternativa3d::cameraZ;
        local11 = local10.alternativa3d::cameraX * local5 * local7;
        local12 = local10.alternativa3d::cameraY * local6 * local7;
        param2.alternativa3d::gfx.moveTo(local11,local12);
        local9 = local9.alternativa3d::next;
        while(local9 != null) {
          local10 = local9.alternativa3d::vertex;
          local7 = 1 / local10.alternativa3d::cameraZ;
          param2.alternativa3d::gfx.lineTo(local10.alternativa3d::cameraX * local5 * local7,local10.alternativa3d::cameraY * local6 * local7);
          local9 = local9.alternativa3d::next;
        }
        param2.alternativa3d::gfx.lineTo(local11,local12);
        local8 = local8.alternativa3d::processNext;
      }
    }

    alternativa3d static function drawBounds(param1:Camera3D, param2:Canvas, param3:Object3D, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:int = -1, param11:Number = 1) : void {
      var local12:Vertex = null;
      var local23:Number = NaN;
      var local13:Vertex = boundVertexList;
      local13.x = param4;
      local13.y = param5;
      local13.z = param6;
      var local14:Vertex = local13.alternativa3d::next;
      local14.x = param7;
      local14.y = param5;
      local14.z = param6;
      var local15:Vertex = local14.alternativa3d::next;
      local15.x = param4;
      local15.y = param8;
      local15.z = param6;
      var local16:Vertex = local15.alternativa3d::next;
      local16.x = param7;
      local16.y = param8;
      local16.z = param6;
      var local17:Vertex = local16.alternativa3d::next;
      local17.x = param4;
      local17.y = param5;
      local17.z = param9;
      var local18:Vertex = local17.alternativa3d::next;
      local18.x = param7;
      local18.y = param5;
      local18.z = param9;
      var local19:Vertex = local18.alternativa3d::next;
      local19.x = param4;
      local19.y = param8;
      local19.z = param9;
      var local20:Vertex = local19.alternativa3d::next;
      local20.x = param7;
      local20.y = param8;
      local20.z = param9;
      local12 = local13;
      while(local12 != null) {
        local12.alternativa3d::cameraX = param3.alternativa3d::ma * local12.x + param3.alternativa3d::mb * local12.y + param3.alternativa3d::mc * local12.z + param3.alternativa3d::md;
        local12.alternativa3d::cameraY = param3.alternativa3d::me * local12.x + param3.alternativa3d::mf * local12.y + param3.alternativa3d::mg * local12.z + param3.alternativa3d::mh;
        local12.alternativa3d::cameraZ = param3.alternativa3d::mi * local12.x + param3.alternativa3d::mj * local12.y + param3.alternativa3d::mk * local12.z + param3.alternativa3d::ml;
        if(local12.alternativa3d::cameraZ <= 0) {
          return;
        }
        local12 = local12.alternativa3d::next;
      }
      var local21:Number = Number(param1.alternativa3d::viewSizeX);
      var local22:Number = Number(param1.alternativa3d::viewSizeY);
      local12 = local13;
      while(local12 != null) {
        local23 = 1 / local12.alternativa3d::cameraZ;
        local12.alternativa3d::cameraX = local12.alternativa3d::cameraX * local21 * local23;
        local12.alternativa3d::cameraY = local12.alternativa3d::cameraY * local22 * local23;
        local12 = local12.alternativa3d::next;
      }
      param2.alternativa3d::gfx.lineStyle(0,param10 < 0 ? (param3.alternativa3d::culling > 0 ? 16776960 : 65280) : uint(param10),param11);
      param2.alternativa3d::gfx.moveTo(local13.alternativa3d::cameraX,local13.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local14.alternativa3d::cameraX,local14.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local16.alternativa3d::cameraX,local16.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local15.alternativa3d::cameraX,local15.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local13.alternativa3d::cameraX,local13.alternativa3d::cameraY);
      param2.alternativa3d::gfx.moveTo(local17.alternativa3d::cameraX,local17.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local18.alternativa3d::cameraX,local18.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local20.alternativa3d::cameraX,local20.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local19.alternativa3d::cameraX,local19.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local17.alternativa3d::cameraX,local17.alternativa3d::cameraY);
      param2.alternativa3d::gfx.moveTo(local13.alternativa3d::cameraX,local13.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local17.alternativa3d::cameraX,local17.alternativa3d::cameraY);
      param2.alternativa3d::gfx.moveTo(local14.alternativa3d::cameraX,local14.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local18.alternativa3d::cameraX,local18.alternativa3d::cameraY);
      param2.alternativa3d::gfx.moveTo(local16.alternativa3d::cameraX,local16.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local20.alternativa3d::cameraX,local20.alternativa3d::cameraY);
      param2.alternativa3d::gfx.moveTo(local15.alternativa3d::cameraX,local15.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local19.alternativa3d::cameraX,local19.alternativa3d::cameraY);
    }

    alternativa3d static function drawKDNode(param1:Camera3D, param2:Canvas, param3:Object3D, param4:int, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number) : void {
      var local13:Vertex = null;
      var local20:Number = NaN;
      var local14:Vertex = nodeVertexList;
      var local15:Vertex = local14.alternativa3d::next;
      var local16:Vertex = local15.alternativa3d::next;
      var local17:Vertex = local16.alternativa3d::next;
      if(param4 == 0) {
        local14.x = param5;
        local14.y = param7;
        local14.z = param11;
        local15.x = param5;
        local15.y = param10;
        local15.z = param11;
        local16.x = param5;
        local16.y = param10;
        local16.z = param8;
        local17.x = param5;
        local17.y = param7;
        local17.z = param8;
      } else if(param4 == 1) {
        local14.x = param9;
        local14.y = param5;
        local14.z = param11;
        local15.x = param6;
        local15.y = param5;
        local15.z = param11;
        local16.x = param6;
        local16.y = param5;
        local16.z = param8;
        local17.x = param9;
        local17.y = param5;
        local17.z = param8;
      } else {
        local14.x = param6;
        local14.y = param7;
        local14.z = param5;
        local15.x = param9;
        local15.y = param7;
        local15.z = param5;
        local16.x = param9;
        local16.y = param10;
        local16.z = param5;
        local17.x = param6;
        local17.y = param10;
        local17.z = param5;
      }
      local13 = local14;
      while(local13 != null) {
        local13.alternativa3d::cameraX = param3.alternativa3d::ma * local13.x + param3.alternativa3d::mb * local13.y + param3.alternativa3d::mc * local13.z + param3.alternativa3d::md;
        local13.alternativa3d::cameraY = param3.alternativa3d::me * local13.x + param3.alternativa3d::mf * local13.y + param3.alternativa3d::mg * local13.z + param3.alternativa3d::mh;
        local13.alternativa3d::cameraZ = param3.alternativa3d::mi * local13.x + param3.alternativa3d::mj * local13.y + param3.alternativa3d::mk * local13.z + param3.alternativa3d::ml;
        if(local13.alternativa3d::cameraZ <= 0) {
          return;
        }
        local13 = local13.alternativa3d::next;
      }
      var local18:Number = Number(param1.alternativa3d::viewSizeX);
      var local19:Number = Number(param1.alternativa3d::viewSizeY);
      local13 = local14;
      while(local13 != null) {
        local20 = 1 / local13.alternativa3d::cameraZ;
        local13.alternativa3d::cameraX = local13.alternativa3d::cameraX * local18 * local20;
        local13.alternativa3d::cameraY = local13.alternativa3d::cameraY * local19 * local20;
        local13 = local13.alternativa3d::next;
      }
      param2.alternativa3d::gfx.lineStyle(0,param4 == 0 ? 16711680 : (param4 == 1 ? 65280 : 255),param12);
      param2.alternativa3d::gfx.moveTo(local14.alternativa3d::cameraX,local14.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local15.alternativa3d::cameraX,local15.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local16.alternativa3d::cameraX,local16.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local17.alternativa3d::cameraX,local17.alternativa3d::cameraY);
      param2.alternativa3d::gfx.lineTo(local14.alternativa3d::cameraX,local14.alternativa3d::cameraY);
    }

    alternativa3d static function drawBone(param1:Canvas, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:int) : void {
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local8:Number = param4 - param2;
      var local9:Number = param5 - param3;
      var local10:Number = Math.sqrt(local8 * local8 + local9 * local9);
      if(local10 > 0.001) {
        local8 /= local10;
        local9 /= local10;
        local11 = local9 * param6;
        local12 = -local8 * param6;
        local13 = -local9 * param6;
        local14 = local8 * param6;
        if(local10 > param6 * 2) {
          local10 = param6;
        } else {
          local10 /= 2;
        }
        param1.alternativa3d::gfx.lineStyle(1,param7);
        param1.alternativa3d::gfx.beginFill(param7,0.6);
        param1.alternativa3d::gfx.moveTo(param2,param3);
        param1.alternativa3d::gfx.lineTo(param2 + local8 * local10 + local11,param3 + local9 * local10 + local12);
        param1.alternativa3d::gfx.lineTo(param4,param5);
        param1.alternativa3d::gfx.lineTo(param2 + local8 * local10 + local13,param3 + local9 * local10 + local14);
        param1.alternativa3d::gfx.lineTo(param2,param3);
        param1.alternativa3d::gfx.endFill();
      }
    }
  }
}
