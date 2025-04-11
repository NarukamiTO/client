package alternativa.engine3d.objects {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.RayIntersectionData;
  import alternativa.engine3d.core.VG;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.materials.TextureMaterial;
  import flash.display.BitmapData;
  import flash.geom.Matrix3D;
  import flash.geom.Vector3D;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class Sprite3D extends Object3D {
    private static var tma:Number;
    private static var tmb:Number;
    private static var tmc:Number;
    private static var tmd:Number;
    private static var tmtx:Number;
    private static var tmty:Number;

    public var material:Material;
    public var originX:Number = 0.5;
    public var originY:Number = 0.5;
    public var sorting:int = 0;
    public var clipping:int = 2;
    public var rotation:Number = 0;
    public var autoSize:Boolean = false;
    public var width:Number;
    public var height:Number;
    public var perspectiveScale:Boolean = true;
    public var topLeftU:Number = 0;
    public var topLeftV:Number = 0;
    public var bottomRightU:Number = 1;
    public var bottomRightV:Number = 1;
    public var depthTest:Boolean = true;

    public function Sprite3D(param1:Number, param2:Number, param3:Material = null) {
      super();
      this.width = param1;
      this.height = param2;
      this.material = param3;
      shadowMapAlphaThreshold = 100;
    }

    override public function calculateResolution(param1:int, param2:int, param3:int = 1, param4:Matrix3D = null) : Number {
      var local9:BitmapData = null;
      var local10:Object3D = null;
      var local11:Number = NaN;
      var local5:Number = this.width;
      var local6:Number = this.height;
      var local7:Number = this.bottomRightU - this.topLeftU;
      var local8:Number = this.bottomRightV - this.topLeftV;
      if(this.autoSize && this.material is TextureMaterial) {
        local9 = (this.material as TextureMaterial).texture;
        if(local9 != null) {
          local5 = local9.width * local7;
          local6 = local9.height * local8;
        }
      }
      if(param4 != null) {
        local10 = new Object3D();
        local10.matrix = param4;
        local10.alternativa3d::composeMatrix();
        local11 = (Math.sqrt(local10.alternativa3d::ma * local10.alternativa3d::ma + local10.alternativa3d::me * local10.alternativa3d::me + local10.alternativa3d::mi * local10.alternativa3d::mi) + Math.sqrt(local10.alternativa3d::mb * local10.alternativa3d::mb + local10.alternativa3d::mf * local10.alternativa3d::mf + local10.alternativa3d::mj * local10.alternativa3d::mj) + Math.sqrt(local10.alternativa3d::mc * local10.alternativa3d::mc + local10.alternativa3d::mg * local10.alternativa3d::mg + local10.alternativa3d::mk * local10.alternativa3d::mk)) / 3;
        local5 *= local11;
        local6 *= local11;
      }
      local5 /= param1 * local7;
      local6 /= param2 * local8;
      if(param3 == 0) {
        return local5;
      }
      if(param3 == 1) {
        return (local5 + local6) / 2;
      }
      if(param3 == 2) {
        return local5 < local6 ? local5 : local6;
      }
      return local5 > local6 ? local5 : local6;
    }

    override public function intersectRay(param1:Vector3D, param2:Vector3D, param3:Dictionary = null, param4:Camera3D = null) : RayIntersectionData {
      var local5:RayIntersectionData = null;
      var local24:Vertex = null;
      var local25:Number = NaN;
      var local26:Number = NaN;
      var local27:Number = NaN;
      var local28:Number = NaN;
      var local29:Number = NaN;
      var local30:Vector3D = null;
      if(param4 == null || param3 != null && param3[this]) {
        return null;
      }
      param4.alternativa3d::composeCameraMatrix();
      var local6:Object3D = param4;
      while(local6.alternativa3d::_parent != null) {
        local6 = local6.alternativa3d::_parent;
        local6.alternativa3d::composeMatrix();
        param4.alternativa3d::appendMatrix(local6);
      }
      param4.alternativa3d::invertMatrix();
      alternativa3d::composeMatrix();
      local6 = this;
      while(local6.alternativa3d::_parent != null) {
        local6 = local6.alternativa3d::_parent;
        local6.alternativa3d::composeMatrix();
        alternativa3d::appendMatrix(local6);
      }
      alternativa3d::appendMatrix(param4);
      alternativa3d::calculateInverseMatrix();
      var local7:Number = param4.nearClipping;
      var local8:Number = param4.farClipping;
      param4.nearClipping = -Number.MAX_VALUE;
      param4.farClipping = Number.MAX_VALUE;
      alternativa3d::culling = 0;
      var local9:Face = this.calculateFace(param4);
      param4.nearClipping = local7;
      param4.farClipping = local8;
      var local10:Wrapper = local9.alternativa3d::wrapper;
      while(local10 != null) {
        local24 = local10.alternativa3d::vertex;
        local24.x = alternativa3d::ima * local24.alternativa3d::cameraX + alternativa3d::imb * local24.alternativa3d::cameraY + alternativa3d::imc * local24.alternativa3d::cameraZ + alternativa3d::imd;
        local24.y = alternativa3d::ime * local24.alternativa3d::cameraX + alternativa3d::imf * local24.alternativa3d::cameraY + alternativa3d::img * local24.alternativa3d::cameraZ + alternativa3d::imh;
        local24.z = alternativa3d::imi * local24.alternativa3d::cameraX + alternativa3d::imj * local24.alternativa3d::cameraY + alternativa3d::imk * local24.alternativa3d::cameraZ + alternativa3d::iml;
        local10 = local10.alternativa3d::next;
      }
      var local11:Wrapper = local9.alternativa3d::wrapper;
      var local12:Vertex = local11.alternativa3d::vertex;
      local11 = local11.alternativa3d::next;
      var local13:Vertex = local11.alternativa3d::vertex;
      local11 = local11.alternativa3d::next;
      var local14:Vertex = local11.alternativa3d::vertex;
      local11 = local11.alternativa3d::next;
      var local15:Vertex = local11.alternativa3d::vertex;
      local12.u = this.topLeftU;
      local12.v = this.topLeftV;
      local13.u = this.topLeftU;
      local13.v = this.bottomRightV;
      local14.u = this.bottomRightU;
      local14.v = this.bottomRightV;
      local15.u = this.bottomRightU;
      local15.v = this.topLeftV;
      var local16:Number = local13.x - local12.x;
      var local17:Number = local13.y - local12.y;
      var local18:Number = local13.z - local12.z;
      var local19:Number = local14.x - local12.x;
      var local20:Number = local14.y - local12.y;
      var local21:Number = local14.z - local12.z;
      local9.alternativa3d::normalX = local21 * local17 - local20 * local18;
      local9.alternativa3d::normalY = local19 * local18 - local21 * local16;
      local9.alternativa3d::normalZ = local20 * local16 - local19 * local17;
      var local22:Number = 1 / Math.sqrt(local9.alternativa3d::normalX * local9.alternativa3d::normalX + local9.alternativa3d::normalY * local9.alternativa3d::normalY + local9.alternativa3d::normalZ * local9.alternativa3d::normalZ);
      local9.alternativa3d::normalX *= local22;
      local9.alternativa3d::normalY *= local22;
      local9.alternativa3d::normalZ *= local22;
      local9.alternativa3d::offset = local12.x * local9.alternativa3d::normalX + local12.y * local9.alternativa3d::normalY + local12.z * local9.alternativa3d::normalZ;
      var local23:Number = param2.x * local9.alternativa3d::normalX + param2.y * local9.alternativa3d::normalY + param2.z * local9.alternativa3d::normalZ;
      if(local23 < 0) {
        local25 = param1.x * local9.alternativa3d::normalX + param1.y * local9.alternativa3d::normalY + param1.z * local9.alternativa3d::normalZ - local9.alternativa3d::offset;
        if(local25 > 0) {
          local26 = -local25 / local23;
          local27 = param1.x + param2.x * local26;
          local28 = param1.y + param2.y * local26;
          local29 = param1.z + param2.z * local26;
          local10 = local9.alternativa3d::wrapper;
          while(local10 != null) {
            local12 = local10.alternativa3d::vertex;
            local13 = local10.alternativa3d::next != null ? local10.alternativa3d::next.alternativa3d::vertex : local9.alternativa3d::wrapper.alternativa3d::vertex;
            local16 = local13.x - local12.x;
            local17 = local13.y - local12.y;
            local18 = local13.z - local12.z;
            local19 = local27 - local12.x;
            local20 = local28 - local12.y;
            local21 = local29 - local12.z;
            if((local21 * local17 - local20 * local18) * local9.alternativa3d::normalX + (local19 * local18 - local21 * local16) * local9.alternativa3d::normalY + (local20 * local16 - local19 * local17) * local9.alternativa3d::normalZ < 0) {
              break;
            }
            local10 = local10.alternativa3d::next;
          }
          if(local10 == null) {
            local30 = new Vector3D(local27,local28,local29);
            local5 = new RayIntersectionData();
            local5.object = this;
            local5.face = null;
            local5.point = local30;
            local5.uv = local9.getUV(local30);
            local5.time = local26;
          }
        }
      }
      param4.alternativa3d::deferredDestroy();
      return local5;
    }

    override public function clone() : Object3D {
      var local1:Sprite3D = new Sprite3D(this.width,this.height);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      super.clonePropertiesFrom(param1);
      var local2:Sprite3D = param1 as Sprite3D;
      this.width = local2.width;
      this.height = local2.height;
      this.autoSize = local2.autoSize;
      this.material = local2.material;
      this.clipping = local2.clipping;
      this.sorting = local2.sorting;
      this.originX = local2.originX;
      this.originY = local2.originY;
      this.topLeftU = local2.topLeftU;
      this.topLeftV = local2.topLeftV;
      this.bottomRightU = local2.bottomRightU;
      this.bottomRightV = local2.bottomRightV;
      this.rotation = local2.rotation;
      this.perspectiveScale = local2.perspectiveScale;
    }

    override alternativa3d function draw(param1:Camera3D, param2:Canvas) : void {
      var local3:Canvas = null;
      var local4:int = 0;
      if(this.material == null) {
        return;
      }
      var local5:Face = this.calculateFace(param1);
      if(local5 != null) {
        alternativa3d::calculateInverseMatrix();
        if(param1.debug && (local4 = int(param1.alternativa3d::checkInDebug(this))) > 0) {
          local3 = param2.alternativa3d::getChildCanvas(true,false);
          if(Boolean(local4 & Debug.EDGES)) {
            Debug.alternativa3d::drawEdges(param1,local3,local5,16777215);
          }
          if(Boolean(local4 & Debug.BOUNDS)) {
            Debug.alternativa3d::drawBounds(param1,local3,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
          }
        }
        local3 = param2.alternativa3d::getChildCanvas(true,false,this,alpha,blendMode,colorTransform,filters);
        this.material.alternativa3d::drawViewAligned(param1,local3,local5,alternativa3d::ml,tma,tmb,tmc,tmd,tmtx,tmty);
      }
    }

    override alternativa3d function getVG(param1:Camera3D) : VG {
      if(this.material == null) {
        return null;
      }
      var local2:Face = this.calculateFace(param1);
      if(local2 != null) {
        alternativa3d::calculateInverseMatrix();
        local2.alternativa3d::normalX = 0;
        local2.alternativa3d::normalY = 0;
        local2.alternativa3d::normalZ = -1;
        local2.alternativa3d::offset = -alternativa3d::ml;
        return VG.alternativa3d::create(this,local2,this.sorting,param1.debug ? int(param1.alternativa3d::checkInDebug(this)) : 0,true,tma,tmb,tmc,tmd,tmtx,tmty);
      }
      return null;
    }

    private function calculateFace(param1:Camera3D) : Face {
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Vertex = null;
      var local12:Vertex = null;
      var local22:Number = NaN;
      var local25:BitmapData = null;
      var local26:Number = NaN;
      var local27:Number = NaN;
      var local28:Number = NaN;
      var local29:Number = NaN;
      var local30:Number = NaN;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Number = NaN;
      var local34:Number = NaN;
      var local35:Vertex = null;
      var local36:Vertex = null;
      var local37:Vertex = null;
      var local38:Vertex = null;
      alternativa3d::culling &= 60;
      var local2:Number = Number(alternativa3d::ml);
      if(local2 <= param1.nearClipping || local2 >= param1.farClipping) {
        return null;
      }
      var local13:Number = this.width;
      var local14:Number = this.height;
      var local15:Number = this.bottomRightU - this.topLeftU;
      var local16:Number = this.bottomRightV - this.topLeftV;
      if(this.autoSize && this.material is TextureMaterial) {
        local25 = (this.material as TextureMaterial).texture;
        if(local25 != null) {
          local13 = local25.width * local15;
          local14 = local25.height * local16;
        }
      }
      var local17:Number = param1.alternativa3d::viewSizeX / local2;
      var local18:Number = param1.alternativa3d::viewSizeY / local2;
      var local19:Number = param1.alternativa3d::focalLength / local2;
      var local20:Number = param1.alternativa3d::focalLength / param1.alternativa3d::viewSizeX;
      var local21:Number = param1.alternativa3d::focalLength / param1.alternativa3d::viewSizeY;
      local3 = alternativa3d::ma / local20;
      local4 = alternativa3d::me / local21;
      local22 = Math.sqrt(local3 * local3 + local4 * local4 + alternativa3d::mi * alternativa3d::mi);
      local3 = alternativa3d::mb / local20;
      local4 = alternativa3d::mf / local21;
      local22 += Math.sqrt(local3 * local3 + local4 * local4 + alternativa3d::mj * alternativa3d::mj);
      local3 = alternativa3d::mc / local20;
      local4 = alternativa3d::mg / local21;
      local22 += Math.sqrt(local3 * local3 + local4 * local4 + alternativa3d::mk * alternativa3d::mk);
      local22 /= 3;
      if(!this.perspectiveScale) {
        local22 /= local19;
      }
      if(this.rotation == 0) {
        local26 = local22 * local13 * local20;
        local27 = local22 * local14 * local21;
        local3 = alternativa3d::md - this.originX * local26;
        local4 = alternativa3d::mh - this.originY * local27;
        local7 = local3 + local26;
        local8 = local4 + local27;
        tmtx = (local3 - local26 * this.topLeftU / local15) * local17;
        tmty = (local4 - local27 * this.topLeftV / local16) * local18;
        if(alternativa3d::culling > 0) {
          if(local3 > local2 || local4 > local2 || local7 < -local2 || local8 < -local2) {
            return null;
          }
          if(this.clipping == 2) {
            if(local3 < -local2) {
              local3 = -local2;
            }
            if(local4 < -local2) {
              local4 = -local2;
            }
            if(local7 > local2) {
              local7 = local2;
            }
            if(local8 > local2) {
              local8 = local2;
            }
          }
        }
        local11 = Vertex.alternativa3d::createList(4);
        local12 = local11;
        local12.alternativa3d::cameraX = local3;
        local12.alternativa3d::cameraY = local4;
        local12.alternativa3d::cameraZ = local2;
        local12 = local12.alternativa3d::next;
        local12.alternativa3d::cameraX = local3;
        local12.alternativa3d::cameraY = local8;
        local12.alternativa3d::cameraZ = local2;
        local12 = local12.alternativa3d::next;
        local12.alternativa3d::cameraX = local7;
        local12.alternativa3d::cameraY = local8;
        local12.alternativa3d::cameraZ = local2;
        local12 = local12.alternativa3d::next;
        local12.alternativa3d::cameraX = local7;
        local12.alternativa3d::cameraY = local4;
        local12.alternativa3d::cameraZ = local2;
        tma = local22 * local19 * local13 / local15;
        tmb = 0;
        tmc = 0;
        tmd = local22 * local19 * local14 / local16;
      } else {
        local28 = -Math.sin(this.rotation) * local22;
        local29 = Math.cos(this.rotation) * local22;
        local30 = local29 * local13 * local20;
        local31 = -local28 * local13 * local21;
        local32 = local28 * local14 * local20;
        local33 = local29 * local14 * local21;
        local3 = alternativa3d::md - this.originX * local30 - this.originY * local32;
        local4 = alternativa3d::mh - this.originX * local31 - this.originY * local33;
        local5 = local3 + local32;
        local6 = local4 + local33;
        local7 = local3 + local30 + local32;
        local8 = local4 + local31 + local33;
        local9 = local3 + local30;
        local10 = local4 + local31;
        tmtx = (local3 - local30 * this.topLeftU / local15 - local32 * this.topLeftV / local16) * local17;
        tmty = (local4 - local31 * this.topLeftU / local15 - local33 * this.topLeftV / local16) * local18;
        if(alternativa3d::culling > 0) {
          if(this.clipping == 1) {
            if(alternativa3d::culling & 4 && local2 <= -local3 && local2 <= -local5 && local2 <= -local7 && local2 <= -local9) {
              return null;
            }
            if(alternativa3d::culling & 8 && local2 <= local3 && local2 <= local5 && local2 <= local7 && local2 <= local9) {
              return null;
            }
            if(alternativa3d::culling & 0x10 && local2 <= -local4 && local2 <= -local6 && local2 <= -local8 && local2 <= -local10) {
              return null;
            }
            if(alternativa3d::culling & 0x20 && local2 <= local4 && local2 <= local6 && local2 <= local8 && local2 <= local10) {
              return null;
            }
            local11 = Vertex.alternativa3d::createList(4);
            local12 = local11;
            local12.alternativa3d::cameraX = local3;
            local12.alternativa3d::cameraY = local4;
            local12.alternativa3d::cameraZ = local2;
            local12 = local12.alternativa3d::next;
            local12.alternativa3d::cameraX = local3 + local32;
            local12.alternativa3d::cameraY = local4 + local33;
            local12.alternativa3d::cameraZ = local2;
            local12 = local12.alternativa3d::next;
            local12.alternativa3d::cameraX = local3 + local30 + local32;
            local12.alternativa3d::cameraY = local4 + local31 + local33;
            local12.alternativa3d::cameraZ = local2;
            local12 = local12.alternativa3d::next;
            local12.alternativa3d::cameraX = local3 + local30;
            local12.alternativa3d::cameraY = local4 + local31;
            local12.alternativa3d::cameraZ = local2;
          } else {
            if(Boolean(alternativa3d::culling & 4)) {
              if(local2 <= -local3 && local2 <= -local5 && local2 <= -local7 && local2 <= -local9) {
                return null;
              }
              if(local2 > -local3 && local2 > -local5 && local2 > -local7 && local2 > -local9) {
                alternativa3d::culling &= 59;
              }
            }
            if(Boolean(alternativa3d::culling & 8)) {
              if(local2 <= local3 && local2 <= local5 && local2 <= local7 && local2 <= local9) {
                return null;
              }
              if(local2 > local3 && local2 > local5 && local2 > local7 && local2 > local9) {
                alternativa3d::culling &= 55;
              }
            }
            if(Boolean(alternativa3d::culling & 0x10)) {
              if(local2 <= -local4 && local2 <= -local6 && local2 <= -local8 && local2 <= -local10) {
                return null;
              }
              if(local2 > -local4 && local2 > -local6 && local2 > -local8 && local2 > -local10) {
                alternativa3d::culling &= 47;
              }
            }
            if(Boolean(alternativa3d::culling & 0x20)) {
              if(local2 <= local4 && local2 <= local6 && local2 <= local8 && local2 <= local10) {
                return null;
              }
              if(local2 > local4 && local2 > local6 && local2 > local8 && local2 > local10) {
                alternativa3d::culling &= 31;
              }
            }
            local11 = Vertex.alternativa3d::createList(4);
            local12 = local11;
            local12.alternativa3d::cameraX = local3;
            local12.alternativa3d::cameraY = local4;
            local12.alternativa3d::cameraZ = local2;
            local12 = local12.alternativa3d::next;
            local12.alternativa3d::cameraX = local3 + local32;
            local12.alternativa3d::cameraY = local4 + local33;
            local12.alternativa3d::cameraZ = local2;
            local12 = local12.alternativa3d::next;
            local12.alternativa3d::cameraX = local3 + local30 + local32;
            local12.alternativa3d::cameraY = local4 + local31 + local33;
            local12.alternativa3d::cameraZ = local2;
            local12 = local12.alternativa3d::next;
            local12.alternativa3d::cameraX = local3 + local30;
            local12.alternativa3d::cameraY = local4 + local31;
            local12.alternativa3d::cameraZ = local2;
            if(alternativa3d::culling > 0) {
              if(Boolean(alternativa3d::culling & 4)) {
                local35 = local12;
                local3 = Number(local35.alternativa3d::cameraX);
                local36 = local11;
                local11 = null;
                local12 = null;
                while(local36 != null) {
                  local38 = local36.alternativa3d::next;
                  local5 = Number(local36.alternativa3d::cameraX);
                  if(local2 > -local5 && local2 <= -local3 || local2 <= -local5 && local2 > -local3) {
                    local34 = (local3 + local2) / (local3 - local5);
                    local37 = local36.alternativa3d::create();
                    local37.alternativa3d::cameraX = local3 + (local5 - local3) * local34;
                    local37.alternativa3d::cameraY = local35.alternativa3d::cameraY + (local36.alternativa3d::cameraY - local35.alternativa3d::cameraY) * local34;
                    local37.alternativa3d::cameraZ = local2;
                    if(local11 != null) {
                      local12.alternativa3d::next = local37;
                    } else {
                      local11 = local37;
                    }
                    local12 = local37;
                  }
                  if(local2 > -local5) {
                    if(local11 != null) {
                      local12.alternativa3d::next = local36;
                    } else {
                      local11 = local36;
                    }
                    local12 = local36;
                    local36.alternativa3d::next = null;
                  } else {
                    local36.alternativa3d::next = Vertex.alternativa3d::collector;
                    Vertex.alternativa3d::collector = local36;
                  }
                  local35 = local36;
                  local3 = local5;
                  local36 = local38;
                }
                if(local11 == null) {
                  return null;
                }
              }
              if(Boolean(alternativa3d::culling & 8)) {
                local35 = local12;
                local3 = Number(local35.alternativa3d::cameraX);
                local36 = local11;
                local11 = null;
                local12 = null;
                while(local36 != null) {
                  local38 = local36.alternativa3d::next;
                  local5 = Number(local36.alternativa3d::cameraX);
                  if(local2 > local5 && local2 <= local3 || local2 <= local5 && local2 > local3) {
                    local34 = (local2 - local3) / (local5 - local3);
                    local37 = local36.alternativa3d::create();
                    local37.alternativa3d::cameraX = local3 + (local5 - local3) * local34;
                    local37.alternativa3d::cameraY = local35.alternativa3d::cameraY + (local36.alternativa3d::cameraY - local35.alternativa3d::cameraY) * local34;
                    local37.alternativa3d::cameraZ = local2;
                    if(local11 != null) {
                      local12.alternativa3d::next = local37;
                    } else {
                      local11 = local37;
                    }
                    local12 = local37;
                  }
                  if(local2 > local5) {
                    if(local11 != null) {
                      local12.alternativa3d::next = local36;
                    } else {
                      local11 = local36;
                    }
                    local12 = local36;
                    local36.alternativa3d::next = null;
                  } else {
                    local36.alternativa3d::next = Vertex.alternativa3d::collector;
                    Vertex.alternativa3d::collector = local36;
                  }
                  local35 = local36;
                  local3 = local5;
                  local36 = local38;
                }
                if(local11 == null) {
                  return null;
                }
              }
              if(Boolean(alternativa3d::culling & 0x10)) {
                local35 = local12;
                local4 = Number(local35.alternativa3d::cameraY);
                local36 = local11;
                local11 = null;
                local12 = null;
                while(local36 != null) {
                  local38 = local36.alternativa3d::next;
                  local6 = Number(local36.alternativa3d::cameraY);
                  if(local2 > -local6 && local2 <= -local4 || local2 <= -local6 && local2 > -local4) {
                    local34 = (local4 + local2) / (local4 - local6);
                    local37 = local36.alternativa3d::create();
                    local37.alternativa3d::cameraX = local35.alternativa3d::cameraX + (local36.alternativa3d::cameraX - local35.alternativa3d::cameraX) * local34;
                    local37.alternativa3d::cameraY = local4 + (local6 - local4) * local34;
                    local37.alternativa3d::cameraZ = local2;
                    if(local11 != null) {
                      local12.alternativa3d::next = local37;
                    } else {
                      local11 = local37;
                    }
                    local12 = local37;
                  }
                  if(local2 > -local6) {
                    if(local11 != null) {
                      local12.alternativa3d::next = local36;
                    } else {
                      local11 = local36;
                    }
                    local12 = local36;
                    local36.alternativa3d::next = null;
                  } else {
                    local36.alternativa3d::next = Vertex.alternativa3d::collector;
                    Vertex.alternativa3d::collector = local36;
                  }
                  local35 = local36;
                  local4 = local6;
                  local36 = local38;
                }
                if(local11 == null) {
                  return null;
                }
              }
              if(Boolean(alternativa3d::culling & 0x20)) {
                local35 = local12;
                local4 = Number(local35.alternativa3d::cameraY);
                local36 = local11;
                local11 = null;
                local12 = null;
                while(local36 != null) {
                  local38 = local36.alternativa3d::next;
                  local6 = Number(local36.alternativa3d::cameraY);
                  if(local2 > local6 && local2 <= local4 || local2 <= local6 && local2 > local4) {
                    local34 = (local2 - local4) / (local6 - local4);
                    local37 = local36.alternativa3d::create();
                    local37.alternativa3d::cameraX = local35.alternativa3d::cameraX + (local36.alternativa3d::cameraX - local35.alternativa3d::cameraX) * local34;
                    local37.alternativa3d::cameraY = local4 + (local6 - local4) * local34;
                    local37.alternativa3d::cameraZ = local2;
                    if(local11 != null) {
                      local12.alternativa3d::next = local37;
                    } else {
                      local11 = local37;
                    }
                    local12 = local37;
                  }
                  if(local2 > local6) {
                    if(local11 != null) {
                      local12.alternativa3d::next = local36;
                    } else {
                      local11 = local36;
                    }
                    local12 = local36;
                    local36.alternativa3d::next = null;
                  } else {
                    local36.alternativa3d::next = Vertex.alternativa3d::collector;
                    Vertex.alternativa3d::collector = local36;
                  }
                  local35 = local36;
                  local4 = local6;
                  local36 = local38;
                }
                if(local11 == null) {
                  return null;
                }
              }
            }
          }
        } else {
          local11 = Vertex.alternativa3d::createList(4);
          local12 = local11;
          local12.alternativa3d::cameraX = local3;
          local12.alternativa3d::cameraY = local4;
          local12.alternativa3d::cameraZ = local2;
          local12 = local12.alternativa3d::next;
          local12.alternativa3d::cameraX = local3 + local32;
          local12.alternativa3d::cameraY = local4 + local33;
          local12.alternativa3d::cameraZ = local2;
          local12 = local12.alternativa3d::next;
          local12.alternativa3d::cameraX = local3 + local30 + local32;
          local12.alternativa3d::cameraY = local4 + local31 + local33;
          local12.alternativa3d::cameraZ = local2;
          local12 = local12.alternativa3d::next;
          local12.alternativa3d::cameraX = local3 + local30;
          local12.alternativa3d::cameraY = local4 + local31;
          local12.alternativa3d::cameraZ = local2;
        }
        tma = local29 * local19 * local13 / local15;
        tmb = -local28 * local19 * local13 / local15;
        tmc = local28 * local19 * local14 / local16;
        tmd = local29 * local19 * local14 / local16;
      }
      param1.alternativa3d::lastVertex.alternativa3d::next = local11;
      param1.alternativa3d::lastVertex = local12;
      var local23:Face = Face.alternativa3d::create();
      local23.material = this.material;
      param1.alternativa3d::lastFace.alternativa3d::next = local23;
      param1.alternativa3d::lastFace = local23;
      var local24:Wrapper = Wrapper.alternativa3d::create();
      local23.alternativa3d::wrapper = local24;
      local24.alternativa3d::vertex = local11;
      local11 = local11.alternativa3d::next;
      while(local11 != null) {
        local24.alternativa3d::next = local24.alternativa3d::create();
        local24 = local24.alternativa3d::next;
        local24.alternativa3d::vertex = local11;
        local11 = local11.alternativa3d::next;
      }
      return local23;
    }

    override alternativa3d function updateBounds(param1:Object3D, param2:Object3D = null) : void {
      var local11:BitmapData = null;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local3:Number = this.width;
      var local4:Number = this.height;
      if(this.autoSize && this.material is TextureMaterial) {
        local11 = (this.material as TextureMaterial).texture;
        if(local11 != null) {
          local3 = local11.width * (this.bottomRightU - this.topLeftU);
          local4 = local11.height * (this.bottomRightV - this.topLeftV);
        }
      }
      var local5:Number = (this.originX >= 0.5 ? this.originX : 1 - this.originX) * local3;
      var local6:Number = (this.originY >= 0.5 ? this.originY : 1 - this.originY) * local4;
      var local7:Number = Math.sqrt(local5 * local5 + local6 * local6);
      var local8:Number = 0;
      var local9:Number = 0;
      var local10:Number = 0;
      if(param2 != null) {
        local12 = Number(param2.alternativa3d::ma);
        local13 = Number(param2.alternativa3d::me);
        local14 = Number(param2.alternativa3d::mi);
        local15 = Math.sqrt(local12 * local12 + local13 * local13 + local14 * local14);
        local12 = Number(param2.alternativa3d::mb);
        local13 = Number(param2.alternativa3d::mf);
        local14 = Number(param2.alternativa3d::mj);
        local15 += Math.sqrt(local12 * local12 + local13 * local13 + local14 * local14);
        local12 = Number(param2.alternativa3d::mc);
        local13 = Number(param2.alternativa3d::mg);
        local14 = Number(param2.alternativa3d::mk);
        local15 += Math.sqrt(local12 * local12 + local13 * local13 + local14 * local14);
        local7 *= local15 / 3;
        local8 = Number(param2.alternativa3d::md);
        local9 = Number(param2.alternativa3d::mh);
        local10 = Number(param2.alternativa3d::ml);
      }
      if(local8 - local7 < param1.boundMinX) {
        param1.boundMinX = local8 - local7;
      }
      if(local8 + local7 > param1.boundMaxX) {
        param1.boundMaxX = local8 + local7;
      }
      if(local9 - local7 < param1.boundMinY) {
        param1.boundMinY = local9 - local7;
      }
      if(local9 + local7 > param1.boundMaxY) {
        param1.boundMaxY = local9 + local7;
      }
      if(local10 - local7 < param1.boundMinZ) {
        param1.boundMinZ = local10 - local7;
      }
      if(local10 + local7 > param1.boundMaxZ) {
        param1.boundMaxZ = local10 + local7;
      }
    }
  }
}
