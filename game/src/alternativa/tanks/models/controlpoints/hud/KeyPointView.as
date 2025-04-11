package alternativa.tanks.models.controlpoints.hud {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.lights.OmniLight;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.BSP;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.models.teamlight.ModeLight;
  import alternativa.tanks.models.teamlight.TeamLightColor;
  import alternativa.tanks.services.colortransform.ColorTransformService;
  import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BitmapData;
  import flash.display.BitmapDataChannel;
  import flash.display.BlendMode;
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import projects.tanks.client.battlefield.models.battle.cp.resources.DominationResources;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class KeyPointView {
    [Inject]
    public static var colorTransformService:ColorTransformService;

    [Inject]
    public static var materialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var lightingEffectsService:ILightingEffectsService;

    public static const CIRCLE_SIZE:Number = 1000;
    public static const CIRCLE_ASCENSION:Number = 350;

    private static const MAX_PROGRESS:Number = 100;
    private static const CURVE:Number = 1.5;

    private var pedestal:BSP;
    private var currentPedestalMaterial:TextureMaterial;
    private var redTextureMaterial:TextureMaterial;
    private var blueTextureMaterial:TextureMaterial;
    private var neutralTextureMaterial:TextureMaterial;
    private var plane:ProgressPlane;
    private var lightSource:OmniLight;
    private var redTeamColor:TeamLightColor;
    private var blueTeamColor:TeamLightColor;
    private var neutralTeamColor:TeamLightColor;

    public function KeyPointView(param1:String, param2:BattleScene3D, param3:DominationResources) {
      super();
      this.pedestal = createPedestal(param3.pedestal);
      this.blueTextureMaterial = materialRegistry.getMaterial(param3.bluePedestalTexture.data);
      this.redTextureMaterial = materialRegistry.getMaterial(param3.redPedestalTexture.data);
      this.neutralTextureMaterial = materialRegistry.getMaterial(param3.neutralPedestalTexture.data);
      var local4:ModeLight = lightingEffectsService.getLightForMode(BattleMode.CP);
      this.redTeamColor = local4.getLightForTeam(BattleTeam.RED);
      this.blueTeamColor = local4.getLightForTeam(BattleTeam.BLUE);
      this.neutralTeamColor = local4.getLightForTeam(BattleTeam.NONE);
      this.createIndicator(param1,param3);
      this.createLightSource(local4);
      param2.addObjectToExclusion(this.plane);
      param2.addObjectToExclusion(this.pedestal);
    }

    private static function createPedestal(param1:Tanks3DSResource) : BSP {
      var local2:Mesh = Mesh(param1.objects[0]);
      var local3:BSP = new BSP();
      local3.createTree(local2);
      return local3;
    }

    private static function getCircleMaterial(param1:BitmapData) : TextureMaterial {
      var local2:TextureMaterial = materialRegistry.getMaterial(param1,false);
      local2.resolution = CIRCLE_SIZE / param1.width;
      return local2;
    }

    private static function createMatrix(param1:BitmapData, param2:BitmapData, param3:int) : Matrix {
      var local4:int = param2.height;
      var local5:Matrix = new Matrix();
      local5.tx = (param1.height - local4) / 2 - local4 * param3;
      local5.ty = (param1.height - local4) / 2;
      return local5;
    }

    private static function createRectangle(param1:BitmapData, param2:BitmapData) : Rectangle {
      var local3:int = param2.height;
      var local4:Number = (param1.height - local3) / 2;
      return new Rectangle(local4,local4,local3,local3);
    }

    private static function createFillingTexture(param1:BitmapData, param2:BitmapData) : BitmapData {
      var local3:BitmapData = param1.clone();
      local3.copyChannel(param2,param2.rect,new Point(),BitmapDataChannel.ALPHA,BitmapDataChannel.ALPHA);
      return local3;
    }

    private static function lerpNumber(param1:Number, param2:Number, param3:Number) : Number {
      return param1 + (param2 - param1) * param3;
    }

    private static function lerpColor(param1:uint, param2:uint, param3:Number) : uint {
      var local4:Number = (param1 >> 16 & 0xFF) / 255;
      var local5:Number = (param1 >> 8 & 0xFF) / 255;
      var local6:Number = (param1 & 0xFF) / 255;
      var local7:Number = (param2 >> 16 & 0xFF) / 255;
      var local8:Number = (param2 >> 8 & 0xFF) / 255;
      var local9:Number = (param2 & 0xFF) / 255;
      var local10:int = lerpNumber(local4,local7,param3) * 255;
      var local11:int = lerpNumber(local5,local8,param3) * 255;
      var local12:int = lerpNumber(local6,local9,param3) * 255;
      return local10 << 16 | local11 << 8 | local12;
    }

    private function createLightSource(param1:ModeLight) : void {
      this.lightSource = new OmniLight(0,param1.getAttenuationBegin(),param1.getAttenuationEnd());
      this.setLightColor(this.neutralTeamColor);
    }

    private function createIndicator(param1:String, param2:DominationResources) : void {
      var local3:BitmapData = param2.neutralCircle.data.clone();
      var local4:BitmapData = param2.blueCircle.data.clone();
      var local5:BitmapData = param2.redCircle.data.clone();
      var local6:BitmapData = param2.bigLetters.data;
      var local7:int = param1.charCodeAt(0) - "A".charCodeAt(0);
      var local8:Rectangle = createRectangle(local3,local6);
      var local9:Matrix = createMatrix(local3,local6,local7);
      local3.draw(local6,local9,null,BlendMode.NORMAL,local8,true);
      local4.draw(local6,local9,null,BlendMode.NORMAL,local8,true);
      local5.draw(local6,local9,null,BlendMode.NORMAL,local8,true);
      var local10:BitmapData = createFillingTexture(local4,local3);
      var local11:BitmapData = createFillingTexture(local5,local3);
      var local12:TextureMaterial = getCircleMaterial(local3);
      var local13:TextureMaterial = getCircleMaterial(local4);
      var local14:TextureMaterial = getCircleMaterial(local10);
      var local15:TextureMaterial = getCircleMaterial(local5);
      var local16:TextureMaterial = getCircleMaterial(local11);
      this.plane = new ProgressPlane(CIRCLE_SIZE,CIRCLE_SIZE,local12,local14,local13,local16,local15);
    }

    public function update(param1:Number, param2:Camera3D) : void {
      this.plane.setProgress(param1);
      this.plane.updateRotation(param2);
      this.updateTeamColor(param1 / MAX_PROGRESS);
    }

    public function addToScene(param1:BattleScene3D, param2:Vector3) : void {
      this.pedestal.x = param2.x;
      this.pedestal.y = param2.y;
      this.pedestal.z = param2.z;
      param1.addObject(this.pedestal);
      this.plane.x = param2.x;
      this.plane.y = param2.y;
      this.plane.z = param2.z + CIRCLE_ASCENSION;
      param1.addObject(this.plane);
      this.lightSource.x = param2.x;
      this.lightSource.y = param2.y;
      this.lightSource.z = param2.z + CIRCLE_ASCENSION;
      param1.addObject(this.lightSource);
    }

    public function becomeRed() : void {
      this.setPedestalMaterial(this.redTextureMaterial);
      this.setLightColor(this.redTeamColor);
    }

    public function becomeBlue() : void {
      this.setPedestalMaterial(this.blueTextureMaterial);
      this.setLightColor(this.blueTeamColor);
    }

    public function becomeNeutral() : void {
      this.setPedestalMaterial(this.neutralTextureMaterial);
      this.setLightColor(this.neutralTeamColor);
    }

    private function setPedestalMaterial(param1:TextureMaterial) : void {
      if(this.currentPedestalMaterial != param1) {
        this.currentPedestalMaterial = param1;
        this.pedestal.setMaterialToAllFaces(param1);
      }
    }

    private function setLightColor(param1:TeamLightColor) : void {
      this.lightSource.color = param1.getColor();
      this.lightSource.intensity = param1.getIntensity();
    }

    private function updateTeamColor(param1:Number) : void {
      var local2:uint = param1 < 0 ? this.redTeamColor.getColor() : this.blueTeamColor.getColor();
      var local3:Number = param1 < 0 ? this.redTeamColor.getIntensity() : this.blueTeamColor.getIntensity();
      this.lightSource.color = lerpColor(this.neutralTeamColor.getColor(),local2,Math.pow(Math.abs(param1),CURVE));
      this.lightSource.intensity = lerpNumber(this.neutralTeamColor.getIntensity(),local3,Math.pow(Math.abs(param1),CURVE));
    }
  }
}
