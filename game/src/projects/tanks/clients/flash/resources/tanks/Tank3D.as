package projects.tanks.clients.flash.resources.tanks {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.materials.AnimatedPaintMaterial;
  import alternativa.tanks.materials.PaintMaterial;
  import flash.display.BitmapData;
  import flash.geom.ColorTransform;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class Tank3D extends Object3DContainer {
    private static var defaultColormap:BitmapData;

    public static const EXCLUDED:RegExp = /(box.*|fmnt.*|muzzle.*|laser|rocket)/i;
    public static const TANK_PART:String = "tankPart";

    private static const HULL_PART:int = 0;
    private static const TURRET_PART:int = 1;

    private var hullResource:Tanks3DSResource;
    private var turretResource:Tanks3DSResource;
    private var hull:Mesh;
    private var turret:MeshContainer;
    private var colormap:BitmapData;
    private var materials:Vector.<TextureMaterial> = new Vector.<TextureMaterial>(2);
    private var multiframeImageResource:MultiframeTextureResource;

    public function Tank3D() {
      super();
    }

    private static function getDefaultColorMap() : BitmapData {
      if(defaultColormap == null) {
        defaultColormap = new BitmapData(1,1,false,6710886);
      }
      return defaultColormap;
    }

    public static function cloneMesh(param1:Mesh) : Mesh {
      var local2:Mesh = Mesh(param1.clone());
      local2.name = TANK_PART;
      local2.colorTransform = new ColorTransform();
      local2.shadowMapAlphaThreshold = 0.1;
      local2.calculateVerticesNormalsBySmoothingGroups(0.01);
      return local2;
    }

    public function setColorMap(param1:BitmapData) : void {
      this.multiframeImageResource = null;
      this.destroyMaterials();
      this.colormap = param1 != null ? param1 : getDefaultColorMap();
      this.updateTurretTexture(this.turretResource,this.turret);
      this.updatePartTexture(this.hullResource,this.hull,HULL_PART);
    }

    public function setTextureAnimation(param1:MultiframeTextureResource) : void {
      this.colormap = null;
      this.destroyMaterials();
      this.multiframeImageResource = param1;
      this.updateTurretTexture(this.turretResource,this.turret);
      this.updatePartTexture(this.hullResource,this.hull,HULL_PART);
    }

    public function setHull(param1:Tanks3DSResource) : void {
      if(this.hull != null) {
        this.hull.setMaterialToAllFaces(null);
        removeChild(this.hull);
      }
      if(param1 == null) {
        return;
      }
      this.hullResource = param1;
      this.hull = this.initMesh(cloneMesh(param1.objects[0] as Mesh));
      addChild(this.hull);
      if(this.turret != null) {
        addChild(this.turret);
      }
      this.hull.x = 0;
      this.hull.y = 0;
      this.hull.z = 0;
      this.updatePartTexture(param1,this.hull,HULL_PART);
      this.updateMountPoint();
    }

    public function setTurret(param1:Tanks3DSResource) : void {
      var local2:Mesh = null;
      if(this.turret != null) {
        for each(local2 in this.turret.getMeshes()) {
          local2.setMaterialToAllFaces(null);
        }
        removeChild(this.turret);
      }
      if(param1 == null) {
        return;
      }
      this.turretResource = param1;
      this.turret = new MeshContainer();
      this.turret.setMeshes(this.getMeshes(param1));
      addChild(this.turret);
      this.updateTurretTexture(param1,this.turret);
      this.updateMountPoint();
    }

    private function getMeshes(param1:Tanks3DSResource) : Vector.<Mesh> {
      var local3:Object3D = null;
      var local2:Vector.<Mesh> = new Vector.<Mesh>();
      for each(local3 in param1.objects) {
        if(local3 is Mesh && !EXCLUDED.test(local3.name)) {
          local2.push(this.initMesh(cloneMesh(local3 as Mesh)));
        }
      }
      return local2;
    }

    private function updateTurretTexture(param1:Tanks3DSResource, param2:MeshContainer) : void {
      if(param2 == null) {
        return;
      }
      var local3:Vector.<Mesh> = param2.getMeshes();
      var local4:TextureMaterial = this.updatePartTexture(param1,local3[0],TURRET_PART);
      var local5:int = 1;
      while(local5 < local3.length) {
        local3[local5].setMaterialToAllFaces(local4);
        local5++;
      }
    }

    private function updatePartTexture(param1:Tanks3DSResource, param2:Mesh, param3:int) : TextureMaterial {
      var local4:TextureMaterial = null;
      if(param1 == null || param2 == null || this.colormap == null && this.multiframeImageResource == null) {
        return null;
      }
      if(this.multiframeImageResource != null) {
        local4 = this.createAnimatedTexture(param1,param3);
      } else {
        local4 = this.createTexture(param1,param3);
      }
      param2.setMaterialToAllFaces(local4);
      return local4;
    }

    private function createAnimatedTexture(param1:Tanks3DSResource, param2:int) : TextureMaterial {
      var local3:BitmapData = param1.textures["lightmap.jpg"];
      var local4:BitmapData = param1.textures["details.png"];
      var local5:int = this.multiframeImageResource.data.width / this.multiframeImageResource.frameWidth;
      var local6:int = this.multiframeImageResource.data.height / this.multiframeImageResource.frameHeight;
      var local7:AnimatedPaintMaterial = new AnimatedPaintMaterial(this.multiframeImageResource.data,local3,local4,local5,local6,this.multiframeImageResource.fps,this.multiframeImageResource.numFrames);
      if(this.materials[param2] != null) {
        this.materials[param2].dispose();
      }
      this.materials[param2] = local7;
      return local7;
    }

    private function createTexture(param1:Tanks3DSResource, param2:int) : TextureMaterial {
      var local3:BitmapData = param1.textures["lightmap.jpg"];
      var local4:BitmapData = param1.textures["details.png"];
      var local5:TextureMaterial = new PaintMaterial(this.colormap,local3,local4);
      if(this.materials[param2] != null) {
        this.materials[param2].dispose();
      }
      this.materials[param2] = local5;
      return local5;
    }

    private function updateMountPoint() : void {
      if(this.hull == null || this.turret == null) {
        return;
      }
      var local1:Object3D = this.hullResource.getObjectsByName(/mount/i)[0];
      this.turret.x = local1.x;
      this.turret.y = local1.y;
      this.turret.z = local1.z;
    }

    public function getMountPointX() : Number {
      return this.turret == null ? 0 : Number(this.turret.x);
    }

    public function getMountPointY() : Number {
      return this.turret == null ? 0 : Number(this.turret.y);
    }

    public function getMountPointZ() : Number {
      return this.turret == null ? 0 : Number(this.turret.z);
    }

    public function destroy() : void {
      this.destroyMaterials();
      this.materials = null;
      this.multiframeImageResource = null;
      this.hull = null;
      this.turret = null;
      this.colormap = null;
      this.hullResource = null;
      this.turretResource = null;
    }

    private function destroyMaterials() : void {
      if(this.materials[HULL_PART] != null) {
        this.materials[HULL_PART].dispose();
        this.materials[HULL_PART] = null;
      }
      if(this.materials[TURRET_PART] != null) {
        this.materials[TURRET_PART].dispose();
        this.materials[TURRET_PART] = null;
      }
    }

    protected function initMesh(param1:Mesh) : Mesh {
      if(param1.sorting != Sorting.DYNAMIC_BSP) {
        param1.sorting = Sorting.DYNAMIC_BSP;
        param1.calculateFacesNormals(true);
        param1.optimizeForDynamicBSP();
        param1.threshold = 0.01;
      }
      return param1;
    }
  }
}
