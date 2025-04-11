package alternativa.tanks.models.weapon.healing {
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;

  internal class HealingGunShaft extends Mesh {
    private var verts:Vector.<Vertex>;
    private var vertsLen:int = 0;
    private var direction:int = 1;
    private var width:Number;
    private var segment:Number = 1;
    private var offset:Number = 0;
    private var wave1Offset:Number = 0;
    private var wave2Offset:Number = 0;

    public function HealingGunShaft() {
      var local4:Vertex = null;
      var local5:Vertex = null;
      this.verts = new Vector.<Vertex>();
      super();
      var local1:Vertex = addVertex(-1,0,0);
      var local2:Vertex = addVertex(1,0,0);
      this.verts[this.vertsLen] = local1;
      ++this.vertsLen;
      this.verts[this.vertsLen] = local2;
      ++this.vertsLen;
      var local3:int = 0;
      while(local3 < HealingGunEffectsParams.SHAFT_NUM_SEGMENTS) {
        local4 = addVertex(-1,-local3 - 1,0);
        local5 = addVertex(1,-local3 - 1,0);
        this.verts[this.vertsLen] = local4;
        ++this.vertsLen;
        this.verts[this.vertsLen] = local5;
        ++this.vertsLen;
        addQuadFace(local1,local4,local5,local2);
        local1 = local4;
        local2 = local5;
        local3++;
      }
      calculateFacesNormals();
      sorting = Sorting.DYNAMIC_BSP;
      shadowMapAlphaThreshold = 2;
      depthMapAlphaThreshold = 2;
      useShadowMap = false;
      useLight = false;
    }

    public function init(param1:Number, param2:Number) : void {
      var local5:Vertex = null;
      var local6:Vertex = null;
      this.width = param1;
      var local3:Number = param1 * 0.5;
      var local4:int = 0;
      while(local4 < this.vertsLen) {
        local5 = this.verts[local4];
        local4++;
        local6 = this.verts[local4];
        local5.x = -local3;
        local5.u = 0;
        local6.x = local3;
        local6.u = 1;
        local4++;
      }
      boundMinX = -local3;
      boundMaxX = local3;
      boundMinY = 0;
      boundMinZ = 0;
      boundMaxZ = 0;
    }

    public function setMaterial(param1:Material, param2:int) : void {
      this.direction = param2;
      setMaterialToAllFaces(param1);
      var local3:TextureMaterial = param1 as TextureMaterial;
      if(local3 != null && local3.texture != null) {
        this.segment = this.width * local3.texture.height / local3.texture.width;
      } else {
        this.segment = this.width;
      }
      this.offset = 0;
      this.wave1Offset = 0;
      this.wave2Offset = 0;
    }

    public function update(param1:int, param2:Number) : void {
      var local11:Vertex = null;
      var local12:Vertex = null;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local3:Number = HealingGunEffectsParams.SHAFT_WAVE_AMPLITUDE / this.width;
      var local4:Number = this.direction * HealingGunEffectsParams.SHAFT_WAVE1_SPEED;
      var local5:Number = this.direction * HealingGunEffectsParams.SHAFT_WAVE2_SPEED;
      var local6:Number = this.direction * HealingGunEffectsParams.SHAFT_STREAM_SPEED / this.segment;
      this.wave1Offset += local4 * param1 / 1000;
      this.wave2Offset += local5 * param1 / 1000;
      this.offset += local6 * param1 / 1000;
      var local7:Number = param2 / HealingGunEffectsParams.SHAFT_NUM_SEGMENTS;
      var local8:Number = param2 / 2;
      var local9:Number = 1;
      var local10:int = 0;
      while(local10 < this.vertsLen) {
        local11 = this.verts[local10];
        local10++;
        local12 = this.verts[local10];
        local11.y = param2 - (local10 >> 1) * local7;
        local12.y = local11.y;
        local13 = local8 - local11.y;
        local11.v = local13 / this.segment + this.offset;
        local12.v = local11.v;
        if(local11.y < local8) {
          local9 = local11.y / HealingGunEffectsParams.SHAFT_AMPLITUDE_FADE;
        } else {
          local9 = (param2 - local11.y) / HealingGunEffectsParams.SHAFT_AMPLITUDE_FADE;
        }
        if(local9 > 1) {
          local9 = 1;
        }
        local14 = Math.sin(Math.PI * 2 * (local13 + this.wave1Offset) / HealingGunEffectsParams.SHAFT_WAVE1_LENGTH);
        local15 = Math.sin(Math.PI * 2 * (local13 + this.wave2Offset) / HealingGunEffectsParams.SHAFT_WAVE2_LENGTH);
        local11.u = (local14 + local15) * 0.5 * local3 * local9;
        local12.u = 1 + local11.u;
        local10++;
      }
      boundMaxY = param2;
    }

    public function clear() : void {
      setMaterialToAllFaces(null);
    }
  }
}
