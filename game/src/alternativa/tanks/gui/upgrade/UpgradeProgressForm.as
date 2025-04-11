package alternativa.tanks.gui.upgrade {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.model.item.upgradable.UpgradableItemParams;
  import base.DiscreteSprite;
  import controls.TankWindowInner;
  import controls.labels.MouseDisabledLabel;
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerWithIcon;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.BlendMode;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.geom.Matrix;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;

  public class UpgradeProgressForm extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;

    private static const leftProgressResource:Class = UpgradeProgressForm_leftProgressResource;
    private static const centerProgressResource:Class = UpgradeProgressForm_centerProgressResource;

    private var params:UpgradableItemParams;
    private var progressBarBackground:TankWindowInner;
    private var progressBar:Bitmap = new Bitmap();
    private var leftProgressPart:Bitmap;
    private var centerProgressPart:Bitmap;
    private var upgradeProgressValue:MouseDisabledLabel = new MouseDisabledLabel();
    private var timerLabel:CountDownTimerWithIcon = new CountDownTimerWithIcon();
    private var _width:Number;

    public function UpgradeProgressForm(param1:UpgradableItemParams) {
      super();
      this.params = param1;
      this._width = 400;
      this.progressBarBackground = new TankWindowInner(this._width,50,TankWindowInner.GREEN);
      addChild(this.progressBarBackground);
      this.progressBar.x = 1;
      this.progressBar.y = 1;
      this.progressBar.blendMode = BlendMode.OVERLAY;
      addChild(this.progressBar);
      this.leftProgressPart = new Bitmap(new leftProgressResource().bitmapData);
      this.centerProgressPart = new Bitmap(new centerProgressResource().bitmapData);
      this.upgradeProgressValue.x = 8;
      addChild(this.upgradeProgressValue);
      addChild(this.timerLabel);
    }

    internal function update() : void {
      var local4:Shape = null;
      var local5:Graphics = null;
      var local6:Matrix = null;
      var local1:Number = this._width - 2;
      var local2:int = Math.round(local1 * this.params.getLevel() / this.params.getLevelsCount());
      if(local2 == 0) {
        this.progressBar.visible = false;
      } else {
        this.progressBar.visible = true;
        this.progressBar.bitmapData = new BitmapData(local2,this.leftProgressPart.height,true,0);
        if(local2 > 0) {
          this.progressBar.bitmapData.draw(this.leftProgressPart);
        }
        if(local2 > this.leftProgressPart.width) {
          this.centerProgressPart.width = Math.min(local2 - this.leftProgressPart.width,local1 - this.leftProgressPart.width * 2);
          local4 = new Shape();
          local5 = local4.graphics;
          local5.beginBitmapFill(this.centerProgressPart.bitmapData);
          local5.drawRect(this.leftProgressPart.width,0,this.centerProgressPart.width,this.centerProgressPart.height);
          local5.endFill();
          this.progressBar.bitmapData.draw(local4);
        }
        if(local2 == local1) {
          local6 = new Matrix(-1,0,0,1,local1,0);
          this.progressBar.bitmapData.draw(this.leftProgressPart,local6);
        }
      }
      var local3:String = localeService.getText(TanksLocale.TEXT_PROGRESS);
      this.upgradeProgressValue.text = local3 + ":  " + this.params.getLevel() + " / " + this.params.getLevelsCount();
      this.upgradeProgressValue.y = 23 - (this.upgradeProgressValue.height >> 1);
      this.timerLabel.y = 23 - (this.timerLabel.height >> 1);
      if(this.params.isFullUpgraded()) {
        removeDisplayObject(this.timerLabel);
      }
      if(!this.params.isUpgrading()) {
        this.timerLabel.setTime(this.params.getTimeInSeconds());
      } else {
        this.timerLabel.start(this.params.timer);
      }
      this.align();
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.progressBarBackground.width = param1;
      this.update();
    }

    private function align() : void {
      this.timerLabel.setRightX(this.progressBarBackground.width - 8);
    }

    public function setTimer(param1:CountDownTimer) : void {
      this.timerLabel.start(param1);
    }
  }
}
