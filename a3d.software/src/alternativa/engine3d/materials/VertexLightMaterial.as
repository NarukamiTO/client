package alternativa.engine3d.materials {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.lights.AmbientLight;
  import alternativa.engine3d.lights.DirectionalLight;
  import alternativa.engine3d.lights.OmniLight;
  import alternativa.engine3d.lights.SpotLight;
  import flash.display.BitmapData;
  import flash.geom.ColorTransform;
  import flash.geom.Rectangle;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class VertexLightMaterial extends TextureMaterial {
    alternativa3d static var colorTransform:ColorTransform = new ColorTransform();

    alternativa3d static const lights:Vector.<Light3D> = new Vector.<Light3D>();
    alternativa3d static const layers:Vector.<Canvas> = new Vector.<Canvas>();
    alternativa3d static const gradientRect:Rectangle = new Rectangle(0,0,256,1);
    alternativa3d static const gradientColors:Vector.<uint> = new Vector.<uint>(256);
    alternativa3d static const multiplier:ColorTransform = new ColorTransform(2,2,2);

    alternativa3d var gradientMap:Dictionary = new Dictionary();
    alternativa3d var weights:Dictionary = new Dictionary();

    public var defaultLightWeight:Number = 1;
    public var multipliedDiffuse:Boolean = false;

    public function VertexLightMaterial(param1:BitmapData = null, param2:Boolean = false, param3:Boolean = true, param4:int = 0, param5:Number = 1) {
      super(param1,param2,param3,param4,param5);
      alternativa3d::useVerticesNormals = true;
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

    override public function clone() : Material {
      var local1:VertexLightMaterial = new VertexLightMaterial(alternativa3d::_texture,repeat,smooth,alternativa3d::_mipMapping,resolution);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Material) : void {
      super.clonePropertiesFrom(param1);
      var local2:VertexLightMaterial = param1 as VertexLightMaterial;
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
      var local42:Number = NaN;
      var local43:Number = NaN;
      var local44:Number = NaN;
      var local45:Number = NaN;
      var local46:int = 0;
      var local47:Number = NaN;
      var local48:Number = NaN;
      var local49:Number = NaN;
      var local50:int = 0;
      var local51:int = 0;
      var local52:Number = NaN;
      var local53:Number = NaN;
      var local54:Face = null;
      var local55:Face = null;
      var local56:Wrapper = null;
      var local57:Number = NaN;
      var local58:Number = NaN;
      var local59:Number = NaN;
      var local60:Boolean = false;
      var local61:Boolean = false;
      var local62:Number = NaN;
      var local63:Face = null;
      var local64:Face = null;
      var local65:Wrapper = null;
      var local66:Wrapper = null;
      var local67:Wrapper = null;
      var local68:Vertex = null;
      var local69:Vertex = null;
      var local70:Vertex = null;
      var local22:Number = Number(param1.alternativa3d::viewSizeX);
      var local23:Number = Number(param1.alternativa3d::viewSizeY);
      var local24:Vector.<Number> = alternativa3d::drawVertices;
      var local25:Vector.<Number> = alternativa3d::drawUVTs;
      var local26:Vector.<int> = alternativa3d::drawIndices;
      var local31:int = int(param1.alternativa3d::numDraws);
      var local32:int = 0;
      var local33:int = 0;
      if(alternativa3d::_texture == null) {
        alternativa3d::clearLinks(param3);
        return;
      }
      var local35:Number = 0;
      var local36:Number = 0;
      var local37:Number = 0;
      var local38:int = 0;
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
                local35 += (local34.color >> 16 & 0xFF) * local34.intensity * local42;
                local36 += (local34.color >> 8 & 0xFF) * local34.intensity * local42;
                local37 += (local34.color & 0xFF) * local34.intensity * local42;
              } else {
                local34.alternativa3d::localWeight = local42;
                alternativa3d::lights[local38] = local34;
                local38++;
              }
            }
          }
        }
        local15++;
      }
      var local39:Vector.<BitmapData> = this.alternativa3d::gradientMap[param2.alternativa3d::object];
      if(local39 == null) {
        local39 = new Vector.<BitmapData>();
        this.alternativa3d::gradientMap[param2.alternativa3d::object] = local39;
      }
      local15 = int(local39.length);
      while(local15 < local38) {
        local39[local15] = new BitmapData(256,1,false);
        local15++;
      }
      var local40:Vector.<uint> = alternativa3d::gradientColors;
      var local41:Canvas = param2.alternativa3d::getChildCanvas(local38 <= 1,local38 > 1,param2.alternativa3d::object,1,"multiply");
      if(local38 <= 1) {
        alternativa3d::layers[0] = local41;
      }
      local15 = 0;
      while(local15 < local38) {
        local34 = alternativa3d::lights[local15];
        local43 = (local34.color >> 16 & 0xFF) * local34.intensity * local34.alternativa3d::localWeight;
        local44 = (local34.color >> 8 & 0xFF) * local34.intensity * local34.alternativa3d::localWeight;
        local45 = (local34.color & 0xFF) * local34.intensity * local34.alternativa3d::localWeight;
        if(local15 == 0 && (local35 > 0 || local36 > 0 || local37 > 0)) {
          local16 = 0;
          while(local16 < 256) {
            local13 = local16 / 255;
            local10 = local43 * local13 + local35;
            local11 = local44 * local13 + local36;
            local12 = local45 * local13 + local37;
            local40[local16] = ((local10 > 255 ? 255 : local10) << 16) + ((local11 > 255 ? 255 : local11) << 8) + (local12 > 255 ? 255 : local12);
            local16++;
          }
        } else {
          local16 = 0;
          while(local16 < 256) {
            local13 = local16 / 255;
            local10 = local43 * local13;
            local11 = local44 * local13;
            local12 = local45 * local13;
            local40[local16] = ((local10 > 255 ? 255 : local10) << 16) + ((local11 > 255 ? 255 : local11) << 8) + (local12 > 255 ? 255 : local12);
            local16++;
          }
        }
        if(local38 > 1) {
          alternativa3d::layers[local15] = local41.alternativa3d::getChildCanvas(true,false,param2.alternativa3d::object,1,local15 == local38 - 1 ? "normal" : "add");
        }
        (local39[local15] as BitmapData).setVector(alternativa3d::gradientRect,local40);
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
          local5 = local5.alternativa3d::processNext;
        }
        local24.length = local28;
        local25.length = local29;
        local26.length = local30;
        if(alternativa3d::_mipMapping == 0) {
          local21 = alternativa3d::_texture;
        } else {
          local14 = param1.alternativa3d::focalLength * resolution;
          local46 = param4 >= local14 ? int(1 + Math.log(param4 / local14) * 1.4426950408889634) : 0;
          if(local46 >= alternativa3d::numMaps) {
            local46 = alternativa3d::numMaps - 1;
          }
          local21 = alternativa3d::mipMap[local46];
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
        if(local38 > 0) {
          local16 = 0;
          while(local16 < local38) {
            this.alternativa3d::drawLight(param3,local16 == local38 - 1,++local31,local24,local26,local25,alternativa3d::layers[local16],alternativa3d::lights[local16],local39[local16],0);
            local16++;
          }
        } else {
          this.alternativa3d::drawLight(param3,true,++local31,local24,local26,local25,alternativa3d::layers[0],null,null,((local35 > 255 ? 255 : local35) << 16) + ((local36 > 255 ? 255 : local36) << 8) + (local37 > 255 ? 255 : local37));
        }
      } else {
        local48 = 1e+22;
        local49 = -1;
        local5 = param3;
        while(local5 != null) {
          local8 = local5.alternativa3d::wrapper;
          while(local8 != null) {
            local47 = Number(local8.alternativa3d::vertex.alternativa3d::cameraZ);
            if(local47 < local48) {
              local48 = local47;
            }
            if(local47 > local49) {
              local49 = local47;
            }
            local8 = local8.alternativa3d::next;
          }
          local5 = local5.alternativa3d::processNext;
        }
        local14 = param1.alternativa3d::focalLength * resolution;
        local50 = local48 >= local14 ? int(1 + Math.log(local48 / local14) * 1.4426950408889634) : 0;
        if(local50 >= alternativa3d::numMaps) {
          local50 = alternativa3d::numMaps - 1;
        }
        local51 = local49 >= local14 ? int(1 + Math.log(local49 / local14) * 1.4426950408889634) : 0;
        if(local51 >= alternativa3d::numMaps) {
          local51 = alternativa3d::numMaps - 1;
        }
        local47 = local14 * Math.pow(2,local51 - 1);
        local15 = local51;
        while(local15 >= local50) {
          local31++;
          local27 = 0;
          local28 = 0;
          local29 = 0;
          local30 = 0;
          local52 = local47 - threshold;
          local53 = local47 + threshold;
          local54 = local15 == local50 ? param3 : null;
          local55 = null;
          local5 = param3;
          param3 = null;
          local7 = null;
          while(local5 != null) {
            local6 = local5.alternativa3d::processNext;
            local8 = null;
            if(local15 == local50) {
              local8 = local5.alternativa3d::wrapper;
            } else {
              local56 = local5.alternativa3d::wrapper;
              local57 = Number(local56.alternativa3d::vertex.alternativa3d::cameraZ);
              local56 = local56.alternativa3d::next;
              local58 = Number(local56.alternativa3d::vertex.alternativa3d::cameraZ);
              local56 = local56.alternativa3d::next;
              local59 = Number(local56.alternativa3d::vertex.alternativa3d::cameraZ);
              local56 = local56.alternativa3d::next;
              local60 = local57 < local52 || local58 < local52 || local59 < local52;
              local61 = local57 > local53 || local58 > local53 || local59 > local53;
              while(local56 != null) {
                local62 = Number(local56.alternativa3d::vertex.alternativa3d::cameraZ);
                if(local62 < local52) {
                  local60 = true;
                } else if(local62 > local53) {
                  local61 = true;
                }
                local56 = local56.alternativa3d::next;
              }
              if(!local60) {
                if(local54 != null) {
                  local55.alternativa3d::processNext = local5;
                } else {
                  local54 = local5;
                }
                local55 = local5;
                local8 = local5.alternativa3d::wrapper;
              } else if(!local61) {
                if(param3 != null) {
                  local7.alternativa3d::processNext = local5;
                } else {
                  param3 = local5;
                }
                local7 = local5;
              } else {
                local63 = local5.alternativa3d::create();
                param1.alternativa3d::lastFace.alternativa3d::next = local63;
                param1.alternativa3d::lastFace = local63;
                local64 = local5.alternativa3d::create();
                param1.alternativa3d::lastFace.alternativa3d::next = local64;
                param1.alternativa3d::lastFace = local64;
                local65 = null;
                local66 = null;
                local56 = local5.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next;
                while(local56.alternativa3d::next != null) {
                  local56 = local56.alternativa3d::next;
                }
                local68 = local56.alternativa3d::vertex;
                local57 = Number(local68.alternativa3d::cameraZ);
                local56 = local5.alternativa3d::wrapper;
                while(local56 != null) {
                  local69 = local56.alternativa3d::vertex;
                  local58 = Number(local69.alternativa3d::cameraZ);
                  if(local57 < local52 && local58 > local53 || local57 > local53 && local58 < local52) {
                    local13 = (local47 - local57) / (local58 - local57);
                    local70 = local69.alternativa3d::create();
                    param1.alternativa3d::lastVertex.alternativa3d::next = local70;
                    param1.alternativa3d::lastVertex = local70;
                    local70.alternativa3d::cameraX = local68.alternativa3d::cameraX + (local69.alternativa3d::cameraX - local68.alternativa3d::cameraX) * local13;
                    local70.alternativa3d::cameraY = local68.alternativa3d::cameraY + (local69.alternativa3d::cameraY - local68.alternativa3d::cameraY) * local13;
                    local70.alternativa3d::cameraZ = local47;
                    local70.u = local68.u + (local69.u - local68.u) * local13;
                    local70.v = local68.v + (local69.v - local68.v) * local13;
                    local70.x = local68.x + (local69.x - local68.x) * local13;
                    local70.y = local68.y + (local69.y - local68.y) * local13;
                    local70.z = local68.z + (local69.z - local68.z) * local13;
                    local70.normalX = local68.normalX + (local69.normalX - local68.normalX) * local13;
                    local70.normalY = local68.normalY + (local69.normalY - local68.normalY) * local13;
                    local70.normalZ = local68.normalZ + (local69.normalZ - local68.normalZ) * local13;
                    local67 = local56.alternativa3d::create();
                    local67.alternativa3d::vertex = local70;
                    if(local65 != null) {
                      local65.alternativa3d::next = local67;
                    } else {
                      local63.alternativa3d::wrapper = local67;
                    }
                    local65 = local67;
                    local67 = local56.alternativa3d::create();
                    local67.alternativa3d::vertex = local70;
                    if(local66 != null) {
                      local66.alternativa3d::next = local67;
                    } else {
                      local64.alternativa3d::wrapper = local67;
                      local8 = local67;
                    }
                    local66 = local67;
                  }
                  if(local58 <= local53) {
                    local67 = local56.alternativa3d::create();
                    local67.alternativa3d::vertex = local69;
                    if(local65 != null) {
                      local65.alternativa3d::next = local67;
                    } else {
                      local63.alternativa3d::wrapper = local67;
                    }
                    local65 = local67;
                  }
                  if(local58 >= local52) {
                    local67 = local56.alternativa3d::create();
                    local67.alternativa3d::vertex = local69;
                    if(local66 != null) {
                      local66.alternativa3d::next = local67;
                    } else {
                      local64.alternativa3d::wrapper = local67;
                      local8 = local67;
                    }
                    local66 = local67;
                  }
                  local68 = local69;
                  local57 = local58;
                  local56 = local56.alternativa3d::next;
                }
                if(param3 != null) {
                  local7.alternativa3d::processNext = local63;
                } else {
                  param3 = local63;
                }
                local7 = local63;
                if(local54 != null) {
                  local55.alternativa3d::processNext = local64;
                } else {
                  local54 = local64;
                }
                local55 = local64;
                local5.alternativa3d::processNext = null;
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
            }
            local5 = local6;
          }
          if(local7 != null) {
            local7.alternativa3d::processNext = null;
          }
          if(local55 != null) {
            local55.alternativa3d::processNext = null;
          }
          local47 *= 0.5;
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
          if(local38 > 0) {
            local16 = 0;
            while(local16 < local38) {
              this.alternativa3d::drawLight(local54,local16 == local38 - 1,++local31,local24,local26,local25,alternativa3d::layers[local16],alternativa3d::lights[local16],local39[local16],0);
              local16++;
            }
          } else {
            this.alternativa3d::drawLight(local54,true,++local31,local24,local26,local25,alternativa3d::layers[0],null,null,((local35 > 255 ? 255 : local35) << 16) + ((local36 > 255 ? 255 : local36) << 8) + (local37 > 255 ? 255 : local37));
          }
          local15--;
        }
      }
      local10 = local38 < 1 ? 2 : local38 + 1;
      param1.alternativa3d::numDraws = local31;
      param1.alternativa3d::numPolygons += local32 * local10;
      param1.alternativa3d::numTriangles += local33 * local10;
    }

    alternativa3d function drawLight(param1:Face, param2:Boolean, param3:int, param4:Vector.<Number>, param5:Vector.<int>, param6:Vector.<Number>, param7:Canvas, param8:Light3D, param9:BitmapData, param10:int) : void {
      var local11:Face = null;
      var local12:Face = null;
      var local13:Wrapper = null;
      var local14:Vertex = null;
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
      var local26:DirectionalLight = null;
      var local27:OmniLight = null;
      var local28:SpotLight = null;
      var local29:Number = NaN;
      var local30:Number = NaN;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Number = NaN;
      var local34:Number = NaN;
      var local35:Number = NaN;
      var local25:int = 0;
      if(param8 is DirectionalLight) {
        local26 = param8 as DirectionalLight;
        local15 = Number(local26.alternativa3d::omc);
        local16 = Number(local26.alternativa3d::omg);
        local17 = Number(local26.alternativa3d::omk);
        local18 = Math.sqrt(local15 * local15 + local16 * local16 + local17 * local17);
        local15 /= local18;
        local16 /= local18;
        local17 /= local18;
        local11 = param1;
        while(local11 != null) {
          local12 = local11.alternativa3d::processNext;
          if(param2) {
            local11.alternativa3d::processNext = null;
          }
          local13 = local11.alternativa3d::wrapper;
          while(local13 != null) {
            local14 = local13.alternativa3d::vertex;
            if(local14.alternativa3d::drawId != param3) {
              param6[local25] = -local14.normalX * local15 - local14.normalY * local16 - local14.normalZ * local17;
              local25 += 3;
              local14.alternativa3d::drawId = param3;
            }
            local13 = local13.alternativa3d::next;
          }
          local11 = local12;
        }
        param7.alternativa3d::gfx.beginBitmapFill(param9,null,false,smooth);
        param7.alternativa3d::gfx.drawTriangles(param4,param5,param6,"none");
      } else if(param8 is OmniLight) {
        local27 = param8 as OmniLight;
        local19 = Math.sqrt(local27.alternativa3d::oma * local27.alternativa3d::oma + local27.alternativa3d::ome * local27.alternativa3d::ome + local27.alternativa3d::omi * local27.alternativa3d::omi);
        local19 += Math.sqrt(local27.alternativa3d::omb * local27.alternativa3d::omb + local27.alternativa3d::omf * local27.alternativa3d::omf + local27.alternativa3d::omj * local27.alternativa3d::omj);
        local19 += Math.sqrt(local27.alternativa3d::omc * local27.alternativa3d::omc + local27.alternativa3d::omg * local27.alternativa3d::omg + local27.alternativa3d::omk * local27.alternativa3d::omk);
        local19 /= 3;
        local20 = local27.attenuationBegin * local19;
        local21 = local27.attenuationEnd * local19;
        local22 = local21 * local21;
        local23 = local21 - local20;
        local11 = param1;
        while(local11 != null) {
          local12 = local11.alternativa3d::processNext;
          if(param2) {
            local11.alternativa3d::processNext = null;
          }
          local13 = local11.alternativa3d::wrapper;
          while(local13 != null) {
            local14 = local13.alternativa3d::vertex;
            if(local14.alternativa3d::drawId != param3) {
              local15 = local14.x - local27.alternativa3d::omd;
              local16 = local14.y - local27.alternativa3d::omh;
              local17 = local14.z - local27.alternativa3d::oml;
              local18 = local15 * local15 + local16 * local16 + local17 * local17;
              if(local18 < local22) {
                local18 = Math.sqrt(local18);
                local15 /= local18;
                local16 /= local18;
                local17 /= local18;
                local24 = -local14.normalX * local15 - local14.normalY * local16 - local14.normalZ * local17;
                if(local24 > 0) {
                  if(local18 > local20) {
                    param6[local25] = local24 * (1 - (local18 - local20) / local23);
                  } else {
                    param6[local25] = local24;
                  }
                } else {
                  param6[local25] = 0;
                }
              } else {
                param6[local25] = 0;
              }
              local25 += 3;
              local14.alternativa3d::drawId = param3;
            }
            local13 = local13.alternativa3d::next;
          }
          local11 = local12;
        }
        param7.alternativa3d::gfx.beginBitmapFill(param9,null,false,smooth);
        param7.alternativa3d::gfx.drawTriangles(param4,param5,param6,"none");
      } else if(param8 is SpotLight) {
        local28 = param8 as SpotLight;
        local19 = Math.sqrt(local28.alternativa3d::oma * local28.alternativa3d::oma + local28.alternativa3d::ome * local28.alternativa3d::ome + local28.alternativa3d::omi * local28.alternativa3d::omi);
        local19 += Math.sqrt(local28.alternativa3d::omb * local28.alternativa3d::omb + local28.alternativa3d::omf * local28.alternativa3d::omf + local28.alternativa3d::omj * local28.alternativa3d::omj);
        local19 += Math.sqrt(local28.alternativa3d::omc * local28.alternativa3d::omc + local28.alternativa3d::omg * local28.alternativa3d::omg + local28.alternativa3d::omk * local28.alternativa3d::omk);
        local19 /= 3;
        local20 = local28.attenuationBegin * local19;
        local21 = local28.attenuationEnd * local19;
        local22 = local21 * local21;
        local23 = local21 - local20;
        local29 = Number(local28.alternativa3d::omc);
        local30 = Number(local28.alternativa3d::omg);
        local31 = Number(local28.alternativa3d::omk);
        local18 = Math.sqrt(local29 * local29 + local30 * local30 + local31 * local31);
        local29 /= local18;
        local30 /= local18;
        local31 /= local18;
        local32 = Math.cos(local28.hotspot * 0.5);
        local33 = Math.cos(local28.falloff * 0.5);
        local34 = local32 - local33;
        local11 = param1;
        while(local11 != null) {
          local12 = local11.alternativa3d::processNext;
          if(param2) {
            local11.alternativa3d::processNext = null;
          }
          local13 = local11.alternativa3d::wrapper;
          while(local13 != null) {
            local14 = local13.alternativa3d::vertex;
            if(local14.alternativa3d::drawId != param3) {
              local15 = local14.x - local28.alternativa3d::omd;
              local16 = local14.y - local28.alternativa3d::omh;
              local17 = local14.z - local28.alternativa3d::oml;
              local18 = local15 * local15 + local16 * local16 + local17 * local17;
              if(local18 < local22) {
                local18 = Math.sqrt(local18);
                local15 /= local18;
                local16 /= local18;
                local17 /= local18;
                local24 = -local14.normalX * local15 - local14.normalY * local16 - local14.normalZ * local17;
                if(local24 > 0) {
                  local35 = local29 * local15 + local30 * local16 + local31 * local17;
                  if(local35 > local33) {
                    if(local35 < local32) {
                      if(local18 > local20) {
                        param6[local25] = local24 * (1 - (local18 - local20) / local23) * (local35 - local33) / local34;
                      } else {
                        param6[local25] = local24 * (local35 - local33) / local34;
                      }
                    } else if(local18 > local20) {
                      param6[local25] = local24 * (1 - (local18 - local20) / local23);
                    } else {
                      param6[local25] = local24;
                    }
                  } else {
                    param6[local25] = 0;
                  }
                } else {
                  param6[local25] = 0;
                }
              } else {
                param6[local25] = 0;
              }
              local25 += 3;
              local14.alternativa3d::drawId = param3;
            }
            local13 = local13.alternativa3d::next;
          }
          local11 = local12;
        }
        param7.alternativa3d::gfx.beginBitmapFill(param9,null,false,smooth);
        param7.alternativa3d::gfx.drawTriangles(param4,param5,param6,"none");
      } else {
        local11 = param1;
        while(local11 != null) {
          local12 = local11.alternativa3d::processNext;
          if(param2) {
            local11.alternativa3d::processNext = null;
          }
          local11 = local12;
        }
        param7.alternativa3d::gfx.beginFill(param10);
        param7.alternativa3d::gfx.drawTriangles(param4,param5,null,"none");
      }
    }

    override alternativa3d function drawViewAligned(param1:Camera3D, param2:Canvas, param3:Face, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number) : void {
      this.alternativa3d::calculateLight(param1,param2.alternativa3d::object);
      if(this.multipliedDiffuse) {
        alternativa3d::colorTransform.redMultiplier *= 0.5;
        alternativa3d::colorTransform.greenMultiplier *= 0.5;
        alternativa3d::colorTransform.blueMultiplier *= 0.5;
      }
      if(param2.alternativa3d::modifiedColorTransform) {
        super.alternativa3d::drawViewAligned(param1,param2.alternativa3d::getChildCanvas(true,false,param2.alternativa3d::object,1,"normal",alternativa3d::colorTransform),param3,param4,param5,param6,param7,param8,param9,param10);
      } else {
        super.alternativa3d::drawViewAligned(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
        param2.transform.colorTransform = alternativa3d::colorTransform;
        param2.alternativa3d::modifiedColorTransform = true;
      }
    }

    alternativa3d function calculateLight(param1:Camera3D, param2:Object3D) : void {
      var local7:Light3D = null;
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
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:DirectionalLight = null;
      var local25:OmniLight = null;
      var local26:SpotLight = null;
      var local27:Number = NaN;
      var local28:Number = NaN;
      var local29:Number = NaN;
      var local30:Number = NaN;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Number = NaN;
      var local3:Number = 0;
      var local4:Number = 0;
      var local5:Number = 0;
      var local6:int = 0;
      while(local6 < param1.alternativa3d::lightsLength) {
        local7 = param1.alternativa3d::lights[local6];
        local8 = Number(this.alternativa3d::weights[local7]);
        if(local8 != local8) {
          local8 = this.defaultLightWeight;
        }
        if(local8 > 0) {
          local7.alternativa3d::calculateObjectMatrix(param2);
          if(local7.alternativa3d::checkBoundsIntersection(param2)) {
            local21 = (local7.color >> 16 & 0xFF) * local7.intensity * local8;
            local22 = (local7.color >> 8 & 0xFF) * local7.intensity * local8;
            local23 = (local7.color & 0xFF) * local7.intensity * local8;
            if(local7 is AmbientLight) {
              local3 += local21;
              local4 += local22;
              local5 += local23;
            } else if(local7 is DirectionalLight) {
              local24 = local7 as DirectionalLight;
              local9 = -param2.alternativa3d::imc;
              local10 = -param2.alternativa3d::img;
              local11 = -param2.alternativa3d::imk;
              local12 = Math.sqrt(local9 * local9 + local10 * local10 + local11 * local11);
              local9 /= local12;
              local10 /= local12;
              local11 /= local12;
              local13 = Number(local24.alternativa3d::omc);
              local14 = Number(local24.alternativa3d::omg);
              local15 = Number(local24.alternativa3d::omk);
              local16 = Math.sqrt(local13 * local13 + local14 * local14 + local15 * local15);
              local13 /= local16;
              local14 /= local16;
              local15 /= local16;
              local17 = -local9 * local13 - local10 * local14 - local11 * local15;
              if(local17 < 0) {
                local17 = 0;
              }
              local3 += local21 * local17;
              local4 += local22 * local17;
              local5 += local23 * local17;
            } else if(local7 is OmniLight) {
              local25 = local7 as OmniLight;
              local18 = Math.sqrt(local25.alternativa3d::oma * local25.alternativa3d::oma + local25.alternativa3d::ome * local25.alternativa3d::ome + local25.alternativa3d::omi * local25.alternativa3d::omi);
              local18 += Math.sqrt(local25.alternativa3d::omb * local25.alternativa3d::omb + local25.alternativa3d::omf * local25.alternativa3d::omf + local25.alternativa3d::omj * local25.alternativa3d::omj);
              local18 += Math.sqrt(local25.alternativa3d::omc * local25.alternativa3d::omc + local25.alternativa3d::omg * local25.alternativa3d::omg + local25.alternativa3d::omk * local25.alternativa3d::omk);
              local18 /= 3;
              local19 = local25.attenuationBegin * local18;
              local20 = local25.attenuationEnd * local18;
              local13 = -local25.alternativa3d::omd;
              local14 = -local25.alternativa3d::omh;
              local15 = -local25.alternativa3d::oml;
              local16 = local13 * local13 + local14 * local14 + local15 * local15;
              if(local16 < local20 * local20) {
                local9 = -param2.alternativa3d::imc;
                local10 = -param2.alternativa3d::img;
                local11 = -param2.alternativa3d::imk;
                local12 = Math.sqrt(local9 * local9 + local10 * local10 + local11 * local11);
                local9 /= local12;
                local10 /= local12;
                local11 /= local12;
                local16 = Math.sqrt(local16);
                local13 /= local16;
                local14 /= local16;
                local15 /= local16;
                local17 = -local9 * local13 - local10 * local14 - local11 * local15;
                if(local17 < 0) {
                  local17 = 0;
                }
                if(local16 > local19) {
                  local17 *= 1 - (local16 - local19) / (local20 - local19);
                }
                local3 += local21 * local17;
                local4 += local22 * local17;
                local5 += local23 * local17;
              }
            } else if(local7 is SpotLight) {
              local26 = local7 as SpotLight;
              local18 = Math.sqrt(local26.alternativa3d::oma * local26.alternativa3d::oma + local26.alternativa3d::ome * local26.alternativa3d::ome + local26.alternativa3d::omi * local26.alternativa3d::omi);
              local18 += Math.sqrt(local26.alternativa3d::omb * local26.alternativa3d::omb + local26.alternativa3d::omf * local26.alternativa3d::omf + local26.alternativa3d::omj * local26.alternativa3d::omj);
              local18 += Math.sqrt(local26.alternativa3d::omc * local26.alternativa3d::omc + local26.alternativa3d::omg * local26.alternativa3d::omg + local26.alternativa3d::omk * local26.alternativa3d::omk);
              local18 /= 3;
              local19 = local26.attenuationBegin * local18;
              local20 = local26.attenuationEnd * local18;
              local13 = -local26.alternativa3d::omd;
              local14 = -local26.alternativa3d::omh;
              local15 = -local26.alternativa3d::oml;
              local16 = local13 * local13 + local14 * local14 + local15 * local15;
              if(local16 < local20 * local20) {
                local16 = Math.sqrt(local16);
                local13 /= local16;
                local14 /= local16;
                local15 /= local16;
                local27 = Number(local26.alternativa3d::omc);
                local28 = Number(local26.alternativa3d::omg);
                local29 = Number(local26.alternativa3d::omk);
                local30 = Math.sqrt(local27 * local27 + local28 * local28 + local29 * local29);
                local27 /= local30;
                local28 /= local30;
                local29 /= local30;
                local31 = Math.cos(local26.hotspot * 0.5);
                local32 = Math.cos(local26.falloff * 0.5);
                local33 = local27 * local13 + local28 * local14 + local29 * local15;
                if(local33 > local32) {
                  local9 = -param2.alternativa3d::imc;
                  local10 = -param2.alternativa3d::img;
                  local11 = -param2.alternativa3d::imk;
                  local12 = Math.sqrt(local9 * local9 + local10 * local10 + local11 * local11);
                  local9 /= local12;
                  local10 /= local12;
                  local11 /= local12;
                  local17 = -local9 * local13 - local10 * local14 - local11 * local15;
                  if(local17 < 0) {
                    local17 = 0;
                  }
                  if(local16 > local19) {
                    local17 *= 1 - (local16 - local19) / (local20 - local19);
                  }
                  if(local33 < local31) {
                    local17 *= (local33 - local32) / (local31 - local32);
                  }
                  local3 += local21 * local17;
                  local4 += local22 * local17;
                  local5 += local23 * local17;
                }
              }
            }
          }
        }
        local6++;
      }
      alternativa3d::colorTransform.redMultiplier = local3 / 127.5;
      alternativa3d::colorTransform.greenMultiplier = local4 / 127.5;
      alternativa3d::colorTransform.blueMultiplier = local5 / 127.5;
    }
  }
}
