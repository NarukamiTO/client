package alternativa.tanks.sfx.christmas {
  import alternativa.engine3d.core.MipMapping;
  import alternativa.engine3d.lights.OmniLight;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.*;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;

  public class ChristmasTreeToyEffect extends PooledObject implements GraphicEffect {
    private static const SIZE:Number = 256;
    private static const RESOLUTION:Number = 2;
    private static const RedTexture:Class = ChristmasTreeToyEffect_RedTexture;
    private static const redMaterial:TextureMaterial = new TextureMaterial(new RedTexture().bitmapData,false,true,MipMapping.PER_PIXEL,RESOLUTION);
    private static const GreenTexture:Class = ChristmasTreeToyEffect_GreenTexture;
    private static const greenMaterial:TextureMaterial = new TextureMaterial(new GreenTexture().bitmapData,false,true,MipMapping.PER_PIXEL,RESOLUTION);
    private static const BlueTexture:Class = ChristmasTreeToyEffect_BlueTexture;
    private static const blueMaterial:TextureMaterial = new TextureMaterial(new BlueTexture().bitmapData,false,true,MipMapping.PER_PIXEL,RESOLUTION);
    private static const OrangeTexture:Class = ChristmasTreeToyEffect_OrangeTexture;
    private static const orangeMaterial:TextureMaterial = new TextureMaterial(new OrangeTexture().bitmapData,false,true,MipMapping.PER_PIXEL,RESOLUTION);
    private static const NEAR_1:Number = 100;
    private static const NEAR_2:Number = 300;
    private static const FAR_1:Number = 500;
    private static const FAR_2:Number = 1000;
    private static const MIN_SCALE:Number = 0.3;
    private static const MAX_SCALE:Number = 1.3;
    private static const ROTATION_SPEED:Number = Math.PI / 2;
    private static const INTERVAL:Number = 3;

    private var sprite:Sprite3D;
    private var omni:OmniLight = new OmniLight(0,0,0);
    private var container:Scene3DContainer;
    private var positionProvider:Object3DPositionProvider;
    private var alive:Boolean;
    private var time:Number;

    public function ChristmasTreeToyEffect(param1:Pool) {
      super(param1);
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.sprite);
      if(Boolean(GPUCapabilities.gpuEnabled) && !GPUCapabilities.constrained) {
        param1.addChild(this.omni);
      }
    }

    public function init(param1:Sprite3D, param2:Object3DPositionProvider, param3:Vector3) : void {
      this.sprite = param1;
      this.positionProvider = param2;
      param1.width = SIZE;
      param1.height = SIZE;
      param1.originX = 0.5;
      param1.originY = 0.5;
      param1.softAttenuation = 50;
      param1.useLight = false;
      param1.useShadowMap = false;
      param1.shadowMapAlphaThreshold = 2;
      param1.depthMapAlphaThreshold = 2;
      param1.blendMode = BlendMode.ADD;
      if(param1.name.indexOf("1") >= 0) {
        param1.material = redMaterial;
        this.omni.color = 16727074;
      } else if(param1.name.indexOf("2") >= 0) {
        param1.material = greenMaterial;
        this.omni.color = 6356736;
      } else if(param1.name.indexOf("3") >= 0) {
        param1.material = blueMaterial;
        this.omni.color = 34047;
      } else if(param1.name.indexOf("4") >= 0) {
        param1.material = orangeMaterial;
        this.omni.color = 16771584;
      }
      this.omni.intensity = 0.7;
      this.omni.attenuationBegin = NEAR_2;
      this.omni.attenuationEnd = FAR_2;
      this.omni.calculateBounds();
      var local4:Number = 200;
      var local5:Number = param1.x - param3.x;
      var local6:Number = param1.y - param3.y;
      var local7:Number = Math.sqrt(local5 * local5 + local6 * local6);
      this.omni.x = param1.x + local5 * local4 / local7;
      this.omni.y = param1.y + local6 * local4 / local7;
      this.omni.z = param1.z + local4 / 2;
      this.time = Math.random() * INTERVAL;
      this.alive = true;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(!this.alive) {
        return false;
      }
      this.positionProvider.updateObjectPosition(this.sprite,param2,param1);
      var local3:Number = param1 / 1000;
      this.time += local3;
      this.time %= INTERVAL;
      var local4:Number = Math.sin(Math.PI * 2 * this.time / INTERVAL) * 0.5 + 0.5;
      var local5:Number = MIN_SCALE + (MAX_SCALE - MIN_SCALE) * local4;
      this.sprite.scaleX = local5;
      this.sprite.scaleY = local5;
      this.sprite.scaleZ = local5;
      this.sprite.rotation += ROTATION_SPEED * local3 * local4;
      this.omni.attenuationBegin = NEAR_1 + (NEAR_2 - NEAR_1) * local4;
      this.omni.attenuationEnd = FAR_1 + (FAR_2 - FAR_1) * local4;
      return true;
    }

    public function destroy() : void {
      this.container.removeChild(this.sprite);
      if(Boolean(GPUCapabilities.gpuEnabled) && !GPUCapabilities.constrained) {
        this.container.removeChild(this.omni);
      }
      this.sprite = null;
      this.container = null;
      this.positionProvider.destroy();
      this.positionProvider = null;
      recycle();
    }

    public function kill() : void {
      this.alive = false;
    }
  }
}
