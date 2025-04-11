package alternativa.engine3d.materials {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import flash.display.BitmapData;
  import flash.geom.ColorTransform;

  use namespace alternativa3d;

  public class SphericalEnvironmentMaterial extends TextureMaterial {
    alternativa3d static var drawUVs:Vector.<Number> = new Vector.<Number>();

    public var alpha:Number = 1;
    public var blendMode:String = "normal";
    public var colorTransform:ColorTransform = null;
    public var environmentMap:BitmapData;

    public function SphericalEnvironmentMaterial(param1:BitmapData = null, param2:BitmapData = null, param3:Boolean = false, param4:Boolean = true, param5:int = 0, param6:Number = 1) {
      super(param1,param3,param4,param5,param6);
      this.environmentMap = param2;
      alternativa3d::useVerticesNormals = true;
    }

    override public function clone() : Material {
      var local1:SphericalEnvironmentMaterial = new SphericalEnvironmentMaterial(alternativa3d::_texture,this.environmentMap,repeat,smooth,alternativa3d::_mipMapping,resolution);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Material) : void {
      super.clonePropertiesFrom(param1);
      var local2:SphericalEnvironmentMaterial = param1 as SphericalEnvironmentMaterial;
      this.alpha = local2.alpha;
      this.blendMode = local2.blendMode;
      if(local2.colorTransform != null) {
        this.colorTransform = new ColorTransform();
        this.colorTransform.concat(local2.colorTransform);
      }
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
      var local27:Number = NaN;
      var local28:Number = NaN;
      var local29:Number = NaN;
      var local30:Number = NaN;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Number = NaN;
      var local38:int = 0;
      var local39:int = 0;
      var local40:int = 0;
      var local41:int = 0;
      var local42:int = 0;
      var local46:Canvas = null;
      var local47:int = 0;
      var local48:Number = NaN;
      var local49:Number = NaN;
      var local50:Number = NaN;
      var local51:int = 0;
      var local52:int = 0;
      var local53:Wrapper = null;
      var local54:Number = NaN;
      var local55:Number = NaN;
      var local56:Wrapper = null;
      var local57:Number = NaN;
      var local58:Number = NaN;
      var local59:Number = NaN;
      var local60:Boolean = false;
      var local61:Boolean = false;
      var local62:Number = NaN;
      var local63:Face = null;
      var local64:Wrapper = null;
      var local65:Wrapper = null;
      var local66:Wrapper = null;
      var local67:Vertex = null;
      var local68:Vertex = null;
      var local69:Vertex = null;
      var local22:Number = Number(param1.alternativa3d::viewSizeX);
      var local23:Number = Number(param1.alternativa3d::viewSizeY);
      var local24:Number = param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
      var local25:Number = param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
      var local26:Object3D = param2.alternativa3d::object;
      var local34:Vector.<Number> = alternativa3d::drawVertices;
      var local35:Vector.<Number> = alternativa3d::drawUVTs;
      var local36:Vector.<Number> = alternativa3d::drawUVs;
      var local37:Vector.<int> = alternativa3d::drawIndices;
      var local43:int = int(param1.alternativa3d::numDraws);
      var local44:int = 0;
      var local45:int = 0;
      if(this.environmentMap == null) {
        alternativa3d::clearLinks(param3);
        return;
      }
      if(this.alpha == 1 && this.blendMode == "normal" && this.colorTransform == null) {
        local46 = param2;
      } else {
        local46 = param2.alternativa3d::getChildCanvas(true,false,param2.alternativa3d::object,this.alpha,this.blendMode,this.colorTransform);
      }
      if(alternativa3d::_mipMapping < 2 || alternativa3d::_texture == null) {
        local43++;
        local38 = 0;
        local39 = 0;
        local40 = 0;
        local41 = 0;
        local42 = 0;
        local5 = param3;
        while(local5 != null) {
          local6 = local5.alternativa3d::processNext;
          local5.alternativa3d::processNext = null;
          local8 = local5.alternativa3d::wrapper;
          local9 = local8.alternativa3d::vertex;
          if(local9.alternativa3d::drawId != local43) {
            local13 = 1 / local9.alternativa3d::cameraZ;
            local34[local39] = local9.alternativa3d::cameraX * local22 * local13;
            local39++;
            local34[local39] = local9.alternativa3d::cameraY * local23 * local13;
            local39++;
            local35[local40] = local9.u;
            local40++;
            local35[local40] = local9.v;
            local40++;
            local35[local40] = local13;
            local40++;
            local10 = local38;
            local9.alternativa3d::index = local38++;
            local9.alternativa3d::drawId = local43;
            local28 = local9.alternativa3d::cameraX * local24;
            local29 = local9.alternativa3d::cameraY * local25;
            local30 = Number(local9.alternativa3d::cameraZ);
            local27 = 1 / Math.sqrt(local28 * local28 + local29 * local29 + local30 * local30);
            local28 *= local27;
            local29 *= local27;
            local30 *= local27;
            local31 = (local9.normalX * local26.alternativa3d::ima + local9.normalY * local26.alternativa3d::ime + local9.normalZ * local26.alternativa3d::imi) / local24;
            local32 = (local9.normalX * local26.alternativa3d::imb + local9.normalY * local26.alternativa3d::imf + local9.normalZ * local26.alternativa3d::imj) / local25;
            local33 = local9.normalX * local26.alternativa3d::imc + local9.normalY * local26.alternativa3d::img + local9.normalZ * local26.alternativa3d::imk;
            if(local33 > 0) {
              local33 = 0;
            }
            local27 = 1 / Math.sqrt(local31 * local31 + local32 * local32 + local33 * local33);
            local31 *= local27;
            local32 *= local27;
            local33 *= local27;
            local27 = local28 * local31 + local29 * local32 + local30 * local33;
            local27 += local27;
            local31 = local28 - local31 * local27;
            local32 = local29 - local32 * local27;
            local33 = local30 - local33 * local27 - 1;
            local27 = 1 / Math.sqrt(local31 * local31 + local32 * local32 + local33 * local33);
            local31 *= local27;
            local32 *= local27;
            local33 *= local27;
            local36[local41] = local31 * 0.5 + 0.5;
            local41++;
            local36[local41] = local32 * 0.5 + 0.5;
            local41++;
          } else {
            local10 = int(local9.alternativa3d::index);
          }
          local8 = local8.alternativa3d::next;
          local9 = local8.alternativa3d::vertex;
          if(local9.alternativa3d::drawId != local43) {
            local13 = 1 / local9.alternativa3d::cameraZ;
            local34[local39] = local9.alternativa3d::cameraX * local22 * local13;
            local39++;
            local34[local39] = local9.alternativa3d::cameraY * local23 * local13;
            local39++;
            local35[local40] = local9.u;
            local40++;
            local35[local40] = local9.v;
            local40++;
            local35[local40] = local13;
            local40++;
            local11 = local38;
            local9.alternativa3d::index = local38++;
            local9.alternativa3d::drawId = local43;
            local28 = local9.alternativa3d::cameraX * local24;
            local29 = local9.alternativa3d::cameraY * local25;
            local30 = Number(local9.alternativa3d::cameraZ);
            local27 = 1 / Math.sqrt(local28 * local28 + local29 * local29 + local30 * local30);
            local28 *= local27;
            local29 *= local27;
            local30 *= local27;
            local31 = (local9.normalX * local26.alternativa3d::ima + local9.normalY * local26.alternativa3d::ime + local9.normalZ * local26.alternativa3d::imi) / local24;
            local32 = (local9.normalX * local26.alternativa3d::imb + local9.normalY * local26.alternativa3d::imf + local9.normalZ * local26.alternativa3d::imj) / local25;
            local33 = local9.normalX * local26.alternativa3d::imc + local9.normalY * local26.alternativa3d::img + local9.normalZ * local26.alternativa3d::imk;
            if(local33 > 0) {
              local33 = 0;
            }
            local27 = 1 / Math.sqrt(local31 * local31 + local32 * local32 + local33 * local33);
            local31 *= local27;
            local32 *= local27;
            local33 *= local27;
            local27 = local28 * local31 + local29 * local32 + local30 * local33;
            local27 += local27;
            local31 = local28 - local31 * local27;
            local32 = local29 - local32 * local27;
            local33 = local30 - local33 * local27 - 1;
            local27 = 1 / Math.sqrt(local31 * local31 + local32 * local32 + local33 * local33);
            local31 *= local27;
            local32 *= local27;
            local33 *= local27;
            local36[local41] = local31 * 0.5 + 0.5;
            local41++;
            local36[local41] = local32 * 0.5 + 0.5;
            local41++;
          } else {
            local11 = int(local9.alternativa3d::index);
          }
          local8 = local8.alternativa3d::next;
          while(local8 != null) {
            local9 = local8.alternativa3d::vertex;
            if(local9.alternativa3d::drawId != local43) {
              local13 = 1 / local9.alternativa3d::cameraZ;
              local34[local39] = local9.alternativa3d::cameraX * local22 * local13;
              local39++;
              local34[local39] = local9.alternativa3d::cameraY * local23 * local13;
              local39++;
              local35[local40] = local9.u;
              local40++;
              local35[local40] = local9.v;
              local40++;
              local35[local40] = local13;
              local40++;
              local12 = local38;
              local9.alternativa3d::index = local38++;
              local9.alternativa3d::drawId = local43;
              local28 = local9.alternativa3d::cameraX * local24;
              local29 = local9.alternativa3d::cameraY * local25;
              local30 = Number(local9.alternativa3d::cameraZ);
              local27 = 1 / Math.sqrt(local28 * local28 + local29 * local29 + local30 * local30);
              local28 *= local27;
              local29 *= local27;
              local30 *= local27;
              local31 = (local9.normalX * local26.alternativa3d::ima + local9.normalY * local26.alternativa3d::ime + local9.normalZ * local26.alternativa3d::imi) / local24;
              local32 = (local9.normalX * local26.alternativa3d::imb + local9.normalY * local26.alternativa3d::imf + local9.normalZ * local26.alternativa3d::imj) / local25;
              local33 = local9.normalX * local26.alternativa3d::imc + local9.normalY * local26.alternativa3d::img + local9.normalZ * local26.alternativa3d::imk;
              if(local33 > 0) {
                local33 = 0;
              }
              local27 = 1 / Math.sqrt(local31 * local31 + local32 * local32 + local33 * local33);
              local31 *= local27;
              local32 *= local27;
              local33 *= local27;
              local27 = local28 * local31 + local29 * local32 + local30 * local33;
              local27 += local27;
              local31 = local28 - local31 * local27;
              local32 = local29 - local32 * local27;
              local33 = local30 - local33 * local27 - 1;
              local27 = 1 / Math.sqrt(local31 * local31 + local32 * local32 + local33 * local33);
              local31 *= local27;
              local32 *= local27;
              local33 *= local27;
              local36[local41] = local31 * 0.5 + 0.5;
              local41++;
              local36[local41] = local32 * 0.5 + 0.5;
              local41++;
            } else {
              local12 = int(local9.alternativa3d::index);
            }
            alternativa3d::drawIndices[local42] = local10;
            local42++;
            alternativa3d::drawIndices[local42] = local11;
            local42++;
            alternativa3d::drawIndices[local42] = local12;
            local42++;
            local11 = local12;
            local45++;
            local8 = local8.alternativa3d::next;
          }
          local44++;
          local5 = local6;
        }
        local34.length = local39;
        local35.length = local40;
        local36.length = local41;
        local37.length = local42;
        if(alternativa3d::_texture != null) {
          if(alternativa3d::_mipMapping == 0) {
            local21 = alternativa3d::_texture;
          } else {
            local14 = param1.alternativa3d::focalLength * resolution;
            local47 = param4 >= local14 ? int(1 + Math.log(param4 / local14) * 1.4426950408889634) : 0;
            if(local47 >= alternativa3d::numMaps) {
              local47 = alternativa3d::numMaps - 1;
            }
            local21 = alternativa3d::mipMap[local47];
          }
          if(correctUV) {
            local19 = -0.5 / (local21.width - 1);
            local20 = -0.5 / (local21.height - 1);
            local17 = 1 - local19 - local19;
            local18 = 1 - local20 - local20;
            local16 = 0;
            while(local16 < local40) {
              local35[local16] = local35[local16] * local17 + local19;
              local16++;
              local35[local16] = local35[local16] * local18 + local20;
              local16++;
              local16++;
            }
          }
          param2.alternativa3d::gfx.beginBitmapFill(local21,null,repeat,smooth);
          param2.alternativa3d::gfx.drawTriangles(local34,local37,local35,"none");
        }
        local46.alternativa3d::gfx.beginBitmapFill(this.environmentMap,null,false,smooth);
        local46.alternativa3d::gfx.drawTriangles(local34,local37,local36,"none");
      } else {
        local49 = 1e+22;
        local50 = -1;
        local5 = param3;
        while(local5 != null) {
          local8 = local5.alternativa3d::wrapper;
          while(local8 != null) {
            local48 = Number(local8.alternativa3d::vertex.alternativa3d::cameraZ);
            if(local48 < local49) {
              local49 = local48;
            }
            if(local48 > local50) {
              local50 = local48;
            }
            local8 = local8.alternativa3d::next;
          }
          local5 = local5.alternativa3d::processNext;
        }
        local14 = param1.alternativa3d::focalLength * resolution;
        local51 = local49 >= local14 ? int(1 + Math.log(local49 / local14) * 1.4426950408889634) : 0;
        if(local51 >= alternativa3d::numMaps) {
          local51 = alternativa3d::numMaps - 1;
        }
        local52 = local50 >= local14 ? int(1 + Math.log(local50 / local14) * 1.4426950408889634) : 0;
        if(local52 >= alternativa3d::numMaps) {
          local52 = alternativa3d::numMaps - 1;
        }
        local48 = local14 * Math.pow(2,local52 - 1);
        local15 = local52;
        while(local15 >= local51) {
          local43++;
          local38 = 0;
          local39 = 0;
          local40 = 0;
          local41 = 0;
          local42 = 0;
          local54 = local48 - threshold;
          local55 = local48 + threshold;
          local5 = param3;
          param3 = null;
          local7 = null;
          while(local5 != null) {
            local6 = local5.alternativa3d::processNext;
            local5.alternativa3d::processNext = null;
            local8 = null;
            if(local15 == local51) {
              local8 = local5.alternativa3d::wrapper;
            } else {
              local56 = local5.alternativa3d::wrapper;
              local57 = Number(local56.alternativa3d::vertex.alternativa3d::cameraZ);
              local56 = local56.alternativa3d::next;
              local58 = Number(local56.alternativa3d::vertex.alternativa3d::cameraZ);
              local56 = local56.alternativa3d::next;
              local59 = Number(local56.alternativa3d::vertex.alternativa3d::cameraZ);
              local56 = local56.alternativa3d::next;
              local60 = local57 < local54 || local58 < local54 || local59 < local54;
              local61 = local57 > local55 || local58 > local55 || local59 > local55;
              while(local56 != null) {
                local62 = Number(local56.alternativa3d::vertex.alternativa3d::cameraZ);
                if(local62 < local54) {
                  local60 = true;
                } else if(local62 > local55) {
                  local61 = true;
                }
                local56 = local56.alternativa3d::next;
              }
              if(!local60) {
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
                local64 = null;
                local65 = null;
                local56 = local5.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next;
                while(local56.alternativa3d::next != null) {
                  local56 = local56.alternativa3d::next;
                }
                local67 = local56.alternativa3d::vertex;
                local57 = Number(local67.alternativa3d::cameraZ);
                local56 = local5.alternativa3d::wrapper;
                while(local56 != null) {
                  local68 = local56.alternativa3d::vertex;
                  local58 = Number(local68.alternativa3d::cameraZ);
                  if(local57 < local54 && local58 > local55 || local57 > local55 && local58 < local54) {
                    local13 = (local48 - local57) / (local58 - local57);
                    local69 = local68.alternativa3d::create();
                    param1.alternativa3d::lastVertex.alternativa3d::next = local69;
                    param1.alternativa3d::lastVertex = local69;
                    local69.alternativa3d::cameraX = local67.alternativa3d::cameraX + (local68.alternativa3d::cameraX - local67.alternativa3d::cameraX) * local13;
                    local69.alternativa3d::cameraY = local67.alternativa3d::cameraY + (local68.alternativa3d::cameraY - local67.alternativa3d::cameraY) * local13;
                    local69.alternativa3d::cameraZ = local48;
                    local69.u = local67.u + (local68.u - local67.u) * local13;
                    local69.v = local67.v + (local68.v - local67.v) * local13;
                    local69.x = local67.x + (local68.x - local67.x) * local13;
                    local69.y = local67.y + (local68.y - local67.y) * local13;
                    local69.z = local67.z + (local68.z - local67.z) * local13;
                    local69.normalX = local67.normalX + (local68.normalX - local67.normalX) * local13;
                    local69.normalY = local67.normalY + (local68.normalY - local67.normalY) * local13;
                    local69.normalZ = local67.normalZ + (local68.normalZ - local67.normalZ) * local13;
                    local66 = local56.alternativa3d::create();
                    local66.alternativa3d::vertex = local69;
                    if(local64 != null) {
                      local64.alternativa3d::next = local66;
                    } else {
                      local63.alternativa3d::wrapper = local66;
                    }
                    local64 = local66;
                    local66 = local56.alternativa3d::create();
                    local66.alternativa3d::vertex = local69;
                    if(local65 != null) {
                      local65.alternativa3d::next = local66;
                    } else {
                      local8 = local66;
                    }
                    local65 = local66;
                  }
                  if(local58 <= local55) {
                    local66 = local56.alternativa3d::create();
                    local66.alternativa3d::vertex = local68;
                    if(local64 != null) {
                      local64.alternativa3d::next = local66;
                    } else {
                      local63.alternativa3d::wrapper = local66;
                    }
                    local64 = local66;
                  }
                  if(local58 >= local54) {
                    local66 = local56.alternativa3d::create();
                    local66.alternativa3d::vertex = local68;
                    if(local65 != null) {
                      local65.alternativa3d::next = local66;
                    } else {
                      local8 = local66;
                    }
                    local65 = local66;
                  }
                  local67 = local68;
                  local57 = local58;
                  local56 = local56.alternativa3d::next;
                }
                if(param3 != null) {
                  local7.alternativa3d::processNext = local63;
                } else {
                  param3 = local63;
                }
                local7 = local63;
                local53 = local8;
              }
            }
            if(local8 != null) {
              local9 = local8.alternativa3d::vertex;
              if(local9.alternativa3d::drawId != local43) {
                local13 = 1 / local9.alternativa3d::cameraZ;
                local34[local39] = local9.alternativa3d::cameraX * local22 * local13;
                local39++;
                local34[local39] = local9.alternativa3d::cameraY * local23 * local13;
                local39++;
                local35[local40] = local9.u;
                local40++;
                local35[local40] = local9.v;
                local40++;
                local35[local40] = local13;
                local40++;
                local10 = local38;
                local9.alternativa3d::index = local38++;
                local9.alternativa3d::drawId = local43;
                local28 = local9.alternativa3d::cameraX * local24;
                local29 = local9.alternativa3d::cameraY * local25;
                local30 = Number(local9.alternativa3d::cameraZ);
                local27 = 1 / Math.sqrt(local28 * local28 + local29 * local29 + local30 * local30);
                local28 *= local27;
                local29 *= local27;
                local30 *= local27;
                local31 = (local9.normalX * local26.alternativa3d::ima + local9.normalY * local26.alternativa3d::ime + local9.normalZ * local26.alternativa3d::imi) * local24;
                local32 = (local9.normalX * local26.alternativa3d::imb + local9.normalY * local26.alternativa3d::imf + local9.normalZ * local26.alternativa3d::imj) * local25;
                local33 = local9.normalX * local26.alternativa3d::imc + local9.normalY * local26.alternativa3d::img + local9.normalZ * local26.alternativa3d::imk;
                if(local33 > 0) {
                  local33 = 0;
                }
                local27 = 1 / Math.sqrt(local31 * local31 + local32 * local32 + local33 * local33);
                local31 *= local27;
                local32 *= local27;
                local33 *= local27;
                local27 = local28 * local31 + local29 * local32 + local30 * local33;
                local27 += local27;
                local31 = local28 - local31 * local27;
                local32 = local29 - local32 * local27;
                local33 = local30 - local33 * local27 - 1;
                local27 = 1 / Math.sqrt(local31 * local31 + local32 * local32 + local33 * local33);
                local31 *= local27;
                local32 *= local27;
                local33 *= local27;
                local36[local41] = local31 * 0.5 + 0.5;
                local41++;
                local36[local41] = local32 * 0.5 + 0.5;
                local41++;
              } else {
                local10 = int(local9.alternativa3d::index);
              }
              local8 = local8.alternativa3d::next;
              local9 = local8.alternativa3d::vertex;
              if(local9.alternativa3d::drawId != local43) {
                local13 = 1 / local9.alternativa3d::cameraZ;
                local34[local39] = local9.alternativa3d::cameraX * local22 * local13;
                local39++;
                local34[local39] = local9.alternativa3d::cameraY * local23 * local13;
                local39++;
                local35[local40] = local9.u;
                local40++;
                local35[local40] = local9.v;
                local40++;
                local35[local40] = local13;
                local40++;
                local11 = local38;
                local9.alternativa3d::index = local38++;
                local9.alternativa3d::drawId = local43;
                local28 = local9.alternativa3d::cameraX * local24;
                local29 = local9.alternativa3d::cameraY * local25;
                local30 = Number(local9.alternativa3d::cameraZ);
                local27 = 1 / Math.sqrt(local28 * local28 + local29 * local29 + local30 * local30);
                local28 *= local27;
                local29 *= local27;
                local30 *= local27;
                local31 = (local9.normalX * local26.alternativa3d::ima + local9.normalY * local26.alternativa3d::ime + local9.normalZ * local26.alternativa3d::imi) * local24;
                local32 = (local9.normalX * local26.alternativa3d::imb + local9.normalY * local26.alternativa3d::imf + local9.normalZ * local26.alternativa3d::imj) * local25;
                local33 = local9.normalX * local26.alternativa3d::imc + local9.normalY * local26.alternativa3d::img + local9.normalZ * local26.alternativa3d::imk;
                if(local33 > 0) {
                  local33 = 0;
                }
                local27 = 1 / Math.sqrt(local31 * local31 + local32 * local32 + local33 * local33);
                local31 *= local27;
                local32 *= local27;
                local33 *= local27;
                local27 = local28 * local31 + local29 * local32 + local30 * local33;
                local27 += local27;
                local31 = local28 - local31 * local27;
                local32 = local29 - local32 * local27;
                local33 = local30 - local33 * local27 - 1;
                local27 = 1 / Math.sqrt(local31 * local31 + local32 * local32 + local33 * local33);
                local31 *= local27;
                local32 *= local27;
                local33 *= local27;
                local36[local41] = local31 * 0.5 + 0.5;
                local41++;
                local36[local41] = local32 * 0.5 + 0.5;
                local41++;
              } else {
                local11 = int(local9.alternativa3d::index);
              }
              local8 = local8.alternativa3d::next;
              while(local8 != null) {
                local9 = local8.alternativa3d::vertex;
                if(local9.alternativa3d::drawId != local43) {
                  local13 = 1 / local9.alternativa3d::cameraZ;
                  local34[local39] = local9.alternativa3d::cameraX * local22 * local13;
                  local39++;
                  local34[local39] = local9.alternativa3d::cameraY * local23 * local13;
                  local39++;
                  local35[local40] = local9.u;
                  local40++;
                  local35[local40] = local9.v;
                  local40++;
                  local35[local40] = local13;
                  local40++;
                  local12 = local38;
                  local9.alternativa3d::index = local38++;
                  local9.alternativa3d::drawId = local43;
                  local28 = local9.alternativa3d::cameraX * local24;
                  local29 = local9.alternativa3d::cameraY * local25;
                  local30 = Number(local9.alternativa3d::cameraZ);
                  local27 = 1 / Math.sqrt(local28 * local28 + local29 * local29 + local30 * local30);
                  local28 *= local27;
                  local29 *= local27;
                  local30 *= local27;
                  local31 = (local9.normalX * local26.alternativa3d::ima + local9.normalY * local26.alternativa3d::ime + local9.normalZ * local26.alternativa3d::imi) * local24;
                  local32 = (local9.normalX * local26.alternativa3d::imb + local9.normalY * local26.alternativa3d::imf + local9.normalZ * local26.alternativa3d::imj) * local25;
                  local33 = local9.normalX * local26.alternativa3d::imc + local9.normalY * local26.alternativa3d::img + local9.normalZ * local26.alternativa3d::imk;
                  if(local33 > 0) {
                    local33 = 0;
                  }
                  local27 = 1 / Math.sqrt(local31 * local31 + local32 * local32 + local33 * local33);
                  local31 *= local27;
                  local32 *= local27;
                  local33 *= local27;
                  local27 = local28 * local31 + local29 * local32 + local30 * local33;
                  local27 += local27;
                  local31 = local28 - local31 * local27;
                  local32 = local29 - local32 * local27;
                  local33 = local30 - local33 * local27 - 1;
                  local27 = 1 / Math.sqrt(local31 * local31 + local32 * local32 + local33 * local33);
                  local31 *= local27;
                  local32 *= local27;
                  local33 *= local27;
                  local36[local41] = local31 * 0.5 + 0.5;
                  local41++;
                  local36[local41] = local32 * 0.5 + 0.5;
                  local41++;
                } else {
                  local12 = int(local9.alternativa3d::index);
                }
                alternativa3d::drawIndices[local42] = local10;
                local42++;
                alternativa3d::drawIndices[local42] = local11;
                local42++;
                alternativa3d::drawIndices[local42] = local12;
                local42++;
                local11 = local12;
                local45++;
                local8 = local8.alternativa3d::next;
              }
              local44++;
              if(local53 != null) {
                local8 = local53;
                while(local8 != null) {
                  local8.alternativa3d::vertex = null;
                  local8 = local8.alternativa3d::next;
                }
                param1.alternativa3d::lastWrapper.alternativa3d::next = local53;
                param1.alternativa3d::lastWrapper = local65;
                local53 = null;
              }
            }
            local5 = local6;
          }
          local48 *= 0.5;
          local34.length = local39;
          local35.length = local40;
          local36.length = local41;
          local37.length = local42;
          local21 = alternativa3d::mipMap[local15];
          if(correctUV) {
            local19 = -0.5 / (local21.width - 1);
            local20 = -0.5 / (local21.height - 1);
            local17 = 1 - local19 - local19;
            local18 = 1 - local20 - local20;
            local16 = 0;
            while(local16 < local40) {
              local35[local16] = local35[local16] * local17 + local19;
              local16++;
              local35[local16] = local35[local16] * local18 + local20;
              local16++;
              local16++;
            }
          }
          param2.alternativa3d::gfx.beginBitmapFill(local21,null,repeat,smooth);
          param2.alternativa3d::gfx.drawTriangles(local34,local37,local35,"none");
          local46.alternativa3d::gfx.beginBitmapFill(this.environmentMap,null,false,smooth);
          local46.alternativa3d::gfx.drawTriangles(local34,local37,local36,"none");
          local15--;
        }
      }
      if(alternativa3d::_texture != null) {
        local44 += local44;
        local45 += local45;
      }
      param1.alternativa3d::numDraws = local43;
      param1.alternativa3d::numPolygons += local44;
      param1.alternativa3d::numTriangles += local45;
    }

    override alternativa3d function drawViewAligned(param1:Camera3D, param2:Canvas, param3:Face, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number) : void {
      var local13:Face = null;
      var local14:Face = null;
      var local15:Wrapper = null;
      var local16:Vertex = null;
      var local17:BitmapData = null;
      var local20:Canvas = null;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Number = NaN;
      var local34:Number = NaN;
      var local35:Number = NaN;
      var local36:Number = NaN;
      var local37:Number = NaN;
      var local38:int = 0;
      var local39:int = 0;
      var local40:int = 0;
      var local41:Number = NaN;
      var local42:Number = NaN;
      var local43:Number = NaN;
      var local44:int = 0;
      var local45:int = 0;
      var local11:Number = Number(param1.alternativa3d::viewSizeX);
      var local12:Number = Number(param1.alternativa3d::viewSizeY);
      var local18:int = 0;
      var local19:int = 0;
      if(this.environmentMap == null) {
        alternativa3d::clearLinks(param3);
        return;
      }
      if(this.alpha == 1 && this.blendMode == "normal" && this.colorTransform == null) {
        local20 = param2;
      } else {
        local20 = param2.alternativa3d::getChildCanvas(true,false,param2.alternativa3d::object,this.alpha,this.blendMode,this.colorTransform);
      }
      if(alternativa3d::_texture != null) {
        if(alternativa3d::_mipMapping == 0) {
          local17 = alternativa3d::_texture;
        } else {
          local43 = param1.alternativa3d::focalLength * resolution;
          local44 = param4 >= local43 ? int(1 + Math.log(param4 / local43) * 1.4426950408889634) : 0;
          if(local44 >= alternativa3d::numMaps) {
            local44 = alternativa3d::numMaps - 1;
          }
          local17 = alternativa3d::mipMap[local44];
        }
        local41 = local17.width;
        local42 = local17.height;
        alternativa3d::drawMatrix.a = param5 / local41;
        alternativa3d::drawMatrix.b = param6 / local41;
        alternativa3d::drawMatrix.c = param7 / local42;
        alternativa3d::drawMatrix.d = param8 / local42;
        alternativa3d::drawMatrix.tx = param9;
        alternativa3d::drawMatrix.ty = param10;
        param2.alternativa3d::gfx.beginBitmapFill(local17,alternativa3d::drawMatrix,repeat,smooth);
        local13 = param3;
        while(local13 != null) {
          local15 = local13.alternativa3d::wrapper;
          local16 = local15.alternativa3d::vertex;
          param2.alternativa3d::gfx.moveTo(local16.alternativa3d::cameraX * local11 / param4,local16.alternativa3d::cameraY * local12 / param4);
          local45 = -1;
          local15 = local15.alternativa3d::next;
          while(local15 != null) {
            local16 = local15.alternativa3d::vertex;
            param2.alternativa3d::gfx.lineTo(local16.alternativa3d::cameraX * local11 / param4,local16.alternativa3d::cameraY * local12 / param4);
            local45++;
            local15 = local15.alternativa3d::next;
          }
          local19 += local45;
          local18++;
          local13 = local13.alternativa3d::processNext;
        }
        ++param1.alternativa3d::numDraws;
      }
      var local21:Vector.<Number> = alternativa3d::drawVertices;
      var local22:Vector.<Number> = alternativa3d::drawUVs;
      var local23:Vector.<int> = alternativa3d::drawIndices;
      var local24:int = 0;
      var local25:int = 0;
      var local26:int = 0;
      var local27:int = 0;
      var local28:int = param1.alternativa3d::numDraws + 1;
      var local29:Number = param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
      var local30:Number = param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
      local13 = param3;
      while(local13 != null) {
        local14 = local13.alternativa3d::processNext;
        local13.alternativa3d::processNext = null;
        local15 = local13.alternativa3d::wrapper;
        local16 = local15.alternativa3d::vertex;
        if(local16.alternativa3d::drawId != local28) {
          local21[local25] = local16.alternativa3d::cameraX * local11 / param4;
          local25++;
          local21[local25] = local16.alternativa3d::cameraY * local12 / param4;
          local25++;
          local38 = local24;
          local16.alternativa3d::index = local24++;
          local16.alternativa3d::drawId = local28;
          local32 = local16.alternativa3d::cameraX * local29;
          local33 = local16.alternativa3d::cameraY * local30;
          local34 = Number(local16.alternativa3d::cameraZ);
          local31 = 1 / Math.sqrt(local32 * local32 + local33 * local33 + local34 * local34);
          local35 = local32 * local31;
          local36 = local33 * local31;
          local37 = -local34 * local31 - 1;
          local31 = 1 / Math.sqrt(local35 * local35 + local36 * local36 + local37 * local37);
          local35 *= local31;
          local36 *= local31;
          local37 *= local31;
          local22[local26] = local35 * 0.5 + 0.5;
          local26++;
          local22[local26] = local36 * 0.5 + 0.5;
          local26++;
        } else {
          local38 = int(local16.alternativa3d::index);
        }
        local15 = local15.alternativa3d::next;
        local16 = local15.alternativa3d::vertex;
        if(local16.alternativa3d::drawId != local28) {
          local21[local25] = local16.alternativa3d::cameraX * local11 / param4;
          local25++;
          local21[local25] = local16.alternativa3d::cameraY * local12 / param4;
          local25++;
          local39 = local24;
          local16.alternativa3d::index = local24++;
          local16.alternativa3d::drawId = local28;
          local32 = local16.alternativa3d::cameraX * local29;
          local33 = local16.alternativa3d::cameraY * local30;
          local34 = Number(local16.alternativa3d::cameraZ);
          local31 = 1 / Math.sqrt(local32 * local32 + local33 * local33 + local34 * local34);
          local35 = local32 * local31;
          local36 = local33 * local31;
          local37 = -local34 * local31 - 1;
          local31 = 1 / Math.sqrt(local35 * local35 + local36 * local36 + local37 * local37);
          local35 *= local31;
          local36 *= local31;
          local37 *= local31;
          local22[local26] = local35 * 0.5 + 0.5;
          local26++;
          local22[local26] = local36 * 0.5 + 0.5;
          local26++;
        } else {
          local39 = int(local16.alternativa3d::index);
        }
        local15 = local15.alternativa3d::next;
        while(local15 != null) {
          local16 = local15.alternativa3d::vertex;
          if(local16.alternativa3d::drawId != local28) {
            local21[local25] = local16.alternativa3d::cameraX * local11 / param4;
            local25++;
            local21[local25] = local16.alternativa3d::cameraY * local12 / param4;
            local25++;
            local40 = local24;
            local16.alternativa3d::index = local24++;
            local16.alternativa3d::drawId = local28;
            local32 = local16.alternativa3d::cameraX * local29;
            local33 = local16.alternativa3d::cameraY * local30;
            local34 = Number(local16.alternativa3d::cameraZ);
            local31 = 1 / Math.sqrt(local32 * local32 + local33 * local33 + local34 * local34);
            local35 = local32 * local31;
            local36 = local33 * local31;
            local37 = -local34 * local31 - 1;
            local31 = 1 / Math.sqrt(local35 * local35 + local36 * local36 + local37 * local37);
            local35 *= local31;
            local36 *= local31;
            local37 *= local31;
            local22[local26] = local35 * 0.5 + 0.5;
            local26++;
            local22[local26] = local36 * 0.5 + 0.5;
            local26++;
          } else {
            local40 = int(local16.alternativa3d::index);
          }
          alternativa3d::drawIndices[local27] = local38;
          local27++;
          alternativa3d::drawIndices[local27] = local39;
          local27++;
          alternativa3d::drawIndices[local27] = local40;
          local27++;
          local39 = local40;
          local19++;
          local15 = local15.alternativa3d::next;
        }
        local18++;
        local13 = local14;
      }
      local21.length = local25;
      local22.length = local26;
      local23.length = local27;
      local20.alternativa3d::gfx.beginBitmapFill(this.environmentMap,null,false,smooth);
      local20.alternativa3d::gfx.drawTriangles(local21,local23,local22,"none");
      param1.alternativa3d::numDraws = local28;
      param1.alternativa3d::numPolygons += local18;
      param1.alternativa3d::numTriangles += local19;
    }
  }
}
