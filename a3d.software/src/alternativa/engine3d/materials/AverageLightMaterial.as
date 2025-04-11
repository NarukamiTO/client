package alternativa.engine3d.materials {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.lights.AmbientLight;
  import alternativa.engine3d.lights.DirectionalLight;
  import alternativa.engine3d.lights.OmniLight;
  import alternativa.engine3d.lights.SpotLight;
  import flash.display.BitmapData;
  import flash.geom.ColorTransform;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class AverageLightMaterial extends TextureMaterial {
    alternativa3d static var colorTransform:ColorTransform = new ColorTransform();

    alternativa3d var weights:Dictionary = new Dictionary();

    public var cameraDependence:Number = 1;
    public var defaultLightWeight:Number = 1;

    public function AverageLightMaterial(param1:BitmapData = null, param2:Boolean = false, param3:Boolean = true, param4:int = 0, param5:Number = 1) {
      super(param1,param2,param3,param4,param5);
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
      var local1:AverageLightMaterial = new AverageLightMaterial(alternativa3d::_texture,repeat,smooth,alternativa3d::_mipMapping,resolution);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Material) : void {
      super.clonePropertiesFrom(param1);
      var local2:AverageLightMaterial = param1 as AverageLightMaterial;
      this.defaultLightWeight = local2.defaultLightWeight;
    }

    override alternativa3d function draw(param1:Camera3D, param2:Canvas, param3:Face, param4:Number) : void {
      this.alternativa3d::calculateLight(param1,param2.alternativa3d::object);
      if(param2.alternativa3d::modifiedColorTransform) {
        super.alternativa3d::draw(param1,param2.alternativa3d::getChildCanvas(true,false,param2.alternativa3d::object,1,"normal",alternativa3d::colorTransform),param3,param4);
      } else {
        super.alternativa3d::draw(param1,param2,param3,param4);
        param2.transform.colorTransform = alternativa3d::colorTransform;
        param2.alternativa3d::modifiedColorTransform = true;
      }
    }

    override alternativa3d function drawViewAligned(param1:Camera3D, param2:Canvas, param3:Face, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number) : void {
      this.alternativa3d::calculateLight(param1,param2.alternativa3d::object);
      if(param2.alternativa3d::modifiedColorTransform) {
        super.alternativa3d::drawViewAligned(param1,param2.alternativa3d::getChildCanvas(true,false,param2.alternativa3d::object,1,"normal",alternativa3d::colorTransform),param3,param4,param5,param6,param7,param8,param9,param10);
      } else {
        super.alternativa3d::drawViewAligned(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
        param2.transform.colorTransform = alternativa3d::colorTransform;
        param2.alternativa3d::modifiedColorTransform = true;
      }
    }

    alternativa3d function calculateLight(param1:Camera3D, param2:Object3D) : void {
      var local8:Light3D = null;
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
      var local24:Number = NaN;
      var local25:DirectionalLight = null;
      var local26:OmniLight = null;
      var local27:SpotLight = null;
      var local28:Number = NaN;
      var local29:Number = NaN;
      var local30:Number = NaN;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Number = NaN;
      var local34:Number = NaN;
      var local3:Number = 0;
      var local4:Number = 0;
      var local5:Number = 0;
      var local6:Number = this.cameraDependence * 0.5;
      var local7:int = 0;
      while(local7 < param1.alternativa3d::lightsLength) {
        local8 = param1.alternativa3d::lights[local7];
        local9 = Number(this.alternativa3d::weights[local8]);
        if(local9 != local9) {
          local9 = this.defaultLightWeight;
        }
        if(local9 > 0) {
          local8.alternativa3d::calculateObjectMatrix(param2);
          if(local8.alternativa3d::checkBoundsIntersection(param2)) {
            local22 = (local8.color >> 16 & 0xFF) * local8.intensity * local9;
            local23 = (local8.color >> 8 & 0xFF) * local8.intensity * local9;
            local24 = (local8.color & 0xFF) * local8.intensity * local9;
            if(local8 is AmbientLight) {
              local3 += local22;
              local4 += local23;
              local5 += local24;
            } else if(local8 is DirectionalLight) {
              local25 = local8 as DirectionalLight;
              local10 = param2.alternativa3d::imd;
              local11 = param2.alternativa3d::imh;
              local12 = param2.alternativa3d::iml;
              local13 = Math.sqrt(local10 * local10 + local11 * local11 + local12 * local12);
              local10 /= local13;
              local11 /= local13;
              local12 /= local13;
              local14 = Number(local25.alternativa3d::omc);
              local15 = Number(local25.alternativa3d::omg);
              local16 = Number(local25.alternativa3d::omk);
              local17 = Math.sqrt(local14 * local14 + local15 * local15 + local16 * local16);
              local14 /= local17;
              local15 /= local17;
              local16 /= local17;
              local18 = (-local10 * local14 - local11 * local15 - local12 * local16 - 1) * local6 + 1;
              local3 += local22 * local18;
              local4 += local23 * local18;
              local5 += local24 * local18;
            } else if(local8 is OmniLight) {
              local26 = local8 as OmniLight;
              local19 = Math.sqrt(local26.alternativa3d::oma * local26.alternativa3d::oma + local26.alternativa3d::ome * local26.alternativa3d::ome + local26.alternativa3d::omi * local26.alternativa3d::omi);
              local19 += Math.sqrt(local26.alternativa3d::omb * local26.alternativa3d::omb + local26.alternativa3d::omf * local26.alternativa3d::omf + local26.alternativa3d::omj * local26.alternativa3d::omj);
              local19 += Math.sqrt(local26.alternativa3d::omc * local26.alternativa3d::omc + local26.alternativa3d::omg * local26.alternativa3d::omg + local26.alternativa3d::omk * local26.alternativa3d::omk);
              local19 /= 3;
              local20 = local26.attenuationBegin * local19;
              local21 = local26.attenuationEnd * local19;
              local14 = -local26.alternativa3d::omd;
              local15 = -local26.alternativa3d::omh;
              local16 = -local26.alternativa3d::oml;
              local17 = local14 * local14 + local15 * local15 + local16 * local16;
              if(local17 < local21 * local21) {
                local10 = param2.alternativa3d::imd;
                local11 = param2.alternativa3d::imh;
                local12 = param2.alternativa3d::iml;
                local13 = Math.sqrt(local10 * local10 + local11 * local11 + local12 * local12);
                local10 /= local13;
                local11 /= local13;
                local12 /= local13;
                local17 = Math.sqrt(local17);
                local14 /= local17;
                local15 /= local17;
                local16 /= local17;
                local18 = (-local10 * local14 - local11 * local15 - local12 * local16 - 1) * local6 + 1;
                if(local17 > local20) {
                  local18 *= 1 - (local17 - local20) / (local21 - local20);
                }
                local3 += local22 * local18;
                local4 += local23 * local18;
                local5 += local24 * local18;
              }
            } else if(local8 is SpotLight) {
              local27 = local8 as SpotLight;
              local19 = Math.sqrt(local27.alternativa3d::oma * local27.alternativa3d::oma + local27.alternativa3d::ome * local27.alternativa3d::ome + local27.alternativa3d::omi * local27.alternativa3d::omi);
              local19 += Math.sqrt(local27.alternativa3d::omb * local27.alternativa3d::omb + local27.alternativa3d::omf * local27.alternativa3d::omf + local27.alternativa3d::omj * local27.alternativa3d::omj);
              local19 += Math.sqrt(local27.alternativa3d::omc * local27.alternativa3d::omc + local27.alternativa3d::omg * local27.alternativa3d::omg + local27.alternativa3d::omk * local27.alternativa3d::omk);
              local19 /= 3;
              local20 = local27.attenuationBegin * local19;
              local21 = local27.attenuationEnd * local19;
              local14 = -local27.alternativa3d::omd;
              local15 = -local27.alternativa3d::omh;
              local16 = -local27.alternativa3d::oml;
              local17 = local14 * local14 + local15 * local15 + local16 * local16;
              if(local17 < local21 * local21) {
                local17 = Math.sqrt(local17);
                local14 /= local17;
                local15 /= local17;
                local16 /= local17;
                local28 = Number(local27.alternativa3d::omc);
                local29 = Number(local27.alternativa3d::omg);
                local30 = Number(local27.alternativa3d::omk);
                local31 = Math.sqrt(local28 * local28 + local29 * local29 + local30 * local30);
                local28 /= local31;
                local29 /= local31;
                local30 /= local31;
                local32 = Math.cos(local27.hotspot * 0.5);
                local33 = Math.cos(local27.falloff * 0.5);
                local34 = local28 * local14 + local29 * local15 + local30 * local16;
                if(local34 > local33) {
                  local10 = param2.alternativa3d::imd;
                  local11 = param2.alternativa3d::imh;
                  local12 = param2.alternativa3d::iml;
                  local13 = Math.sqrt(local10 * local10 + local11 * local11 + local12 * local12);
                  local10 /= local13;
                  local11 /= local13;
                  local12 /= local13;
                  local18 = (-local10 * local14 - local11 * local15 - local12 * local16 - 1) * local6 + 1;
                  if(local17 > local20) {
                    local18 *= 1 - (local17 - local20) / (local21 - local20);
                  }
                  if(local34 < local32) {
                    local18 *= (local34 - local33) / (local32 - local33);
                  }
                  local3 += local22 * local18;
                  local4 += local23 * local18;
                  local5 += local24 * local18;
                }
              }
            }
          }
        }
        local7++;
      }
      alternativa3d::colorTransform.redMultiplier = local3 / 127.5;
      alternativa3d::colorTransform.greenMultiplier = local4 / 127.5;
      alternativa3d::colorTransform.blueMultiplier = local5 / 127.5;
    }
  }
}
