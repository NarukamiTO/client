package alternativa.tanks.model.quest.challenge.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.Label;
  import fl.controls.listClasses.CellRenderer;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.Event;
  import flash.events.TimerEvent;
  import forms.ColorConstants;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.challenge.rewarding.TierItem;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class TierRenderer extends CellRenderer {
    [Inject]
    public static var localeService:ILocaleService;

    private static const pickedBgClass:Class = TierRenderer_pickedBgClass;
    private static const pickedBgBitmapData:BitmapData = new pickedBgClass().bitmapData;
    private static const notPickedBgClass:Class = TierRenderer_notPickedBgClass;
    private static const notPickedBgBitmapData:BitmapData = new notPickedBgClass().bitmapData;
    private static const standardBgClass:Class = TierRenderer_standardBgClass;
    private static const standardBgBitmapData:BitmapData = new standardBgClass().bitmapData;
    private static const goldenBgClass:Class = TierRenderer_goldenBgClass;
    private static const goldenBgBitmapData:BitmapData = new goldenBgClass().bitmapData;
    private static const standardLockClass:Class = TierRenderer_standardLockClass;
    private static const standardLockBitmapData:BitmapData = new standardLockClass().bitmapData;
    private static const goldenLockClass:Class = TierRenderer_goldenLockClass;
    private static const goldenLockBitmapData:BitmapData = new goldenLockClass().bitmapData;
    private static const standardLockIconClass:Class = TierRenderer_standardLockIconClass;
    private static const standardLockIconBitmapData:BitmapData = new standardLockIconClass().bitmapData;
    private static const goldenLockIconClass:Class = TierRenderer_goldenLockIconClass;
    private static const goldenLockIconBitmapData:BitmapData = new goldenLockIconClass().bitmapData;
    private static const standardPickedClass:Class = TierRenderer_standardPickedClass;
    private static const standardPickedBitmapData:BitmapData = new standardPickedClass().bitmapData;
    private static const goldenPickedClass:Class = TierRenderer_goldenPickedClass;
    private static const goldenPickedBitmapData:BitmapData = new goldenPickedClass().bitmapData;

    private var PREVIEW_X_PADDING:int = 5;
    private var tierBackground:Bitmap = new Bitmap();
    private var titleLabel:Label = new Label();
    private var standardLock:Bitmap = new Bitmap();
    private var goldenLock:Bitmap = new Bitmap();
    private var standardLockIcon:Bitmap = new Bitmap();
    private var goldenLockIcon:Bitmap = new Bitmap();
    private var standardPreview:Bitmap = new Bitmap();
    private var goldenPreview:Bitmap = new Bitmap();
    private var standardTitleLabel:* = new Label();
    private var goldenTitleLabel:* = new Label();
    private var standardCountLabel:* = new Label();
    private var goldenCountLabel:* = new Label();
    private var standardBg:Bitmap = new Bitmap(standardBgBitmapData);
    private var goldenBg:Bitmap = new Bitmap(goldenBgBitmapData);

    public function TierRenderer() {
      super();
      addChild(this.tierBackground);
      this.iniStandardItem();
      this.initGoldenItem();
    }

    private function iniStandardItem() : void {
      this.standardBg.x = 3;
      this.standardBg.y = 40;
      addChild(this.standardBg);
      addChild(this.standardPreview);
      this.standardTitleLabel.size = 12;
      this.standardTitleLabel.bold = true;
      this.standardTitleLabel.color = 9285998;
      this.standardTitleLabel.x = this.standardBg.x + 3;
      this.standardTitleLabel.y = this.standardBg.y + 3;
      this.standardTitleLabel.wordWrap = true;
      this.standardTitleLabel.multiline = true;
      addChild(this.standardTitleLabel);
      this.standardCountLabel.size = 16;
      this.standardCountLabel.bold = true;
      this.standardCountLabel.color = 9285998;
      this.standardCountLabel.x = this.standardTitleLabel.x;
      this.standardCountLabel.y = this.standardBg.y + this.standardBg.height - 25;
      addChild(this.standardCountLabel);
      this.standardLock.x = this.standardBg.x;
      this.standardLock.y = this.standardBg.y;
      addChild(this.standardLock);
      this.standardLockIcon.x = this.standardBg.x + this.standardBg.width - 20;
      this.standardLockIcon.y = this.standardBg.y + 5;
      addChild(this.standardLockIcon);
      this.standardTitleLabel.width = this.standardLockIcon.x - this.standardTitleLabel.x - 3;
    }

    private function initGoldenItem() : void {
      this.goldenBg.x = this.standardBg.x;
      this.goldenBg.y = this.standardBg.y + this.standardBg.height + 3;
      addChild(this.goldenBg);
      addChild(this.goldenPreview);
      this.goldenTitleLabel.size = 12;
      this.goldenTitleLabel.bold = true;
      this.goldenTitleLabel.color = 16772787;
      this.goldenTitleLabel.x = this.goldenBg.x + 3;
      this.goldenTitleLabel.y = this.goldenBg.y + 3;
      this.goldenTitleLabel.wordWrap = true;
      this.goldenTitleLabel.multiline = true;
      addChild(this.goldenTitleLabel);
      this.goldenCountLabel.size = 16;
      this.goldenCountLabel.bold = true;
      this.goldenCountLabel.color = 16772787;
      this.goldenCountLabel.x = this.goldenTitleLabel.x;
      this.goldenCountLabel.y = this.goldenBg.y + this.goldenBg.height - 25;
      addChild(this.goldenCountLabel);
      this.goldenLock.x = this.goldenBg.x;
      this.goldenLock.y = this.goldenBg.y;
      addChild(this.goldenLock);
      this.goldenLockIcon.x = this.goldenBg.x + this.goldenBg.width - 20;
      this.goldenLockIcon.y = this.goldenBg.y + 5;
      addChild(this.goldenLockIcon);
      this.goldenTitleLabel.width = this.goldenLockIcon.x - this.goldenTitleLabel.x - 3;
      this.titleLabel.size = 20;
      this.titleLabel.y = 7;
      addChild(this.titleLabel);
    }

    override public function set data(param1:Object) : void {
      var local2:TierItem = null;
      var local3:TierItem = null;
      _data = param1;
      this.titleLabel.text = param1.number + " " + localeService.getText(TanksLocale.TEXT_CHALLENGE_TIER);
      if(param1.state == TierList.STATE_CURRENT) {
        this.titleLabel.text += " [" + param1.progress + "%]";
        if(param1.progress != 100 && !param1.timer.running) {
          param1.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
          param1.timer.start();
        }
      }
      this.titleLabel.x = (notPickedBgBitmapData.width - this.titleLabel.width) / 2;
      this.setTierBackground(param1);
      if(param1.tier.freeItem != null) {
        local2 = param1.tier.freeItem;
        this.setTitle(local2.name,this.standardTitleLabel);
        this.setCount(local2.amount,this.standardCountLabel);
        this.setPreview(this.standardPreview,this.standardBg,local2.preview,0.85);
      } else {
        this.clearFreeItemInfo();
      }
      if(param1.tier.battlePassItem != null) {
        local3 = param1.tier.battlePassItem;
        this.setTitle(local3.name,this.goldenTitleLabel);
        this.setCount(local3.amount,this.goldenCountLabel);
        this.setPreview(this.goldenPreview,this.goldenBg,local3.preview,1);
      } else {
        this.clearGoldenItemInfo();
      }
      this.setLock(param1.tier.freeItem,this.standardLockIcon,this.standardLock,standardLockIconBitmapData,standardPickedBitmapData,standardLockBitmapData);
      this.setLock(param1.tier.battlePassItem,this.goldenLockIcon,this.goldenLock,goldenLockIconBitmapData,goldenPickedBitmapData,goldenLockBitmapData);
    }

    private function setTierBackground(param1:Object) : void {
      if(param1.state == TierList.STATE_DEFAULT) {
        this.titleLabel.color = ColorConstants.GREEN_TEXT;
        this.tierBackground.bitmapData = notPickedBgBitmapData;
      } else {
        this.titleLabel.color = ColorConstants.GREEN_LABEL;
        this.tierBackground.bitmapData = pickedBgBitmapData;
      }
    }

    private function setTitle(param1:String, param2:Label) : void {
      param2.visible = true;
      param2.text = param1;
    }

    private function setCount(param1:int, param2:Label) : void {
      param2.visible = param1 > 1;
      param2.text = "x" + param1;
    }

    private function clearFreeItemInfo() : void {
      this.standardTitleLabel.visible = false;
      this.standardCountLabel.visible = false;
      this.standardPreview.bitmapData = null;
    }

    private function clearGoldenItemInfo() : void {
      this.goldenTitleLabel.visible = false;
      this.goldenCountLabel.visible = false;
      this.goldenPreview.bitmapData = null;
    }

    private function setLock(param1:TierItem, param2:Bitmap, param3:Bitmap, param4:BitmapData, param5:BitmapData, param6:BitmapData) : void {
      if(param1 == null) {
        param3.bitmapData = param6;
        param2.bitmapData = null;
        return;
      }
      if(param1.received) {
        param3.bitmapData = null;
        param2.bitmapData = param5;
      } else {
        param3.bitmapData = param6;
        param2.bitmapData = param4;
      }
    }

    private function setPreview(param1:Bitmap, param2:Bitmap, param3:ImageResource, param4:Number) : void {
      if(param3 != null && (!param3.isLazy || param3.isLoaded)) {
        param1.bitmapData = param3.data;
        param1.width = int(param3.data.width * param4);
        param1.height = int(param3.data.height * param4);
        param1.x = this.PREVIEW_X_PADDING + (param2.width - param1.width) / 2;
        param1.y = param2.y + (param2.height - param1.height) / 2;
      }
    }

    private function onTimer(param1:Event) : * {
      if(_data.state == TierList.STATE_CURRENT) {
        if(this.tierBackground.bitmapData == notPickedBgBitmapData) {
          this.tierBackground.bitmapData = pickedBgBitmapData;
          this.titleLabel.color = ColorConstants.GREEN_LABEL;
        } else {
          this.tierBackground.bitmapData = notPickedBgBitmapData;
          this.titleLabel.color = ColorConstants.GREEN_TEXT;
        }
      }
    }

    override protected function drawBackground() : void {
    }

    override protected function drawLayout() : void {
    }

    override protected function drawIcon() : void {
    }
  }
}
