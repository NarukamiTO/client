package projects.tanks.clients.flash.resources.drone {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.tanks.materials.AnimatedPaintMaterial;
  import alternativa.tanks.materials.PaintMaterial;
  import flash.display.BitmapData;
  import flash.geom.Vector3D;
  import flash.utils.getTimer;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
  import projects.tanks.clients.flash.resources.tanks.Tank3D;

  public class Drone3D extends Object3DContainer {
    private static const DETAILS:String = "details.png";
    private static const LIGHTMAP:String = "lightmap.jpg";
    private static const NO_BATTERY_SPRITE_SIZE:Number = 30;
    private static const noBatteriesTexture:Class = Drone3D_noBatteriesTexture;
    private static const noBatteriesBitmapData:BitmapData = new noBatteriesTexture().bitmapData;

    private var drone3DResource:Tanks3DSResource;
    private var drone:Mesh;
    private var colorData:BitmapData;
    private var multiframe:MultiframeTextureResource;
    private var material:TextureMaterial;
    private var tank:Tank3D;
    private var camera:Camera3D;
    private var noBatteriesSprite:Sprite3D;
    private var changedTime:int;
    private var hasBatteriesFunction:Function;
    private var prevTarget:Vector3D = new Vector3D();
    private var basePosition:Vector3D;

    public function Drone3D(param1:Tank3D, param2:Camera3D, param3:Vector3D, param4:Function) {
      super();
      this.tank = param1;
      this.camera = param2;
      this.hasBatteriesFunction = param4;
      this.basePosition = param3.clone();
      this.initNoBatteriesSprite();
    }

    private function initNoBatteriesSprite() : void {
      var local1:TextureMaterial = new TextureMaterial(noBatteriesBitmapData);
      this.noBatteriesSprite = new Sprite3D(NO_BATTERY_SPRITE_SIZE,NO_BATTERY_SPRITE_SIZE,local1);
      addChild(this.noBatteriesSprite);
    }

    public function render() : void {
      if(this.drone != null) {
        this.updateDronePosition();
        this.updateNoBatteriesSpritePosition();
      }
      this.noBatteriesSprite.visible = this.drone != null && !this.hasBatteriesFunction();
    }

    private function updateDronePosition() : void {
      var local2:Number = NaN;
      var local1:int = getTimer() - this.changedTime;
      if(local1 > 500) {
        x = this.getTargetX();
        y = this.getTargetY();
        z = this.getTargetZ();
      } else {
        local2 = Math.atan((local1 / 500 - 0.5) * Math.PI) / 2 + 0.5;
        x = this.prevTarget.x + (this.getTargetX() - this.prevTarget.x) * local2;
        y = this.prevTarget.y + (this.getTargetY() - this.prevTarget.y) * local2;
        z = this.prevTarget.z + (this.getTargetZ() - this.prevTarget.z) * local2;
      }
    }

    private function updateNoBatteriesSpritePosition() : void {
      var local1:Vector3D = this.camera.localToGlobal(new Vector3D(this.camera.x,this.camera.y,this.camera.z));
      var local2:Vector3D = this.drone.localToGlobal(new Vector3D(x,y,z));
      var local3:Vector3D = local1.subtract(local2);
      this.noBatteriesSprite.x = local3.x / 10;
      this.noBatteriesSprite.y = local3.y / 10;
      this.noBatteriesSprite.z = local3.z / 10 + 10;
      this.noBatteriesSprite.alpha = (Math.sin(getTimer() / 300) + 1) / 2;
    }

    private function getTargetX() : Number {
      return this.tank.getMountPointX() + this.basePosition.x;
    }

    private function getTargetY() : Number {
      return this.tank.getMountPointY() + this.basePosition.y;
    }

    private function getTargetZ() : Number {
      return this.tank.getMountPointZ() + this.basePosition.z + Math.sin(getTimer() / 1000) * 10;
    }

    public function onHullChanged() : void {
      this.changedTime = getTimer();
      if(this.drone != null) {
        this.prevTarget.x = x;
        this.prevTarget.y = y;
        this.prevTarget.z = z;
      }
    }

    public function setColorMap(param1:BitmapData) : void {
      this.multiframe = null;
      this.colorData = param1;
      this.updateMaterial();
    }

    public function setTextureAnimation(param1:MultiframeTextureResource) : void {
      this.colorData = null;
      this.multiframe = param1;
      this.updateMaterial();
    }

    public function set3DResource(param1:Tanks3DSResource) : void {
      this.destroyMesh();
      this.drone3DResource = param1;
      this.updateMesh();
    }

    public function destroy() : void {
      this.destroyMaterial();
      this.noBatteriesSprite = null;
      this.drone3DResource = null;
      this.multiframe = null;
      this.colorData = null;
      this.drone = null;
      this.tank = null;
    }

    private function destroyMesh() : void {
      if(this.drone != null) {
        this.drone.setMaterialToAllFaces(null);
        if(contains(this.drone)) {
          removeChild(this.drone);
        }
      }
      this.drone = null;
      this.drone3DResource = null;
    }

    private function updateMesh() : void {
      if(this.drone3DResource != null) {
        this.drone = this.drone3DResource.objects[0].clone() as Mesh;
        x = this.getTargetX();
        y = this.getTargetY();
        z = this.getTargetZ();
        this.updateMaterial();
        addChild(this.drone);
      }
    }

    private function updateMaterial() : void {
      if(this.drone3DResource != null) {
        this.material = this.multiframe != null ? this.createAnimatedTexture() : this.createTexture();
        this.drone.setMaterialToAllFaces(this.material);
      }
    }

    private function getColorMap() : BitmapData {
      if(this.colorData == null) {
        this.colorData = new BitmapData(1,1,false,6710886);
      }
      return this.colorData;
    }

    private function destroyMaterial() : void {
      if(this.material != null) {
        this.material.dispose();
        this.material = null;
      }
    }

    private function createTexture() : PaintMaterial {
      this.destroyMaterial();
      return new PaintMaterial(this.getColorMap(),this.getLightMap(),this.getDetails());
    }

    private function createAnimatedTexture() : PaintMaterial {
      this.destroyMaterial();
      return new AnimatedPaintMaterial(this.multiframe.data,this.getLightMap(),this.getDetails(),this.getFramesNumX(),this.getFramesNumY(),this.multiframe.fps,this.multiframe.numFrames);
    }

    private function getFramesNumX() : Number {
      return this.multiframe.data.width / this.multiframe.frameWidth;
    }

    private function getFramesNumY() : Number {
      return this.multiframe.data.height / this.multiframe.frameHeight;
    }

    private function getDetails() : BitmapData {
      return this.drone3DResource.textures[DETAILS];
    }

    private function getLightMap() : BitmapData {
      return this.drone3DResource.textures[LIGHTMAP];
    }
  }
}
