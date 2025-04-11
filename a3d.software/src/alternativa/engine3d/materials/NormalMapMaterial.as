package alternativa.engine3d.materials {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.lights.AmbientLight;
  import alternativa.engine3d.lights.DirectionalLight;
  import alternativa.engine3d.objects.Sprite3D;
  import flash.display.BitmapData;
  import flash.filters.ColorMatrixFilter;
  import flash.geom.ColorTransform;
  import flash.geom.Matrix3D;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class NormalMapMaterial extends TextureMaterial {
    alternativa3d static const multiplier:ColorTransform = new ColorTransform(2,2,2);
    alternativa3d static const lights:Vector.<Light3D> = new Vector.<Light3D>();
    alternativa3d static const layers:Vector.<Canvas> = new Vector.<Canvas>();
    alternativa3d static const lightmapFilter:ColorMatrixFilter = new ColorMatrixFilter();
    alternativa3d static const lightmapMatrix:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0];
    alternativa3d static const lightmapAmbient:ColorTransform = new ColorTransform();

    alternativa3d var lightmapsMap:Dictionary = new Dictionary();
    alternativa3d var lightmapPoint:Point = new Point();
    alternativa3d var lightmapRect:Rectangle;
    alternativa3d var weights:Dictionary = new Dictionary();
    alternativa3d var _normalMap:BitmapData;

    public var defaultLightWeight:Number = 1;
    public var multipliedDiffuse:Boolean = false;

    public function NormalMapMaterial(param1:BitmapData = null, param2:BitmapData = null, param3:Boolean = false, param4:Boolean = true, param5:int = 0, param6:Number = 1) {
      super(param1,param3,param4,param5,param6);
      this.normalMap = param2;
    }

    public static function transformNormalMap(param1:BitmapData, param2:Matrix3D) : BitmapData {
      var local3:BitmapData = param1.width * param1.height > 16777215 ? param1.clone() : new BitmapData(param1.width,param1.height,param1.transparent);
      var local4:Vector.<Number> = param2.rawData;
      alternativa3d::lightmapMatrix[0] = local4[0];
      alternativa3d::lightmapMatrix[1] = local4[4];
      alternativa3d::lightmapMatrix[2] = local4[8];
      alternativa3d::lightmapMatrix[4] = (1 - local4[0] - local4[4] - local4[8]) * 127.5;
      alternativa3d::lightmapMatrix[5] = local4[1];
      alternativa3d::lightmapMatrix[6] = local4[5];
      alternativa3d::lightmapMatrix[7] = local4[9];
      alternativa3d::lightmapMatrix[9] = (1 - local4[1] - local4[5] - local4[9]) * 127.5;
      alternativa3d::lightmapMatrix[10] = local4[2];
      alternativa3d::lightmapMatrix[11] = local4[6];
      alternativa3d::lightmapMatrix[12] = local4[10];
      alternativa3d::lightmapMatrix[14] = (1 - local4[2] - local4[6] - local4[10]) * 127.5;
      alternativa3d::lightmapFilter.matrix = alternativa3d::lightmapMatrix;
      local3.applyFilter(param1,param1.rect,new Point(),alternativa3d::lightmapFilter);
      return local3;
    }

    public function setLightWeight(param1:Light3D, param2:Number) : void {
      this.alternativa3d::weights[param1] = param2;
    }

    public function getLightWeight(param1:Light3D) : Number {
      var local2:Number = Number(this.alternativa3d::weights[param1]);
      return local2 == local2 ? local2 : this.defaultLightWeight;
    }

    public function setLightWeightToDefault(param1:Light3D) : void {
      delete this.alternativa3d::weights[param1];
    }

    public function setAllLightWeightsToDefault() : void {
      var local1:* = undefined;
      for(local1 in this.alternativa3d::weights) {
        delete this.alternativa3d::weights[local1];
      }
    }

    public function get normalMap() : BitmapData {
      return this.alternativa3d::_normalMap;
    }

    public function set normalMap(param1:BitmapData) : void {
      var local2:* = undefined;
      var local3:BitmapData = null;
      if(param1 != this.alternativa3d::_normalMap) {
        this.alternativa3d::_normalMap = param1;
        for(local2 in this.alternativa3d::lightmapsMap) {
          for each(local3 in this.alternativa3d::lightmapsMap[local2]) {
            local3.dispose();
          }
          delete this.alternativa3d::lightmapsMap[local2];
        }
        if(param1 != null) {
          this.alternativa3d::lightmapRect = this.alternativa3d::_normalMap.rect;
        }
      }
    }

    override public function clone() : Material {
      var local1:NormalMapMaterial = new NormalMapMaterial(alternativa3d::_texture,this.alternativa3d::_normalMap,repeat,smooth,alternativa3d::_mipMapping,resolution);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Material) : void {
      super.clonePropertiesFrom(param1);
      var local2:NormalMapMaterial = param1 as NormalMapMaterial;
      this.defaultLightWeight = local2.defaultLightWeight;
      this.multipliedDiffuse = local2.multipliedDiffuse;
    }

    override alternativa3d function draw(param1:Camera3D, param2:Canvas, param3:Face, param4:Number) : void {
      var local5:Face = null;
      var local6:Face = null;
      var local7:Face = null;
      var local8:Wrapper = null;
      var local9:Vertex = null;
      var local10:int = 0;
      var local11:int = 0;
      var local12:int = 0;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:int = 0;
      var local16:int = 0;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:BitmapData = null;
      var local27:int = 0;
      var local28:int = 0;
      var local29:int = 0;
      var local30:int = 0;
      var local34:Light3D = null;
      var local35:Canvas = null;
      var local42:Number = NaN;
      var local43:DirectionalLight = null;
      var local44:Number = NaN;
      var local45:Number = NaN;
      var local46:Number = NaN;
      var local47:Number = NaN;
      var local48:Number = NaN;
      var local49:Number = NaN;
      var local50:Number = NaN;
      var local51:int = 0;
      var local52:Number = NaN;
      var local53:Number = NaN;
      var local54:Number = NaN;
      var local55:int = 0;
      var local56:int = 0;
      var local57:Wrapper = null;
      var local58:Number = NaN;
      var local59:Number = NaN;
      var local60:Wrapper = null;
      var local61:Number = NaN;
      var local62:Number = NaN;
      var local63:Number = NaN;
      var local64:Boolean = false;
      var local65:Boolean = false;
      var local66:Number = NaN;
      var local67:Face = null;
      var local68:Wrapper = null;
      var local69:Wrapper = null;
      var local70:Wrapper = null;
      var local71:Vertex = null;
      var local72:Vertex = null;
      var local73:Vertex = null;
      var local22:Number = Number(param1.alternativa3d::viewSizeX);
      var local23:Number = Number(param1.alternativa3d::viewSizeY);
      var local24:Vector.<Number> = alternativa3d::drawVertices;
      var local25:Vector.<Number> = alternativa3d::drawUVTs;
      var local26:Vector.<int> = alternativa3d::drawIndices;
      var local31:int = int(param1.alternativa3d::numDraws);
      var local32:int = 0;
      var local33:int = 0;
      if(alternativa3d::_texture == null || this.alternativa3d::_normalMap == null) {
        alternativa3d::clearLinks(param3);
        return;
      }
      var local36:Number = 0;
      var local37:Number = 0;
      var local38:Number = 0;
      var local39:int = 0;
      local15 = 0;
      while(local15 < param1.alternativa3d::lightsLength) {
        local34 = param1.alternativa3d::lights[local15];
        if(local34.intensity > 0) {
          local42 = Number(this.alternativa3d::weights[local34]);
          if(local42 != local42) {
            local42 = this.defaultLightWeight;
          }
          if(local42 > 0) {
            local34.alternativa3d::calculateObjectMatrix(param2.alternativa3d::object);
            if(local34.alternativa3d::checkBoundsIntersection(param2.alternativa3d::object)) {
              if(local34 is AmbientLight) {
                local36 += (local34.color >> 16 & 0xFF) * local34.intensity * local42;
                local37 += (local34.color >> 8 & 0xFF) * local34.intensity * local42;
                local38 += (local34.color & 0xFF) * local34.intensity * local42;
              } else if(local34 is DirectionalLight) {
                local34.alternativa3d::localWeight = local42;
                alternativa3d::lights[local39] = local34;
                local39++;
              }
            }
          }
        }
        local15++;
      }
      var local40:Vector.<BitmapData> = this.alternativa3d::lightmapsMap[param2.alternativa3d::object];
      if(local40 == null) {
        local40 = new Vector.<BitmapData>();
        this.alternativa3d::lightmapsMap[param2.alternativa3d::object] = local40;
      }
      local15 = int(local40.length);
      while(local15 < local39) {
        local40[local15] = new BitmapData(this.alternativa3d::lightmapRect.width,this.alternativa3d::lightmapRect.height,this.alternativa3d::_normalMap.transparent);
        local15++;
      }
      alternativa3d::lightmapAmbient.redOffset = local36;
      alternativa3d::lightmapAmbient.greenOffset = local37;
      alternativa3d::lightmapAmbient.blueOffset = local38;
      var local41:Canvas = param2.alternativa3d::getChildCanvas(local39 <= 1,local39 > 1,param2.alternativa3d::object,1,"multiply",local39 == 1 && (local36 > 0 || local37 > 0 || local38 > 0) ? alternativa3d::lightmapAmbient : null);
      if(local39 <= 1) {
        alternativa3d::layers[0] = local41;
        if(this.alternativa3d::_normalMap.transparent) {
          alternativa3d::lightmapMatrix[0] = 0;
          alternativa3d::lightmapMatrix[1] = 0;
          alternativa3d::lightmapMatrix[2] = 0;
          alternativa3d::lightmapMatrix[4] = local36 > 255 ? 255 : local36;
          alternativa3d::lightmapMatrix[5] = 0;
          alternativa3d::lightmapMatrix[6] = 0;
          alternativa3d::lightmapMatrix[7] = 0;
          alternativa3d::lightmapMatrix[9] = local37 > 255 ? 255 : local37;
          alternativa3d::lightmapMatrix[10] = 0;
          alternativa3d::lightmapMatrix[11] = 0;
          alternativa3d::lightmapMatrix[12] = 0;
          alternativa3d::lightmapMatrix[14] = local38 > 255 ? 255 : local38;
          if(local40.length == 0) {
            local40[0] = new BitmapData(this.alternativa3d::lightmapRect.width,this.alternativa3d::lightmapRect.height,this.alternativa3d::_normalMap.transparent);
          }
          alternativa3d::lightmapFilter.matrix = alternativa3d::lightmapMatrix;
          (local40[0] as BitmapData).applyFilter(this.alternativa3d::_normalMap,this.alternativa3d::lightmapRect,this.alternativa3d::lightmapPoint,alternativa3d::lightmapFilter);
        }
      }
      local15 = 0;
      while(local15 < local39) {
        local43 = alternativa3d::lights[local15] as DirectionalLight;
        local44 = (local43.color >> 16 & 0xFF) * local43.intensity * local43.alternativa3d::localWeight / 255;
        local45 = (local43.color >> 8 & 0xFF) * local43.intensity * local43.alternativa3d::localWeight / 255;
        local46 = (local43.color & 0xFF) * local43.intensity * local43.alternativa3d::localWeight / 255;
        local47 = Number(local43.alternativa3d::omc);
        local48 = Number(local43.alternativa3d::omg);
        local49 = Number(local43.alternativa3d::omk);
        local50 = Math.sqrt(local47 * local47 + local48 * local48 + local49 * local49);
        local47 /= local50;
        local48 /= local50;
        local49 /= local50;
        alternativa3d::lightmapMatrix[0] = -local47 * 2 * local44;
        alternativa3d::lightmapMatrix[1] = -local48 * 2 * local44;
        alternativa3d::lightmapMatrix[2] = -local49 * 2 * local44;
        alternativa3d::lightmapMatrix[4] = (local47 + local48 + local49) * local44 * 255;
        alternativa3d::lightmapMatrix[5] = -local47 * 2 * local45;
        alternativa3d::lightmapMatrix[6] = -local48 * 2 * local45;
        alternativa3d::lightmapMatrix[7] = -local49 * 2 * local45;
        alternativa3d::lightmapMatrix[9] = (local47 + local48 + local49) * local45 * 255;
        alternativa3d::lightmapMatrix[10] = -local47 * 2 * local46;
        alternativa3d::lightmapMatrix[11] = -local48 * 2 * local46;
        alternativa3d::lightmapMatrix[12] = -local49 * 2 * local46;
        alternativa3d::lightmapMatrix[14] = (local47 + local48 + local49) * local46 * 255;
        if(local39 > 1) {
          alternativa3d::layers[local15] = local41.alternativa3d::getChildCanvas(true,false,param2.alternativa3d::object,1,local15 == local39 - 1 ? "normal" : "add",local15 == local39 - 1 && (local36 > 0 || local37 > 0 || local38 > 0) ? alternativa3d::lightmapAmbient : null);
        }
        alternativa3d::lightmapFilter.matrix = alternativa3d::lightmapMatrix;
        (local40[local15] as BitmapData).applyFilter(this.alternativa3d::_normalMap,this.alternativa3d::lightmapRect,this.alternativa3d::lightmapPoint,alternativa3d::lightmapFilter);
        local15++;
      }
      if(!this.multipliedDiffuse) {
        param2 = param2.alternativa3d::getChildCanvas(true,false,param2.alternativa3d::object,1,"normal",alternativa3d::multiplier);
      }
      if(alternativa3d::_mipMapping < 2) {
        local31++;
        local27 = 0;
        local28 = 0;
        local29 = 0;
        local30 = 0;
        local5 = param3;
        while(local5 != null) {
          local6 = local5.alternativa3d::processNext;
          local5.alternativa3d::processNext = null;
          local8 = local5.alternativa3d::wrapper;
          local9 = local8.alternativa3d::vertex;
          if(local9.alternativa3d::drawId != local31) {
            local13 = 1 / local9.alternativa3d::cameraZ;
            local24[local28] = local9.alternativa3d::cameraX * local22 * local13;
            local28++;
            local24[local28] = local9.alternativa3d::cameraY * local23 * local13;
            local28++;
            local25[local29] = local9.u;
            local29++;
            local25[local29] = local9.v;
            local29++;
            local25[local29] = local13;
            local29++;
            local10 = local27;
            local9.alternativa3d::index = local27++;
            local9.alternativa3d::drawId = local31;
          } else {
            local10 = int(local9.alternativa3d::index);
          }
          local8 = local8.alternativa3d::next;
          local9 = local8.alternativa3d::vertex;
          if(local9.alternativa3d::drawId != local31) {
            local13 = 1 / local9.alternativa3d::cameraZ;
            local24[local28] = local9.alternativa3d::cameraX * local22 * local13;
            local28++;
            local24[local28] = local9.alternativa3d::cameraY * local23 * local13;
            local28++;
            local25[local29] = local9.u;
            local29++;
            local25[local29] = local9.v;
            local29++;
            local25[local29] = local13;
            local29++;
            local11 = local27;
            local9.alternativa3d::index = local27++;
            local9.alternativa3d::drawId = local31;
          } else {
            local11 = int(local9.alternativa3d::index);
          }
          local8 = local8.alternativa3d::next;
          while(local8 != null) {
            local9 = local8.alternativa3d::vertex;
            if(local9.alternativa3d::drawId != local31) {
              local13 = 1 / local9.alternativa3d::cameraZ;
              local24[local28] = local9.alternativa3d::cameraX * local22 * local13;
              local28++;
              local24[local28] = local9.alternativa3d::cameraY * local23 * local13;
              local28++;
              local25[local29] = local9.u;
              local29++;
              local25[local29] = local9.v;
              local29++;
              local25[local29] = local13;
              local29++;
              local12 = local27;
              local9.alternativa3d::index = local27++;
              local9.alternativa3d::drawId = local31;
            } else {
              local12 = int(local9.alternativa3d::index);
            }
            alternativa3d::drawIndices[local30] = local10;
            local30++;
            alternativa3d::drawIndices[local30] = local11;
            local30++;
            alternativa3d::drawIndices[local30] = local12;
            local30++;
            local11 = local12;
            local33++;
            local8 = local8.alternativa3d::next;
          }
          local32++;
          local5 = local6;
        }
        local24.length = local28;
        local25.length = local29;
        local26.length = local30;
        if(alternativa3d::_mipMapping == 0) {
          local21 = alternativa3d::_texture;
        } else {
          local14 = param1.alternativa3d::focalLength * resolution;
          local51 = param4 >= local14 ? int(1 + Math.log(param4 / local14) * 1.4426950408889634) : 0;
          if(local51 >= alternativa3d::numMaps) {
            local51 = alternativa3d::numMaps - 1;
          }
          local21 = alternativa3d::mipMap[local51];
        }
        if(correctUV) {
          local19 = -0.5 / (local21.width - 1);
          local20 = -0.5 / (local21.height - 1);
          local17 = 1 - local19 - local19;
          local18 = 1 - local20 - local20;
          local16 = 0;
          while(local16 < local29) {
            local25[local16] = local25[local16] * local17 + local19;
            local16++;
            local25[local16] = local25[local16] * local18 + local20;
            local16++;
            local16++;
          }
        }
        param2.alternativa3d::gfx.beginBitmapFill(local21,null,repeat,smooth);
        param2.alternativa3d::gfx.drawTriangles(local24,local26,local25,"none");
        if(local39 > 0) {
          local16 = 0;
          while(local16 < local39) {
            local35 = alternativa3d::layers[local16];
            local35.alternativa3d::gfx.beginBitmapFill(local40[local16],null,repeat,smooth);
            local35.alternativa3d::gfx.drawTriangles(local24,local26,local25,"none");
            local16++;
          }
        } else {
          local35 = alternativa3d::layers[0];
          if(this.alternativa3d::_normalMap.transparent) {
            local35.alternativa3d::gfx.beginBitmapFill(local40[0],null,repeat,smooth);
            local35.alternativa3d::gfx.drawTriangles(local24,local26,local25,"none");
          } else {
            local35.alternativa3d::gfx.beginFill(((local36 > 255 ? 255 : local36) << 16) + ((local37 > 255 ? 255 : local37) << 8) + (local38 > 255 ? 255 : local38));
            local35.alternativa3d::gfx.drawTriangles(local24,local26,null,"none");
          }
        }
      } else {
        local53 = 1e+22;
        local54 = -1;
        local5 = param3;
        while(local5 != null) {
          local8 = local5.alternativa3d::wrapper;
          while(local8 != null) {
            local52 = Number(local8.alternativa3d::vertex.alternativa3d::cameraZ);
            if(local52 < local53) {
              local53 = local52;
            }
            if(local52 > local54) {
              local54 = local52;
            }
            local8 = local8.alternativa3d::next;
          }
          local5 = local5.alternativa3d::processNext;
        }
        local14 = param1.alternativa3d::focalLength * resolution;
        local55 = local53 >= local14 ? int(1 + Math.log(local53 / local14) * 1.4426950408889634) : 0;
        if(local55 >= alternativa3d::numMaps) {
          local55 = alternativa3d::numMaps - 1;
        }
        local56 = local54 >= local14 ? int(1 + Math.log(local54 / local14) * 1.4426950408889634) : 0;
        if(local56 >= alternativa3d::numMaps) {
          local56 = alternativa3d::numMaps - 1;
        }
        local52 = local14 * Math.pow(2,local56 - 1);
        local15 = local56;
        while(local15 >= local55) {
          local31++;
          local27 = 0;
          local28 = 0;
          local29 = 0;
          local30 = 0;
          local58 = local52 - threshold;
          local59 = local52 + threshold;
          local5 = param3;
          param3 = null;
          local7 = null;
          while(local5 != null) {
            local6 = local5.alternativa3d::processNext;
            local5.alternativa3d::processNext = null;
            local8 = null;
            if(local15 == local55) {
              local8 = local5.alternativa3d::wrapper;
            } else {
              local60 = local5.alternativa3d::wrapper;
              local61 = Number(local60.alternativa3d::vertex.alternativa3d::cameraZ);
              local60 = local60.alternativa3d::next;
              local62 = Number(local60.alternativa3d::vertex.alternativa3d::cameraZ);
              local60 = local60.alternativa3d::next;
              local63 = Number(local60.alternativa3d::vertex.alternativa3d::cameraZ);
              local60 = local60.alternativa3d::next;
              local64 = local61 < local58 || local62 < local58 || local63 < local58;
              local65 = local61 > local59 || local62 > local59 || local63 > local59;
              while(local60 != null) {
                local66 = Number(local60.alternativa3d::vertex.alternativa3d::cameraZ);
                if(local66 < local58) {
                  local64 = true;
                } else if(local66 > local59) {
                  local65 = true;
                }
                local60 = local60.alternativa3d::next;
              }
              if(!local64) {
                local8 = local5.alternativa3d::wrapper;
              } else if(!local65) {
                if(param3 != null) {
                  local7.alternativa3d::processNext = local5;
                } else {
                  param3 = local5;
                }
                local7 = local5;
              } else {
                local67 = local5.alternativa3d::create();
                param1.alternativa3d::lastFace.alternativa3d::next = local67;
                param1.alternativa3d::lastFace = local67;
                local68 = null;
                local69 = null;
                local60 = local5.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next;
                while(local60.alternativa3d::next != null) {
                  local60 = local60.alternativa3d::next;
                }
                local71 = local60.alternativa3d::vertex;
                local61 = Number(local71.alternativa3d::cameraZ);
                local60 = local5.alternativa3d::wrapper;
                while(local60 != null) {
                  local72 = local60.alternativa3d::vertex;
                  local62 = Number(local72.alternativa3d::cameraZ);
                  if(local61 < local58 && local62 > local59 || local61 > local59 && local62 < local58) {
                    local13 = (local52 - local61) / (local62 - local61);
                    local73 = local72.alternativa3d::create();
                    param1.alternativa3d::lastVertex.alternativa3d::next = local73;
                    param1.alternativa3d::lastVertex = local73;
                    local73.alternativa3d::cameraX = local71.alternativa3d::cameraX + (local72.alternativa3d::cameraX - local71.alternativa3d::cameraX) * local13;
                    local73.alternativa3d::cameraY = local71.alternativa3d::cameraY + (local72.alternativa3d::cameraY - local71.alternativa3d::cameraY) * local13;
                    local73.alternativa3d::cameraZ = local52;
                    local73.u = local71.u + (local72.u - local71.u) * local13;
                    local73.v = local71.v + (local72.v - local71.v) * local13;
                    local70 = local60.alternativa3d::create();
                    local70.alternativa3d::vertex = local73;
                    if(local68 != null) {
                      local68.alternativa3d::next = local70;
                    } else {
                      local67.alternativa3d::wrapper = local70;
                    }
                    local68 = local70;
                    local70 = local60.alternativa3d::create();
                    local70.alternativa3d::vertex = local73;
                    if(local69 != null) {
                      local69.alternativa3d::next = local70;
                    } else {
                      local8 = local70;
                    }
                    local69 = local70;
                  }
                  if(local62 <= local59) {
                    local70 = local60.alternativa3d::create();
                    local70.alternativa3d::vertex = local72;
                    if(local68 != null) {
                      local68.alternativa3d::next = local70;
                    } else {
                      local67.alternativa3d::wrapper = local70;
                    }
                    local68 = local70;
                  }
                  if(local62 >= local58) {
                    local70 = local60.alternativa3d::create();
                    local70.alternativa3d::vertex = local72;
                    if(local69 != null) {
                      local69.alternativa3d::next = local70;
                    } else {
                      local8 = local70;
                    }
                    local69 = local70;
                  }
                  local71 = local72;
                  local61 = local62;
                  local60 = local60.alternativa3d::next;
                }
                if(param3 != null) {
                  local7.alternativa3d::processNext = local67;
                } else {
                  param3 = local67;
                }
                local7 = local67;
                local57 = local8;
              }
            }
            if(local8 != null) {
              local9 = local8.alternativa3d::vertex;
              if(local9.alternativa3d::drawId != local31) {
                local13 = 1 / local9.alternativa3d::cameraZ;
                local24[local28] = local9.alternativa3d::cameraX * local22 * local13;
                local28++;
                local24[local28] = local9.alternativa3d::cameraY * local23 * local13;
                local28++;
                local25[local29] = local9.u;
                local29++;
                local25[local29] = local9.v;
                local29++;
                local25[local29] = local13;
                local29++;
                local10 = local27;
                local9.alternativa3d::index = local27++;
                local9.alternativa3d::drawId = local31;
              } else {
                local10 = int(local9.alternativa3d::index);
              }
              local8 = local8.alternativa3d::next;
              local9 = local8.alternativa3d::vertex;
              if(local9.alternativa3d::drawId != local31) {
                local13 = 1 / local9.alternativa3d::cameraZ;
                local24[local28] = local9.alternativa3d::cameraX * local22 * local13;
                local28++;
                local24[local28] = local9.alternativa3d::cameraY * local23 * local13;
                local28++;
                local25[local29] = local9.u;
                local29++;
                local25[local29] = local9.v;
                local29++;
                local25[local29] = local13;
                local29++;
                local11 = local27;
                local9.alternativa3d::index = local27++;
                local9.alternativa3d::drawId = local31;
              } else {
                local11 = int(local9.alternativa3d::index);
              }
              local8 = local8.alternativa3d::next;
              while(local8 != null) {
                local9 = local8.alternativa3d::vertex;
                if(local9.alternativa3d::drawId != local31) {
                  local13 = 1 / local9.alternativa3d::cameraZ;
                  local24[local28] = local9.alternativa3d::cameraX * local22 * local13;
                  local28++;
                  local24[local28] = local9.alternativa3d::cameraY * local23 * local13;
                  local28++;
                  local25[local29] = local9.u;
                  local29++;
                  local25[local29] = local9.v;
                  local29++;
                  local25[local29] = local13;
                  local29++;
                  local12 = local27;
                  local9.alternativa3d::index = local27++;
                  local9.alternativa3d::drawId = local31;
                } else {
                  local12 = int(local9.alternativa3d::index);
                }
                alternativa3d::drawIndices[local30] = local10;
                local30++;
                alternativa3d::drawIndices[local30] = local11;
                local30++;
                alternativa3d::drawIndices[local30] = local12;
                local30++;
                local11 = local12;
                local33++;
                local8 = local8.alternativa3d::next;
              }
              local32++;
              if(local57 != null) {
                local8 = local57;
                while(local8 != null) {
                  local8.alternativa3d::vertex = null;
                  local8 = local8.alternativa3d::next;
                }
                param1.alternativa3d::lastWrapper.alternativa3d::next = local57;
                param1.alternativa3d::lastWrapper = local69;
                local57 = null;
              }
            }
            local5 = local6;
          }
          local52 *= 0.5;
          local24.length = local28;
          local25.length = local29;
          local26.length = local30;
          local21 = alternativa3d::mipMap[local15];
          if(correctUV) {
            local19 = -0.5 / (local21.width - 1);
            local20 = -0.5 / (local21.height - 1);
            local17 = 1 - local19 - local19;
            local18 = 1 - local20 - local20;
            local16 = 0;
            while(local16 < local29) {
              local25[local16] = local25[local16] * local17 + local19;
              local16++;
              local25[local16] = local25[local16] * local18 + local20;
              local16++;
              local16++;
            }
          }
          param2.alternativa3d::gfx.beginBitmapFill(local21,null,repeat,smooth);
          param2.alternativa3d::gfx.drawTriangles(local24,local26,local25,"none");
          if(local39 > 0) {
            local16 = 0;
            while(local16 < local39) {
              local35 = alternativa3d::layers[local16];
              local35.alternativa3d::gfx.beginBitmapFill(local40[local16],null,repeat,smooth);
              local35.alternativa3d::gfx.drawTriangles(local24,local26,local25,"none");
              local16++;
            }
          } else {
            local35 = alternativa3d::layers[0];
            if(this.alternativa3d::_normalMap.transparent) {
              local35.alternativa3d::gfx.beginBitmapFill(local40[0],null,repeat,smooth);
              local35.alternativa3d::gfx.drawTriangles(local24,local26,local25,"none");
            } else {
              local35.alternativa3d::gfx.beginFill(((local36 > 255 ? 255 : local36) << 16) + ((local37 > 255 ? 255 : local37) << 8) + (local38 > 255 ? 255 : local38));
              local35.alternativa3d::gfx.drawTriangles(local24,local26,null,"none");
            }
          }
          local15--;
        }
      }
      local10 = local39 < 1 ? 2 : local39 + 1;
      param1.alternativa3d::numDraws = local31;
      param1.alternativa3d::numPolygons += local32 * local10;
      param1.alternativa3d::numTriangles += local33 * local10;
    }

    override alternativa3d function drawViewAligned(param1:Camera3D, param2:Canvas, param3:Face, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number) : void {
      var local13:int = 0;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Face = null;
      var local17:Face = null;
      var local18:Wrapper = null;
      var local19:Vertex = null;
      var local20:int = 0;
      var local21:BitmapData = null;
      var local22:Light3D = null;
      var local23:Canvas = null;
      var local30:Number = NaN;
      var local31:DirectionalLight = null;
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
      var local42:int = 0;
      var local43:Number = NaN;
      var local44:int = 0;
      var local11:Number = Number(param1.alternativa3d::viewSizeX);
      var local12:Number = Number(param1.alternativa3d::viewSizeY);
      if(alternativa3d::_texture == null || this.alternativa3d::_normalMap == null) {
        alternativa3d::clearLinks(param3);
        return;
      }
      var local24:Number = 0;
      var local25:Number = 0;
      var local26:Number = 0;
      var local27:int = 0;
      local13 = 0;
      while(local13 < param1.alternativa3d::lightsLength) {
        local22 = param1.alternativa3d::lights[local13];
        if(local22.intensity > 0) {
          local30 = Number(this.alternativa3d::weights[local22]);
          if(local30 != local30) {
            local30 = this.defaultLightWeight;
          }
          if(local30 > 0) {
            local22.alternativa3d::calculateObjectMatrix(param2.alternativa3d::object);
            if(local22.alternativa3d::checkBoundsIntersection(param2.alternativa3d::object)) {
              if(local22 is AmbientLight) {
                local24 += (local22.color >> 16 & 0xFF) * local22.intensity * local30;
                local25 += (local22.color >> 8 & 0xFF) * local22.intensity * local30;
                local26 += (local22.color & 0xFF) * local22.intensity * local30;
              } else if(local22 is DirectionalLight) {
                local22.alternativa3d::localWeight = local30;
                alternativa3d::lights[local27] = local22;
                local27++;
              }
            }
          }
        }
        local13++;
      }
      var local28:Vector.<BitmapData> = this.alternativa3d::lightmapsMap[param2.alternativa3d::object];
      if(local28 == null) {
        local28 = new Vector.<BitmapData>();
        this.alternativa3d::lightmapsMap[param2.alternativa3d::object] = local28;
      }
      local13 = int(local28.length);
      while(local13 < local27) {
        local28[local13] = new BitmapData(this.alternativa3d::lightmapRect.width,this.alternativa3d::lightmapRect.height,this.alternativa3d::_normalMap.transparent);
        local13++;
      }
      alternativa3d::lightmapAmbient.redOffset = local24;
      alternativa3d::lightmapAmbient.greenOffset = local25;
      alternativa3d::lightmapAmbient.blueOffset = local26;
      var local29:Canvas = param2.alternativa3d::getChildCanvas(local27 <= 1,local27 > 1,param2.alternativa3d::object,1,"multiply",local27 == 1 && (local24 > 0 || local25 > 0 || local26 > 0) ? alternativa3d::lightmapAmbient : null);
      if(local27 <= 1) {
        alternativa3d::layers[0] = local29;
        if(this.alternativa3d::_normalMap.transparent) {
          alternativa3d::lightmapMatrix[0] = 0;
          alternativa3d::lightmapMatrix[1] = 0;
          alternativa3d::lightmapMatrix[2] = 0;
          alternativa3d::lightmapMatrix[4] = local24 > 255 ? 255 : local24;
          alternativa3d::lightmapMatrix[5] = 0;
          alternativa3d::lightmapMatrix[6] = 0;
          alternativa3d::lightmapMatrix[7] = 0;
          alternativa3d::lightmapMatrix[9] = local25 > 255 ? 255 : local25;
          alternativa3d::lightmapMatrix[10] = 0;
          alternativa3d::lightmapMatrix[11] = 0;
          alternativa3d::lightmapMatrix[12] = 0;
          alternativa3d::lightmapMatrix[14] = local26 > 255 ? 255 : local26;
          if(local28.length == 0) {
            local28[0] = new BitmapData(this.alternativa3d::lightmapRect.width,this.alternativa3d::lightmapRect.height,this.alternativa3d::_normalMap.transparent);
          }
          alternativa3d::lightmapFilter.matrix = alternativa3d::lightmapMatrix;
          (local28[0] as BitmapData).applyFilter(this.alternativa3d::_normalMap,this.alternativa3d::lightmapRect,this.alternativa3d::lightmapPoint,alternativa3d::lightmapFilter);
        }
      }
      local13 = 0;
      while(local13 < local27) {
        local31 = alternativa3d::lights[local13] as DirectionalLight;
        local32 = (local31.color >> 16 & 0xFF) * local31.intensity * local31.alternativa3d::localWeight / 255;
        local33 = (local31.color >> 8 & 0xFF) * local31.intensity * local31.alternativa3d::localWeight / 255;
        local34 = (local31.color & 0xFF) * local31.intensity * local31.alternativa3d::localWeight / 255;
        local35 = param2.alternativa3d::object is Sprite3D ? (param2.alternativa3d::object as Sprite3D).rotation : 0;
        local36 = Math.sin(local35);
        local37 = Math.cos(local35);
        local38 = local31.alternativa3d::cmc * local37 + local31.alternativa3d::cmg * local36;
        local39 = -local31.alternativa3d::cmc * local36 + local31.alternativa3d::cmg * local37;
        local40 = Number(local31.alternativa3d::cmk);
        local41 = Math.sqrt(local38 * local38 + local39 * local39 + local40 * local40);
        local38 /= local41;
        local39 /= local41;
        local40 /= local41;
        alternativa3d::lightmapMatrix[0] = -local38 * 2 * local32;
        alternativa3d::lightmapMatrix[1] = -local39 * 2 * local32;
        alternativa3d::lightmapMatrix[2] = -local40 * 2 * local32;
        alternativa3d::lightmapMatrix[4] = (local38 + local39 + local40) * local32 * 255;
        alternativa3d::lightmapMatrix[5] = -local38 * 2 * local33;
        alternativa3d::lightmapMatrix[6] = -local39 * 2 * local33;
        alternativa3d::lightmapMatrix[7] = -local40 * 2 * local33;
        alternativa3d::lightmapMatrix[9] = (local38 + local39 + local40) * local33 * 255;
        alternativa3d::lightmapMatrix[10] = -local38 * 2 * local34;
        alternativa3d::lightmapMatrix[11] = -local39 * 2 * local34;
        alternativa3d::lightmapMatrix[12] = -local40 * 2 * local34;
        alternativa3d::lightmapMatrix[14] = (local38 + local39 + local40) * local34 * 255;
        if(local27 > 1) {
          alternativa3d::layers[local13] = local29.alternativa3d::getChildCanvas(true,false,param2.alternativa3d::object,1,local13 == local27 - 1 ? "normal" : "add",local13 == local27 - 1 && (local24 > 0 || local25 > 0 || local26 > 0) ? alternativa3d::lightmapAmbient : null);
        }
        alternativa3d::lightmapFilter.matrix = alternativa3d::lightmapMatrix;
        (local28[local13] as BitmapData).applyFilter(this.alternativa3d::_normalMap,this.alternativa3d::lightmapRect,this.alternativa3d::lightmapPoint,alternativa3d::lightmapFilter);
        local13++;
      }
      if(!this.multipliedDiffuse) {
        param2 = param2.alternativa3d::getChildCanvas(true,false,param2.alternativa3d::object,1,"normal",alternativa3d::multiplier);
      }
      if(local27 > 0) {
        local14 = this.alternativa3d::_normalMap.width;
        local15 = this.alternativa3d::_normalMap.height;
        alternativa3d::drawMatrix.a = param5 / local14;
        alternativa3d::drawMatrix.b = param6 / local14;
        alternativa3d::drawMatrix.c = param7 / local15;
        alternativa3d::drawMatrix.d = param8 / local15;
        alternativa3d::drawMatrix.tx = param9;
        alternativa3d::drawMatrix.ty = param10;
        local42 = 0;
        while(local42 < local27) {
          local23 = alternativa3d::layers[local42];
          local23.alternativa3d::gfx.beginBitmapFill(local28[local42],alternativa3d::drawMatrix,repeat,smooth);
          local16 = param3;
          while(local16 != null) {
            local18 = local16.alternativa3d::wrapper;
            local19 = local18.alternativa3d::vertex;
            local23.alternativa3d::gfx.moveTo(local19.alternativa3d::cameraX * local11 / param4,local19.alternativa3d::cameraY * local12 / param4);
            local20 = -1;
            local18 = local18.alternativa3d::next;
            while(local18 != null) {
              local19 = local18.alternativa3d::vertex;
              local23.alternativa3d::gfx.lineTo(local19.alternativa3d::cameraX * local11 / param4,local19.alternativa3d::cameraY * local12 / param4);
              local20++;
              local18 = local18.alternativa3d::next;
            }
            param1.alternativa3d::numTriangles += local20;
            ++param1.alternativa3d::numPolygons;
            local16 = local16.alternativa3d::processNext;
          }
          ++param1.alternativa3d::numDraws;
          local42++;
        }
      } else if(this.alternativa3d::_normalMap.transparent) {
        local14 = this.alternativa3d::_normalMap.width;
        local15 = this.alternativa3d::_normalMap.height;
        alternativa3d::drawMatrix.a = param5 / local14;
        alternativa3d::drawMatrix.b = param6 / local14;
        alternativa3d::drawMatrix.c = param7 / local15;
        alternativa3d::drawMatrix.d = param8 / local15;
        alternativa3d::drawMatrix.tx = param9;
        alternativa3d::drawMatrix.ty = param10;
        local23 = alternativa3d::layers[0];
        local23.alternativa3d::gfx.beginBitmapFill(local28[0],alternativa3d::drawMatrix,repeat,smooth);
        local16 = param3;
        while(local16 != null) {
          local18 = local16.alternativa3d::wrapper;
          local19 = local18.alternativa3d::vertex;
          local23.alternativa3d::gfx.moveTo(local19.alternativa3d::cameraX * local11 / param4,local19.alternativa3d::cameraY * local12 / param4);
          local20 = -1;
          local18 = local18.alternativa3d::next;
          while(local18 != null) {
            local19 = local18.alternativa3d::vertex;
            local23.alternativa3d::gfx.lineTo(local19.alternativa3d::cameraX * local11 / param4,local19.alternativa3d::cameraY * local12 / param4);
            local20++;
            local18 = local18.alternativa3d::next;
          }
          param1.alternativa3d::numTriangles += local20;
          ++param1.alternativa3d::numPolygons;
          local16 = local16.alternativa3d::processNext;
        }
        ++param1.alternativa3d::numDraws;
      } else {
        local23 = alternativa3d::layers[0];
        local23.alternativa3d::gfx.beginFill(((local24 > 255 ? 255 : local24) << 16) + ((local25 > 255 ? 255 : local25) << 8) + (local26 > 255 ? 255 : local26));
        local16 = param3;
        while(local16 != null) {
          local18 = local16.alternativa3d::wrapper;
          local19 = local18.alternativa3d::vertex;
          local23.alternativa3d::gfx.moveTo(local19.alternativa3d::cameraX * local11 / param4,local19.alternativa3d::cameraY * local12 / param4);
          local20 = -1;
          local18 = local18.alternativa3d::next;
          while(local18 != null) {
            local19 = local18.alternativa3d::vertex;
            local23.alternativa3d::gfx.lineTo(local19.alternativa3d::cameraX * local11 / param4,local19.alternativa3d::cameraY * local12 / param4);
            local20++;
            local18 = local18.alternativa3d::next;
          }
          param1.alternativa3d::numTriangles += local20;
          ++param1.alternativa3d::numPolygons;
          local16 = local16.alternativa3d::processNext;
        }
        ++param1.alternativa3d::numDraws;
      }
      if(alternativa3d::_mipMapping == 0) {
        local21 = alternativa3d::_texture;
      } else {
        local43 = param1.alternativa3d::focalLength * resolution;
        local44 = param4 >= local43 ? int(1 + Math.log(param4 / local43) * 1.4426950408889634) : 0;
        if(local44 >= alternativa3d::numMaps) {
          local44 = alternativa3d::numMaps - 1;
        }
        local21 = alternativa3d::mipMap[local44];
      }
      local14 = local21.width;
      local15 = local21.height;
      alternativa3d::drawMatrix.a = param5 / local14;
      alternativa3d::drawMatrix.b = param6 / local14;
      alternativa3d::drawMatrix.c = param7 / local15;
      alternativa3d::drawMatrix.d = param8 / local15;
      alternativa3d::drawMatrix.tx = param9;
      alternativa3d::drawMatrix.ty = param10;
      param2.alternativa3d::gfx.beginBitmapFill(local21,alternativa3d::drawMatrix,repeat,smooth);
      local16 = param3;
      while(local16 != null) {
        local17 = local16.alternativa3d::processNext;
        local16.alternativa3d::processNext = null;
        local18 = local16.alternativa3d::wrapper;
        local19 = local18.alternativa3d::vertex;
        param2.alternativa3d::gfx.moveTo(local19.alternativa3d::cameraX * local11 / param4,local19.alternativa3d::cameraY * local12 / param4);
        local20 = -1;
        local18 = local18.alternativa3d::next;
        while(local18 != null) {
          local19 = local18.alternativa3d::vertex;
          param2.alternativa3d::gfx.lineTo(local19.alternativa3d::cameraX * local11 / param4,local19.alternativa3d::cameraY * local12 / param4);
          local20++;
          local18 = local18.alternativa3d::next;
        }
        param1.alternativa3d::numTriangles += local20;
        ++param1.alternativa3d::numPolygons;
        local16 = local17;
      }
      ++param1.alternativa3d::numDraws;
    }
  }
}
