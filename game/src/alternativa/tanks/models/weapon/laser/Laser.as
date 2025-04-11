package alternativa.tanks.models.weapon.laser {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.utils.Colorizer;
  import flash.display.BitmapData;
  import flash.display.BlendMode;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.AutoClosable;

  public final class Laser extends Mesh implements AutoClosable {
    private static const EmbedLaserRay:Class = Laser_EmbedLaserRay;
    private static const EmbedLaserRayBegin:Class = Laser_EmbedLaserRayBegin;
    private static const RAY_TEXTURE:BitmapData = new EmbedLaserRay().bitmapData;
    private static const RAY_TEXTURE_BEGIN:BitmapData = new EmbedLaserRayBegin().bitmapData;
    private static const FADE:Number = 100;
    private static const WIDTH:Number = 10;
    private static const TEX_SCALE:Number = 5;
    private static const SPEED:Number = 0.5;
    private static const SPEED_2:Number = 0.75;
    private static const DELTA:Number = 300;
    private static const colorizedRayTextures:Dictionary = new Dictionary();
    private static const colorizedRayBeginTextures:Dictionary = new Dictionary();

    private var material:TextureMaterial;
    private var a1:Vertex;
    private var b1:Vertex;
    private var c1:Vertex;
    private var d1:Vertex;
    private var e1:Vertex;
    private var f1:Vertex;
    private var g1:Vertex;
    private var h1:Vertex;
    private var rayFace1:Face;
    private var rayBeginFace1:Face;
    private var a2:Vertex;
    private var b2:Vertex;
    private var c2:Vertex;
    private var d2:Vertex;
    private var e2:Vertex;
    private var f2:Vertex;
    private var g2:Vertex;
    private var h2:Vertex;
    private var rayFace2:Face;
    private var rayBeginFace2:Face;
    private var segment:Number;
    private var angle:Number;
    private var angle2:Number;
    private var color:uint;

    public function Laser() {
      super();
      this.a1 = addVertex(-1,1,0);
      this.b1 = addVertex(-1,0,0);
      this.c1 = addVertex(1,0,0);
      this.d1 = addVertex(1,1,0);
      this.e1 = addVertex(-1,1,0);
      this.f1 = addVertex(-1,0,0);
      this.g1 = addVertex(1,0,0);
      this.h1 = addVertex(1,1,0);
      this.rayFace1 = addQuadFace(this.a1,this.b1,this.c1,this.d1);
      this.rayBeginFace1 = addQuadFace(this.e1,this.f1,this.g1,this.h1);
      this.a2 = addVertex(-1,1,0);
      this.b2 = addVertex(-1,0,0);
      this.c2 = addVertex(1,0,0);
      this.d2 = addVertex(1,1,0);
      this.e2 = addVertex(-1,1,0);
      this.f2 = addVertex(-1,0,0);
      this.g2 = addVertex(1,0,0);
      this.h2 = addVertex(1,1,0);
      this.rayFace2 = addQuadFace(this.a2,this.b2,this.c2,this.d2);
      this.rayBeginFace2 = addQuadFace(this.e2,this.f2,this.g2,this.h2);
      calculateFacesNormals();
      useLight = false;
      useShadowMap = false;
      sorting = Sorting.DYNAMIC_BSP;
      shadowMapAlphaThreshold = 2;
      depthMapAlphaThreshold = 2;
      blendMode = BlendMode.ADD;
    }

    public function init(param1:int) : void {
      this.color = param1;
      this.material = Colorizer.getColorizedMaterial(colorizedRayTextures,param1,RAY_TEXTURE);
      this.rayFace1.material = this.material;
      this.rayFace2.material = this.material;
      var local2:TextureMaterial = Colorizer.getColorizedMaterial(colorizedRayBeginTextures,param1,RAY_TEXTURE_BEGIN,false);
      this.rayBeginFace1.material = local2;
      this.rayBeginFace2.material = local2;
      var local3:Number = WIDTH * 0.5;
      this.a1.x = -local3;
      this.a1.u = 0;
      this.b1.x = -local3;
      this.b1.u = 0;
      this.c1.x = local3;
      this.c1.u = 1;
      this.d1.x = local3;
      this.d1.u = 1;
      this.e1.x = -local3;
      this.e1.u = 0;
      this.e1.v = 0;
      this.f1.x = -local3;
      this.f1.u = 0;
      this.f1.v = 1;
      this.g1.x = local3;
      this.g1.u = 1;
      this.g1.v = 1;
      this.h1.x = local3;
      this.h1.u = 1;
      this.h1.v = 0;
      this.a2.x = -local3;
      this.a2.u = 0;
      this.b2.x = -local3;
      this.b2.u = 0;
      this.c2.x = local3;
      this.c2.u = 1;
      this.d2.x = local3;
      this.d2.u = 1;
      this.e2.x = -local3;
      this.e2.u = 0;
      this.e2.v = 0;
      this.f2.x = -local3;
      this.f2.u = 0;
      this.f2.v = 1;
      this.g2.x = local3;
      this.g2.u = 1;
      this.g2.v = 1;
      this.h2.x = local3;
      this.h2.u = 1;
      this.h2.v = 0;
      this.segment = TEX_SCALE * WIDTH * this.material.texture.height / this.material.texture.width;
      this.angle = 0;
      this.angle2 = 0;
    }

    public function update(param1:int, param2:Number) : void {
      var local3:Number = param1 / 1000;
      this.a1.y = param2;
      this.b1.y = FADE;
      this.c1.y = FADE;
      this.d1.y = param2;
      this.e1.y = FADE;
      this.f1.y = 0;
      this.g1.y = 0;
      this.h1.y = FADE;
      this.a2.y = param2;
      this.b2.y = FADE;
      this.c2.y = FADE;
      this.d2.y = param2;
      this.e2.y = FADE;
      this.f2.y = 0;
      this.g2.y = 0;
      this.h2.y = FADE;
      this.angle += SPEED * local3;
      this.angle2 += SPEED_2 * local3;
      var local4:Number = Math.sin(this.angle) * DELTA;
      var local5:Number = Math.sin(this.angle2) * DELTA;
      this.a1.v = (-this.a1.y + local4) / this.segment;
      this.b1.v = (-this.b1.y + local4) / this.segment;
      this.c1.v = (-this.c1.y + local4) / this.segment;
      this.d1.v = (-this.d1.y + local4) / this.segment;
      this.a2.v = (-this.a2.y + local5) / this.segment;
      this.b2.v = (-this.b2.y + local5) / this.segment;
      this.c2.v = (-this.c2.y + local5) / this.segment;
      this.d2.v = (-this.d2.y + local5) / this.segment;
      var local6:Number = Number(this.material.texture.width);
      var local7:Number = Number(this.material.texture.height);
      var local8:Number = local6 / 2;
      var local9:Number = this.b1.v * local7 % local7;
      if(local9 < 0) {
        local9 = local7 + local9;
      }
      var local10:Number = (RAY_TEXTURE.getPixel(local8,local9) >> 16 & 0xFF) / 255;
      this.e1.v = 1 - local10;
      this.h1.v = 1 - local10;
      local9 = this.b2.v * local7 % local7;
      if(local9 < 0) {
        local9 = local7 + local9;
      }
      local10 = (RAY_TEXTURE.getPixel(local8,local9) >> 16 & 0xFF) / 255;
      this.e2.v = 1 - local10;
      this.h2.v = 1 - local10;
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      if(this.color in colorizedRayTextures) {
        delete colorizedRayTextures[this.color];
      }
      if(this.color in colorizedRayBeginTextures) {
        delete colorizedRayBeginTextures[this.color];
      }
      this.material = null;
      this.rayFace1.material = null;
      this.rayFace2.material = null;
      this.rayBeginFace1.material = null;
      this.rayBeginFace2.material = null;
    }
  }
}
