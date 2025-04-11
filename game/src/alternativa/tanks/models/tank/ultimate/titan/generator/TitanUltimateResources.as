package alternativa.tanks.models.tank.ultimate.titan.generator {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.engine3d.UVFrame;
  import alternativa.tanks.utils.GraphicsUtils;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BitmapData;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.client.battlefield.models.ultimate.effects.titan.generator.TitanUltimateGeneratorCC;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class TitanUltimateResources {
    private static const BLUE_SPHERE_ROTATION_ANGLE:Number = Math.PI / 6;
    private static const RED_SPHERE_ROTATION_ANGLE:Number = -Math.PI / 6;

    private var _sphere:TextureAnimation;
    private var _rayMaterial:TextureMaterial;
    private var _rayTipMaterial:TextureMaterial;
    private var _cellTexture:TextureMaterial;
    private var _geosphere:Mesh;
    private var _sphereRotationAngle:Number;

    public function TitanUltimateResources(param1:TitanUltimateGeneratorCC, param2:TextureMaterialRegistry) {
      super();
      if(param1.generatorTeam == BattleTeam.BLUE) {
        this.fillData(param1.blueSphere,param1.blueRay.data,param1.blueRayTip.data,param1.blueCell.data,param2,BLUE_SPHERE_ROTATION_ANGLE);
      } else if(param1.generatorTeam == BattleTeam.RED) {
        this.fillData(param1.redSphere,param1.redRay.data,param1.redRayTip.data,param1.redCell.data,param2,RED_SPHERE_ROTATION_ANGLE);
      } else {
        this.fillData(param1.sphere,param1.ray.data,param1.rayTip.data,param1.cell.data,param2,0);
      }
      this._geosphere = Mesh(param1.geosphere.objects[0]);
    }

    private static function createUVFrame(param1:TextureMaterial, param2:MultiframeTextureResource) : Vector.<UVFrame> {
      return GraphicsUtils.getUVFramesFromTexture(param1.texture,param2.frameWidth,param2.frameHeight,param2.numFrames);
    }

    private function fillData(param1:MultiframeTextureResource, param2:BitmapData, param3:BitmapData, param4:BitmapData, param5:TextureMaterialRegistry, param6:Number) : void {
      this._rayMaterial = param5.getMaterial(param2);
      this._rayMaterial.repeat = true;
      this._rayTipMaterial = param5.getMaterial(param3);
      var local7:TextureMaterial = param5.getMaterial(param1.data);
      var local8:Vector.<UVFrame> = createUVFrame(local7,param1);
      this._sphere = new TextureAnimation(local7,local8,param1.fps);
      this._cellTexture = param5.getMaterial(param4);
      this._sphereRotationAngle = param6;
    }

    public function get geosphere() : Mesh {
      return this._geosphere;
    }

    public function get sphere() : TextureAnimation {
      return this._sphere;
    }

    public function get rayMaterial() : TextureMaterial {
      return this._rayMaterial;
    }

    public function get rayTipMaterial() : TextureMaterial {
      return this._rayTipMaterial;
    }

    public function get cellTexture() : TextureMaterial {
      return this._cellTexture;
    }

    public function get sphereRotationAngle() : Number {
      return this._sphereRotationAngle;
    }
  }
}
