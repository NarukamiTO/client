package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import flash.display.Sprite;

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

    alternativa3d static function drawEdges(param1:Camera3D, param2:Face, param3:int) : void {
      var local6:Number = NaN;
      var local9:Wrapper = null;
      var local10:Vertex = null;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local4:Number = Number(param1.alternativa3d::viewSizeX);
      var local5:Number = Number(param1.alternativa3d::viewSizeY);
      var local7:Sprite = param1.view.alternativa3d::canvas;
      local7.graphics.lineStyle(0,param3);
      var local8:Face = param2;
      while(local8 != null) {
        local9 = local8.alternativa3d::wrapper;
        local10 = local9.alternativa3d::vertex;
        local6 = 1 / local10.alternativa3d::cameraZ;
        local11 = local10.alternativa3d::cameraX * local4 * local6;
        local12 = local10.alternativa3d::cameraY * local5 * local6;
        local7.graphics.moveTo(local11,local12);
        local9 = local9.alternativa3d::next;
        while(local9 != null) {
          local10 = local9.alternativa3d::vertex;
          local6 = 1 / local10.alternativa3d::cameraZ;
          local7.graphics.lineTo(local10.alternativa3d::cameraX * local4 * local6,local10.alternativa3d::cameraY * local5 * local6);
          local9 = local9.alternativa3d::next;
        }
        local7.graphics.lineTo(local11,local12);
        local8 = local8.alternativa3d::processNext;
      }
    }

    alternativa3d static function drawBounds(param1:Camera3D, param2:Object3D, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:int = -1, param10:Number = 1) : void {
      var local11:Vertex = null;
      var local23:Number = NaN;
      var local12:Vertex = boundVertexList;
      local12.x = param3;
      local12.y = param4;
      local12.z = param5;
      var local13:Vertex = local12.alternativa3d::next;
      local13.x = param6;
      local13.y = param4;
      local13.z = param5;
      var local14:Vertex = local13.alternativa3d::next;
      local14.x = param3;
      local14.y = param7;
      local14.z = param5;
      var local15:Vertex = local14.alternativa3d::next;
      local15.x = param6;
      local15.y = param7;
      local15.z = param5;
      var local16:Vertex = local15.alternativa3d::next;
      local16.x = param3;
      local16.y = param4;
      local16.z = param8;
      var local17:Vertex = local16.alternativa3d::next;
      local17.x = param6;
      local17.y = param4;
      local17.z = param8;
      var local18:Vertex = local17.alternativa3d::next;
      local18.x = param3;
      local18.y = param7;
      local18.z = param8;
      var local19:Vertex = local18.alternativa3d::next;
      local19.x = param6;
      local19.y = param7;
      local19.z = param8;
      local11 = local12;
      while(local11 != null) {
        local11.alternativa3d::cameraX = param2.alternativa3d::ma * local11.x + param2.alternativa3d::mb * local11.y + param2.alternativa3d::mc * local11.z + param2.alternativa3d::md;
        local11.alternativa3d::cameraY = param2.alternativa3d::me * local11.x + param2.alternativa3d::mf * local11.y + param2.alternativa3d::mg * local11.z + param2.alternativa3d::mh;
        local11.alternativa3d::cameraZ = param2.alternativa3d::mi * local11.x + param2.alternativa3d::mj * local11.y + param2.alternativa3d::mk * local11.z + param2.alternativa3d::ml;
        if(local11.alternativa3d::cameraZ <= 0) {
          return;
        }
        local11 = local11.alternativa3d::next;
      }
      var local20:Number = Number(param1.alternativa3d::viewSizeX);
      var local21:Number = Number(param1.alternativa3d::viewSizeY);
      local11 = local12;
      while(local11 != null) {
        local23 = 1 / local11.alternativa3d::cameraZ;
        local11.alternativa3d::cameraX = local11.alternativa3d::cameraX * local20 * local23;
        local11.alternativa3d::cameraY = local11.alternativa3d::cameraY * local21 * local23;
        local11 = local11.alternativa3d::next;
      }
      var local22:Sprite = param1.view.alternativa3d::canvas;
      local22.graphics.lineStyle(0,param9 < 0 ? (param2.alternativa3d::culling > 0 ? 16776960 : 65280) : uint(param9),param10);
      local22.graphics.moveTo(local12.alternativa3d::cameraX,local12.alternativa3d::cameraY);
      local22.graphics.lineTo(local13.alternativa3d::cameraX,local13.alternativa3d::cameraY);
      local22.graphics.lineTo(local15.alternativa3d::cameraX,local15.alternativa3d::cameraY);
      local22.graphics.lineTo(local14.alternativa3d::cameraX,local14.alternativa3d::cameraY);
      local22.graphics.lineTo(local12.alternativa3d::cameraX,local12.alternativa3d::cameraY);
      local22.graphics.moveTo(local16.alternativa3d::cameraX,local16.alternativa3d::cameraY);
      local22.graphics.lineTo(local17.alternativa3d::cameraX,local17.alternativa3d::cameraY);
      local22.graphics.lineTo(local19.alternativa3d::cameraX,local19.alternativa3d::cameraY);
      local22.graphics.lineTo(local18.alternativa3d::cameraX,local18.alternativa3d::cameraY);
      local22.graphics.lineTo(local16.alternativa3d::cameraX,local16.alternativa3d::cameraY);
      local22.graphics.moveTo(local12.alternativa3d::cameraX,local12.alternativa3d::cameraY);
      local22.graphics.lineTo(local16.alternativa3d::cameraX,local16.alternativa3d::cameraY);
      local22.graphics.moveTo(local13.alternativa3d::cameraX,local13.alternativa3d::cameraY);
      local22.graphics.lineTo(local17.alternativa3d::cameraX,local17.alternativa3d::cameraY);
      local22.graphics.moveTo(local15.alternativa3d::cameraX,local15.alternativa3d::cameraY);
      local22.graphics.lineTo(local19.alternativa3d::cameraX,local19.alternativa3d::cameraY);
      local22.graphics.moveTo(local14.alternativa3d::cameraX,local14.alternativa3d::cameraY);
      local22.graphics.lineTo(local18.alternativa3d::cameraX,local18.alternativa3d::cameraY);
    }

    alternativa3d static function drawKDNode(param1:Camera3D, param2:Object3D, param3:int, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number) : void {
      var local12:Vertex = null;
      var local20:Number = NaN;
      var local13:Vertex = nodeVertexList;
      var local14:Vertex = local13.alternativa3d::next;
      var local15:Vertex = local14.alternativa3d::next;
      var local16:Vertex = local15.alternativa3d::next;
      if(param3 == 0) {
        local13.x = param4;
        local13.y = param6;
        local13.z = param10;
        local14.x = param4;
        local14.y = param9;
        local14.z = param10;
        local15.x = param4;
        local15.y = param9;
        local15.z = param7;
        local16.x = param4;
        local16.y = param6;
        local16.z = param7;
      } else if(param3 == 1) {
        local13.x = param8;
        local13.y = param4;
        local13.z = param10;
        local14.x = param5;
        local14.y = param4;
        local14.z = param10;
        local15.x = param5;
        local15.y = param4;
        local15.z = param7;
        local16.x = param8;
        local16.y = param4;
        local16.z = param7;
      } else {
        local13.x = param5;
        local13.y = param6;
        local13.z = param4;
        local14.x = param8;
        local14.y = param6;
        local14.z = param4;
        local15.x = param8;
        local15.y = param9;
        local15.z = param4;
        local16.x = param5;
        local16.y = param9;
        local16.z = param4;
      }
      local12 = local13;
      while(local12 != null) {
        local12.alternativa3d::cameraX = param2.alternativa3d::ma * local12.x + param2.alternativa3d::mb * local12.y + param2.alternativa3d::mc * local12.z + param2.alternativa3d::md;
        local12.alternativa3d::cameraY = param2.alternativa3d::me * local12.x + param2.alternativa3d::mf * local12.y + param2.alternativa3d::mg * local12.z + param2.alternativa3d::mh;
        local12.alternativa3d::cameraZ = param2.alternativa3d::mi * local12.x + param2.alternativa3d::mj * local12.y + param2.alternativa3d::mk * local12.z + param2.alternativa3d::ml;
        if(local12.alternativa3d::cameraZ <= 0) {
          return;
        }
        local12 = local12.alternativa3d::next;
      }
      var local17:Number = Number(param1.alternativa3d::viewSizeX);
      var local18:Number = Number(param1.alternativa3d::viewSizeY);
      local12 = local13;
      while(local12 != null) {
        local20 = 1 / local12.alternativa3d::cameraZ;
        local12.alternativa3d::cameraX = local12.alternativa3d::cameraX * local17 * local20;
        local12.alternativa3d::cameraY = local12.alternativa3d::cameraY * local18 * local20;
        local12 = local12.alternativa3d::next;
      }
      var local19:Sprite = param1.view.alternativa3d::canvas;
      local19.graphics.lineStyle(0,param3 == 0 ? 16711680 : (param3 == 1 ? 65280 : 255),param11);
      local19.graphics.moveTo(local13.alternativa3d::cameraX,local13.alternativa3d::cameraY);
      local19.graphics.lineTo(local14.alternativa3d::cameraX,local14.alternativa3d::cameraY);
      local19.graphics.lineTo(local15.alternativa3d::cameraX,local15.alternativa3d::cameraY);
      local19.graphics.lineTo(local16.alternativa3d::cameraX,local16.alternativa3d::cameraY);
      local19.graphics.lineTo(local13.alternativa3d::cameraX,local13.alternativa3d::cameraY);
    }

    alternativa3d static function drawBone(param1:Camera3D, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:int) : void {
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Sprite = null;
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
        local15 = param1.view.alternativa3d::canvas;
        local15.graphics.lineStyle(1,param7);
        local15.graphics.beginFill(param7,0.6);
        local15.graphics.moveTo(param2,param3);
        local15.graphics.lineTo(param2 + local8 * local10 + local11,param3 + local9 * local10 + local12);
        local15.graphics.lineTo(param4,param5);
        local15.graphics.lineTo(param2 + local8 * local10 + local13,param3 + local9 * local10 + local14);
        local15.graphics.lineTo(param2,param3);
        local15.graphics.endFill();
      }
    }
  }
}
