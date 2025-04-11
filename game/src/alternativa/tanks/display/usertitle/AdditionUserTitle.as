package alternativa.tanks.display.usertitle {
  import alternativa.engine3d.core.Clipping;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.tanks.model.garage.resistance.ResistancesIcons;
  import alternativa.tanks.models.battle.battlefield.keyboard.DeviceIcons;
  import alternativa.tanks.models.tank.device.TankDevice;
  import alternativa.tanks.models.tank.gearscore.GearScoreInfo;
  import alternativa.tanks.models.tank.resistance.TankResistances;
  import controls.Label;
  import filters.Filters;
  import flash.display.BitmapData;
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.text.GridFitType;
  import flash.text.TextFieldAutoSize;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.resistance.TankResistance;

  public class AdditionUserTitle extends Sprite3D {
    private static var tankPartInfoWidth:Number;
    private static var titleHeight:Number;

    private static const matrix:Matrix = new Matrix();
    private static const label:Label = new Label();
    private static const ZERO:Point = new Point();

    label.autoSize = TextFieldAutoSize.LEFT;
    label.thickness = 200;
    label.gridFitType = GridFitType.PIXEL;

    private var texture:BitmapData = new BitmapData(256,180,true,0);

    public function AdditionUserTitle() {
      var local1:TextureMaterial = new TextureMaterial(this.texture);
      local1.uploadEveryFrame = true;
      super(256,180,local1);
      perspectiveScale = false;
      alpha = 1;
      visible = true;
      useShadowMap = false;
      useLight = false;
      originY = 1;
      clipping = Clipping.FACE_CULLING;
      sorting = Sorting.AVERAGE_Z;
    }

    public static function createTexture(param1:String, param2:Vector.<TankResistance>, param3:TankDevice) : BitmapData {
      tankPartInfoWidth = 0;
      var local4:BitmapData = new BitmapData(256,180,true,0);
      var local5:int = 2;
      var local6:int = 42;
      var local7:BitmapData = DeviceIcons.getByDeviceId(param3.getDevice());
      if(local7 != null) {
        drawDevice(local6,param2.length == 0 ? local5 + 37 : local5,local7,local4);
      }
      local5 += DeviceIcons.backgroundIcon.height;
      if(param2.length != 0) {
        drawResistances(local6,local5,param2,local4);
      }
      local5 += 40;
      drawInfo(local6,local5,param1,local4);
      local5 += 15;
      titleHeight = local5;
      local4.applyFilter(local4,local4.rect,ZERO,Filters.SHADOW_FILTER);
      return local4;
    }

    private static function drawInfo(param1:int, param2:int, param3:String, param4:BitmapData) : void {
      label.text = param3;
      matrix.tx = param1 + 25;
      matrix.ty = param2;
      param4.draw(label,matrix,null,null,null,true);
      matrix.tx += label.width + 10;
      tankPartInfoWidth = Math.max(tankPartInfoWidth,matrix.tx + label.width + 2);
    }

    private static function drawResistances(param1:int, param2:int, param3:Vector.<TankResistance>, param4:BitmapData) : void {
      var local5:TankResistance = null;
      var local6:BitmapData = null;
      var local7:BitmapData = null;
      var local8:Number = NaN;
      var local9:Label = null;
      var local10:Number = NaN;
      matrix.tx = param1 + ((3 - param3.length) * ResistancesIcons.resistanceIcon.width >> 1);
      matrix.ty = param2;
      for each(local5 in param3) {
        local6 = ResistancesIcons.resistanceIcon;
        param4.draw(local6,matrix,null,null,null,true);
        local7 = ResistancesIcons.getBitmapDataByName(local5.resistanceProperty.name);
        local8 = local6.height - local7.height >> 1;
        matrix.tx += local6.width - local7.width >> 1;
        matrix.ty += local8;
        param4.draw(local7,matrix,null,null,null,true);
        local9 = new Label();
        local9.text = local5.resistanceInPercent == 100 ? "??" : local5.resistanceInPercent.toString() + "%";
        matrix.ty += local6.height - 3;
        local10 = local6.width - local9.textWidth + 2 >> 1;
        matrix.tx += local10;
        param4.draw(local9,matrix,null,null,null,true);
        matrix.tx += local6.width + 3 - local10;
        matrix.ty -= local8 + local6.height - 3;
      }
    }

    private static function drawDevice(param1:int, param2:int, param3:BitmapData, param4:BitmapData) : void {
      matrix.tx = param1 + (DeviceIcons.backgroundIcon.width >> 1);
      matrix.ty = param2;
      param4.draw(DeviceIcons.backgroundIcon,matrix,null,null,null,true);
      matrix.tx += DeviceIcons.backgroundIcon.width - param3.width >> 1;
      matrix.ty += DeviceIcons.backgroundIcon.height - param3.height >> 1;
      param4.draw(param3,matrix,null,null,null,true);
    }

    public function updateTexture(param1:uint, param2:IGameObject, param3:int) : void {
      var local4:GearScoreInfo = GearScoreInfo(param2.adapt(GearScoreInfo));
      var local5:String = "GS: " + local4.getScore();
      var local6:TankResistances = TankResistances(param2.adapt(TankResistances));
      var local7:Vector.<TankResistance> = local6.getResistances();
      var local8:TankDevice = TankDevice(param2.adapt(TankDevice));
      label.color = param1;
      var local9:BitmapData = createTexture(local5,local7,local8);
      this.cleanTexture();
      this.texture.draw(local9);
      local9.dispose();
      var local10:Number = Math.max(32 * local7.length + 4,tankPartInfoWidth);
      width = local10;
      titleHeight += param3;
      height = titleHeight;
      bottomRightU = local10 / this.texture.width;
      bottomRightV = titleHeight / this.texture.height;
    }

    private function cleanTexture() : * {
      this.texture.dispose();
      this.texture = new BitmapData(256,180,true,0);
      material = new TextureMaterial(this.texture);
      material.uploadEveryFrame = true;
    }

    public function dispose() : void {
      if(material != null) {
        material.dispose();
      }
      if(this.texture != null) {
        this.texture.dispose();
      }
      this.texture = null;
      material = null;
    }
  }
}
