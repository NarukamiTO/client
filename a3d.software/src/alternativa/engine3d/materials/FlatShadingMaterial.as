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
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class FlatShadingMaterial extends TextureMaterial {
    alternativa3d static var colorTransform:ColorTransform = new ColorTransform();

    alternativa3d static const lights:Vector.<Light3D> = new Vector.<Light3D>();
    alternativa3d static const multiplier:ColorTransform = new ColorTransform(2,2,2);

    alternativa3d var weights:Dictionary = new Dictionary();

    public var defaultLightWeight:Number = 1;
    public var multipliedDiffuse:Boolean = false;

    public function FlatShadingMaterial(param1:BitmapData = null, param2:Boolean = false, param3:Boolean = true, param4:int = 0, param5:Number = 1) {
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
      var local1:FlatShadingMaterial = new FlatShadingMaterial(alternativa3d::_texture,repeat,smooth,alternativa3d::_mipMapping,resolution);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Material) : void {
      super.clonePropertiesFrom(param1);
      var local2:FlatShadingMaterial = param1 as FlatShadingMaterial;
      this.defaultLightWeight = local2.defaultLightWeight;
      this.multipliedDiffuse = local2.multipliedDiffuse;
    }

    override alternativa3d function draw(param1:Camera3D, param2:Canvas, param3:Face, param4:Number) : void {
      var local5:int = 0;
      var local6:Light3D = null;
      var local7:DirectionalLight = null;
      var local8:OmniLight = null;
      var local9:SpotLight = null;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Number = NaN;
      var local26:int = 0;
      var local27:Wrapper = null;
      var local28:Vertex = null;
      var local29:Vertex = null;
      var local30:Number = NaN;
      var local31:Number = NaN;
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
      var local42:Number = NaN;
      var local43:int = 0;
      var local44:int = 0;
      var local45:int = 0;
      var local46:Number = NaN;
      var local47:Number = NaN;
      var local15:Number = Number(param1.alternativa3d::viewSizeX);
      var local16:Number = Number(param1.alternativa3d::viewSizeY);
      var local17:int = 0;
      var local18:int = 0;
      var local19:Canvas = param2.alternativa3d::getChildCanvas(true,false,param2.alternativa3d::object,1,"multiply");
      var local20:int = 0;
      local5 = 0;
      while(local5 < param1.alternativa3d::lightsLength) {
        local6 = param1.alternativa3d::lights[local5];
        local22 = Number(this.alternativa3d::weights[local6]);
        if(local22 != local22) {
          local22 = this.defaultLightWeight;
        }
        if(local22 > 0) {
          local6.alternativa3d::calculateObjectMatrix(param2.alternativa3d::object);
          if(local6.alternativa3d::checkBoundsIntersection(param2.alternativa3d::object)) {
            local6.alternativa3d::localRed = (local6.color >> 16 & 0xFF) * local6.intensity * local22;
            local6.alternativa3d::localGreen = (local6.color >> 8 & 0xFF) * local6.intensity * local22;
            local6.alternativa3d::localBlue = (local6.color & 0xFF) * local6.intensity * local22;
            if(local6 is DirectionalLight) {
              local7 = local6 as DirectionalLight;
              local7.alternativa3d::localDirectionX = local7.alternativa3d::omc;
              local7.alternativa3d::localDirectionY = local7.alternativa3d::omg;
              local7.alternativa3d::localDirectionZ = local7.alternativa3d::omk;
              local14 = Math.sqrt(local7.alternativa3d::localDirectionX * local7.alternativa3d::localDirectionX + local7.alternativa3d::localDirectionY * local7.alternativa3d::localDirectionY + local7.alternativa3d::localDirectionZ * local7.alternativa3d::localDirectionZ);
              local7.alternativa3d::localDirectionX /= local14;
              local7.alternativa3d::localDirectionY /= local14;
              local7.alternativa3d::localDirectionZ /= local14;
            } else if(local6 is OmniLight) {
              local8 = local6 as OmniLight;
              local10 = Math.sqrt(local8.alternativa3d::oma * local8.alternativa3d::oma + local8.alternativa3d::ome * local8.alternativa3d::ome + local8.alternativa3d::omi * local8.alternativa3d::omi);
              local10 += Math.sqrt(local8.alternativa3d::omb * local8.alternativa3d::omb + local8.alternativa3d::omf * local8.alternativa3d::omf + local8.alternativa3d::omj * local8.alternativa3d::omj);
              local10 += Math.sqrt(local8.alternativa3d::omc * local8.alternativa3d::omc + local8.alternativa3d::omg * local8.alternativa3d::omg + local8.alternativa3d::omk * local8.alternativa3d::omk);
              local10 /= 3;
              local8.alternativa3d::localAttenuationBegin = local8.attenuationBegin * local10;
              local8.alternativa3d::localAttenuationEnd = local8.attenuationEnd * local10;
            } else if(local6 is SpotLight) {
              local9 = local6 as SpotLight;
              local10 = Math.sqrt(local9.alternativa3d::oma * local9.alternativa3d::oma + local9.alternativa3d::ome * local9.alternativa3d::ome + local9.alternativa3d::omi * local9.alternativa3d::omi);
              local10 += Math.sqrt(local9.alternativa3d::omb * local9.alternativa3d::omb + local9.alternativa3d::omf * local9.alternativa3d::omf + local9.alternativa3d::omj * local9.alternativa3d::omj);
              local10 += Math.sqrt(local9.alternativa3d::omc * local9.alternativa3d::omc + local9.alternativa3d::omg * local9.alternativa3d::omg + local9.alternativa3d::omk * local9.alternativa3d::omk);
              local10 /= 3;
              local9.alternativa3d::localAttenuationBegin = local9.attenuationBegin * local10;
              local9.alternativa3d::localAttenuationEnd = local9.attenuationEnd * local10;
              local9.alternativa3d::localDirectionX = local9.alternativa3d::omc;
              local9.alternativa3d::localDirectionY = local9.alternativa3d::omg;
              local9.alternativa3d::localDirectionZ = local9.alternativa3d::omk;
              local14 = Math.sqrt(local9.alternativa3d::localDirectionX * local9.alternativa3d::localDirectionX + local9.alternativa3d::localDirectionY * local9.alternativa3d::localDirectionY + local9.alternativa3d::localDirectionZ * local9.alternativa3d::localDirectionZ);
              local9.alternativa3d::localDirectionX /= local14;
              local9.alternativa3d::localDirectionY /= local14;
              local9.alternativa3d::localDirectionZ /= local14;
              local9.alternativa3d::localHotspot = Math.cos(local9.hotspot * 0.5);
              local9.alternativa3d::localFalloff = Math.cos(local9.falloff * 0.5);
            }
            alternativa3d::lights[local20] = local6;
            local20++;
          }
        }
        local5++;
      }
      var local21:Face = param3;
      while(local21 != null) {
        local23 = 0;
        local24 = 0;
        local25 = 0;
        local26 = 0;
        local27 = local21.alternativa3d::wrapper;
        local28 = local27.alternativa3d::vertex;
        local23 += local28.x;
        local24 += local28.y;
        local25 += local28.z;
        local26++;
        local27 = local27.alternativa3d::next;
        local29 = local27.alternativa3d::vertex;
        local23 += local29.x;
        local24 += local29.y;
        local25 += local29.z;
        local26++;
        local30 = local29.x - local28.x;
        local31 = local29.y - local28.y;
        local32 = local29.z - local28.z;
        local27 = local27.alternativa3d::next;
        local29 = local27.alternativa3d::vertex;
        local23 += local29.x;
        local24 += local29.y;
        local25 += local29.z;
        local26++;
        local33 = local29.x - local28.x;
        local34 = local29.y - local28.y;
        local35 = local29.z - local28.z;
        local27 = local27.alternativa3d::next;
        while(local27 != null) {
          local29 = local27.alternativa3d::vertex;
          local23 += local29.x;
          local24 += local29.y;
          local25 += local29.z;
          local26++;
          local27 = local27.alternativa3d::next;
        }
        local23 /= local26;
        local24 /= local26;
        local25 /= local26;
        local36 = local35 * local31 - local34 * local32;
        local37 = local33 * local32 - local35 * local30;
        local38 = local34 * local30 - local33 * local31;
        local39 = Math.sqrt(local36 * local36 + local37 * local37 + local38 * local38);
        local36 /= local39;
        local37 /= local39;
        local38 /= local39;
        local40 = 0;
        local41 = 0;
        local42 = 0;
        local5 = 0;
        while(local5 < local20) {
          local6 = alternativa3d::lights[local5];
          if(local6 is AmbientLight) {
            local40 += local6.alternativa3d::localRed;
            local41 += local6.alternativa3d::localGreen;
            local42 += local6.alternativa3d::localBlue;
          } else if(local6 is DirectionalLight) {
            local7 = local6 as DirectionalLight;
            local46 = -local36 * local7.alternativa3d::localDirectionX - local37 * local7.alternativa3d::localDirectionY - local38 * local7.alternativa3d::localDirectionZ;
            if(local46 > 0) {
              local40 += local6.alternativa3d::localRed * local46;
              local41 += local6.alternativa3d::localGreen * local46;
              local42 += local6.alternativa3d::localBlue * local46;
            }
          } else if(local6 is OmniLight) {
            local8 = local6 as OmniLight;
            local11 = local23 - local8.alternativa3d::omd;
            local12 = local24 - local8.alternativa3d::omh;
            local13 = local25 - local8.alternativa3d::oml;
            local14 = local11 * local11 + local12 * local12 + local13 * local13;
            if(local14 < local8.alternativa3d::localAttenuationEnd * local8.alternativa3d::localAttenuationEnd) {
              local14 = Math.sqrt(local14);
              local11 /= local14;
              local12 /= local14;
              local13 /= local14;
              local46 = -local36 * local11 - local37 * local12 - local38 * local13;
              if(local46 > 0) {
                if(local14 > local8.alternativa3d::localAttenuationBegin) {
                  local46 *= 1 - (local14 - local8.alternativa3d::localAttenuationBegin) / (local8.alternativa3d::localAttenuationEnd - local8.alternativa3d::localAttenuationBegin);
                }
                local40 += local6.alternativa3d::localRed * local46;
                local41 += local6.alternativa3d::localGreen * local46;
                local42 += local6.alternativa3d::localBlue * local46;
              }
            }
          } else if(local6 is SpotLight) {
            local9 = local6 as SpotLight;
            local11 = local23 - local9.alternativa3d::omd;
            local12 = local24 - local9.alternativa3d::omh;
            local13 = local25 - local9.alternativa3d::oml;
            local14 = local11 * local11 + local12 * local12 + local13 * local13;
            if(local14 < local9.alternativa3d::localAttenuationEnd * local9.alternativa3d::localAttenuationEnd) {
              local14 = Math.sqrt(local14);
              local11 /= local14;
              local12 /= local14;
              local13 /= local14;
              local47 = local9.alternativa3d::localDirectionX * local11 + local9.alternativa3d::localDirectionY * local12 + local9.alternativa3d::localDirectionZ * local13;
              if(local47 > local9.alternativa3d::localFalloff) {
                local46 = -local36 * local11 - local37 * local12 - local38 * local13;
                if(local46 > 0) {
                  if(local14 > local9.alternativa3d::localAttenuationBegin) {
                    local46 *= 1 - (local14 - local9.alternativa3d::localAttenuationBegin) / (local9.alternativa3d::localAttenuationEnd - local9.alternativa3d::localAttenuationBegin);
                  }
                  if(local47 < local9.alternativa3d::localHotspot) {
                    local46 *= (local47 - local9.alternativa3d::localFalloff) / (local9.alternativa3d::localHotspot - local9.alternativa3d::localFalloff);
                  }
                  local40 += local6.alternativa3d::localRed * local46;
                  local41 += local6.alternativa3d::localGreen * local46;
                  local42 += local6.alternativa3d::localBlue * local46;
                }
              }
            }
          }
          local5++;
        }
        local43 = local40 > 255 ? 255 : (local40 < 0 ? 0 : int(local40));
        local44 = local41 > 255 ? 255 : (local41 < 0 ? 0 : int(local41));
        local45 = local42 > 255 ? 255 : (local42 < 0 ? 0 : int(local42));
        local19.alternativa3d::gfx.beginFill((local43 << 16) + (local44 << 8) + local45);
        local19.alternativa3d::gfx.moveTo(local28.alternativa3d::cameraX * local15 / local28.alternativa3d::cameraZ,local28.alternativa3d::cameraY * local16 / local28.alternativa3d::cameraZ);
        local27 = local21.alternativa3d::wrapper.alternativa3d::next;
        while(local27 != null) {
          local29 = local27.alternativa3d::vertex;
          local19.alternativa3d::gfx.lineTo(local29.alternativa3d::cameraX * local15 / local29.alternativa3d::cameraZ,local29.alternativa3d::cameraY * local16 / local29.alternativa3d::cameraZ);
          local18++;
          local27 = local27.alternativa3d::next;
        }
        local18--;
        local17++;
        local21 = local21.alternativa3d::processNext;
      }
      ++param1.alternativa3d::numDraws;
      param1.alternativa3d::numPolygons += local17;
      param1.alternativa3d::numTriangles += local18;
      super.alternativa3d::draw(param1,this.multipliedDiffuse ? param2 : param2.alternativa3d::getChildCanvas(true,false,param2.alternativa3d::object,1,"normal",alternativa3d::multiplier),param3,param4);
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
