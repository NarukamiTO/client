package alternativa.tanks.model.item.container.gui.opening {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.loader.ILoaderWindowService;
  import controls.TankWindow;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.BlendMode;
  import flash.display.PixelSnapping;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.geom.ColorTransform;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import flash.utils.getTimer;
  import platform.client.fp10.core.resource.BatchResourceLoader;
  import platform.client.fp10.core.resource.Resource;
  import projects.tanks.client.garage.models.item.container.ContainerGivenItem;
  import projects.tanks.client.garage.models.item.container.resources.ContainerResourceCC;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class ContainerOpenDialog extends DialogWindow {
    [Inject]
    public static var loaderService:ILoaderWindowService;

    [Inject]
    public static var localeService:ILocaleService;

    private static const Shine:Class = ContainerOpenDialog_Shine;
    private static const shine:BitmapData = new Shine().bitmapData;
    private static const Mote:Class = ContainerOpenDialog_Mote;
    private static const mote:BitmapData = new Mote().bitmapData;
    private static const Star:Class = ContainerOpenDialog_Star;
    private static const star:BitmapData = new Star().bitmapData;
    private static const Highlight:Class = ContainerOpenDialog_Highlight;
    private static const highlight:BitmapData = new Highlight().bitmapData;
    private static const STATE_SELECT:int = 0;
    private static const STATE_OPEN:int = 1;
    private static const STATE_DELAY:int = 2;
    private static const STATE_PRESENT:int = 3;
    private static const STATE_SWITCH:int = 4;
    private static const STATE_COMPLETE:int = 5;
    private static const STATE_MULTIPLIER:int = 6;
    private static const STATE_LIGHT_UP:int = 7;
    private static const OPEN_BUTTON_WIDTH:Number = 135;
    private static const OPEN_TIME:Number = 35 / 60;
    private static const LIGHT_UP_TIME:Number = 35 / 60;
    private static const PRESENT_MIDDLE_TIME:Number = 15 / 60;
    private static const PRESENT_APPEAR_TIME:Number = 20 / 60;
    private static const PRESENT_TIME:Number = PRESENT_APPEAR_TIME + 40 / 60;
    private static const PRESENT_DISAPPEAR_TIME:Number = PRESENT_TIME + 10 / 60;
    private static const SWITCH_TIME:Number = 30 / 60;
    private static const MULTIPLIER_MIDDLE_TIME:Number = 10 / 60;
    private static const MULTIPLIER_APPEAR_TIME:Number = 15 / 60;
    private static const MULTIPLIER_TIME:Number = MULTIPLIER_APPEAR_TIME + 40 / 60;
    private static const MULTIPLIER_DISAPPEAR_TIME:Number = MULTIPLIER_TIME + 5 / 60;
    private static const WINDOW_WIDTH:int = 625;
    private static const WINDOW_HEIGHT:int = 591;
    private static const BUTTON_PANEL_HEIGHT:int = 54;
    private static const MARGIN:int = 11;

    private var boxesCount:int = 0;
    private var closeButton:DefaultButtonBase = new DefaultButtonBase();
    private var openButtonsPanel:Sprite = new Sprite();
    private var params:ContainerResourceCC;
    private var window:TankWindow = new TankWindow(WINDOW_WIDTH,WINDOW_HEIGHT);
    private var inner:TankWindowInner;
    private var rewards:Vector.<ContainerGivenItem> = new Vector.<ContainerGivenItem>();
    private var presents:Array = [];
    private var index:int = 0;
    private var color:ColorTransform = new ColorTransform();
    private var bgClosed:Sprite = new Sprite();
    private var bgOpen:Sprite = new Sprite();
    private var bgLight:Sprite = new Sprite();
    private var shine1:Sprite = new Sprite();
    private var shine2:Sprite = new Sprite();
    private var dust:Dust = new Dust(mote,16,WINDOW_WIDTH - 100,WINDOW_HEIGHT - 40);
    private var stars:Stars = new Stars(star,highlight,16,WINDOW_WIDTH / 2 - 80);
    private var present:Sprite = new Sprite();
    private var label:LabelBase = new LabelBase();
    private var multiplier:LabelBase = new LabelBase();
    private var timer:int = 0;
    private var state:int = 0;
    private var hasOpenAllButton:Boolean = false;
    private var batchLoader:BatchResourceLoader;

    public function ContainerOpenDialog(param1:ContainerResourceCC, param2:int, param3:Boolean = false) {
      this.batchLoader = new BatchResourceLoader(this.onBoxResourcesLoaded);
      super();
      this.params = param1;
      this.boxesCount = param2;
      this.hasOpenAllButton = param3;
      addChild(this.window);
      this.addResourcesToLoad();
    }

    private function addResourcesToLoad() : void {
      var local1:Vector.<Resource> = new Vector.<Resource>();
      local1.push(this.params.oneBoxImage);
      local1.push(this.params.oneBoxOpenedImage);
      local1.push(this.params.oneBoxLightImage);
      if(this.params.threeBoxImage != null) {
        local1.push(this.params.threeBoxImage);
      }
      if(this.params.threeBoxOpenedImage != null) {
        local1.push(this.params.threeBoxOpenedImage);
      }
      if(this.params.threeBoxLightImage != null) {
        local1.push(this.params.threeBoxLightImage);
      }
      if(this.params.fiveBoxImage != null) {
        local1.push(this.params.fiveBoxImage);
      }
      if(this.params.fiveBoxOpenedImage != null) {
        local1.push(this.params.fiveBoxOpenedImage);
      }
      if(this.params.fiveBoxLightImage != null) {
        local1.push(this.params.fiveBoxLightImage);
      }
      this.batchLoader.load(local1);
    }

    public function openLoots(param1:Vector.<ContainerGivenItem>) : void {
      var resources:Vector.<Resource>;
      var reward:ContainerGivenItem = null;
      var rewards:Vector.<ContainerGivenItem> = param1;
      this.rewards = rewards.concat();
      resources = new Vector.<Resource>();
      for each(reward in rewards) {
        if(!reward.image.isLoaded && resources.indexOf(reward.image) < 0) {
          resources.push(reward.image);
        }
      }
      if(resources.length > 0) {
        new BatchResourceLoader(function():void {
          startOpeningBox();
        }).load(resources);
      } else {
        this.startOpeningBox();
      }
    }

    public function select(param1:int) : void {
      if(param1 == 0) {
        this.bgClosed.getChildAt(0).visible = true;
        this.bgClosed.getChildAt(1).visible = false;
        this.bgClosed.getChildAt(2).visible = false;
        this.bgOpen.getChildAt(0).visible = true;
        this.bgOpen.getChildAt(1).visible = false;
        this.bgOpen.getChildAt(2).visible = false;
        this.bgLight.getChildAt(0).visible = true;
        this.bgLight.getChildAt(1).visible = false;
        this.bgLight.getChildAt(2).visible = false;
      } else if(param1 == 1) {
        this.bgClosed.getChildAt(0).visible = false;
        this.bgClosed.getChildAt(1).visible = true;
        this.bgClosed.getChildAt(2).visible = false;
        this.bgOpen.getChildAt(0).visible = false;
        this.bgOpen.getChildAt(1).visible = true;
        this.bgOpen.getChildAt(2).visible = false;
        this.bgLight.getChildAt(0).visible = false;
        this.bgLight.getChildAt(1).visible = true;
        this.bgLight.getChildAt(2).visible = false;
      } else if(param1 == 2) {
        this.bgClosed.getChildAt(0).visible = false;
        this.bgClosed.getChildAt(1).visible = false;
        this.bgClosed.getChildAt(2).visible = true;
        this.bgOpen.getChildAt(0).visible = false;
        this.bgOpen.getChildAt(1).visible = false;
        this.bgOpen.getChildAt(2).visible = true;
        this.bgLight.getChildAt(0).visible = false;
        this.bgLight.getChildAt(1).visible = false;
        this.bgLight.getChildAt(2).visible = true;
      }
    }

    private function startOpeningBox() : void {
      var local1:ContainerGivenItem = null;
      var local2:Present = null;
      for each(local1 in this.rewards) {
        local2 = new Present(local1.image.data,local1.name,local1.category);
        this.presents.push(local2);
      }
      this.colorize((this.presents[0] as Present).color);
      this.state = STATE_OPEN;
      this.inner.addChild(this.bgOpen);
      this.inner.addChild(this.bgLight);
      this.inner.addChild(this.dust);
      this.inner.addChild(this.stars);
      this.inner.addChild(this.present);
      this.timer = getTimer();
      this.dust.alpha = 0;
      this.bgLight.alpha = 0;
      addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
    }

    private function onEnterFrame(param1:Event) : void {
      var local2:Number = NaN;
      var local3:Number = NaN;
      var local9:Present = null;
      var local4:Number = (getTimer() - this.timer) / 1000;
      var local5:Present = this.presents[this.index];
      var local6:Present = this.presents[this.index + 1] as Present;
      var local7:int = 1;
      var local8:int = this.index - 1;
      while(local8 >= 0) {
        local9 = this.presents[local8];
        if(local9.bitmap.bitmapData != local5.bitmap.bitmapData) {
          break;
        }
        local7++;
        local8--;
      }
      this.multiplier.alpha = local7 > 1 && this.state == STATE_COMPLETE ? 1 : 0;
      this.multiplier.text = "x" + local7.toString();
      this.multiplier.x = -this.multiplier.width / 2;
      if(this.state == STATE_MULTIPLIER) {
        if(local4 < MULTIPLIER_MIDDLE_TIME) {
          local2 = local4 / MULTIPLIER_MIDDLE_TIME;
          local2 = Math.pow(local2,1 / 3);
          local3 = 0.35 + (0.65 + 0.1) * local2;
          this.multiplier.alpha = local2;
          this.multiplier.scaleX = local3;
          this.multiplier.scaleY = local3;
        } else if(local4 < MULTIPLIER_APPEAR_TIME) {
          local2 = 1 - (local4 - MULTIPLIER_MIDDLE_TIME) / (MULTIPLIER_APPEAR_TIME - MULTIPLIER_MIDDLE_TIME);
          local3 = 1 + 0.1 * local2;
          this.multiplier.alpha = 1;
          this.multiplier.scaleX = local3;
          this.multiplier.scaleY = local3;
        } else if(local4 < MULTIPLIER_TIME) {
          this.multiplier.alpha = 1;
          this.multiplier.scaleX = 1;
          this.multiplier.scaleY = 1;
        } else if(local4 < MULTIPLIER_DISAPPEAR_TIME) {
          if(this.index < this.presents.length - 1) {
            local2 = 1 - (local4 - MULTIPLIER_TIME) / (MULTIPLIER_DISAPPEAR_TIME - MULTIPLIER_TIME);
            this.multiplier.alpha = local2;
          } else {
            this.timer = getTimer();
            this.state = STATE_COMPLETE;
          }
        } else {
          this.multiplier.alpha = 0;
          if(local6 != null && local5.bitmap.bitmapData != local6.bitmap.bitmapData) {
            this.present.removeChildren();
            this.state = STATE_SWITCH;
          } else if(local6 == null) {
            this.state = STATE_COMPLETE;
          } else {
            ++this.index;
          }
          this.timer = getTimer();
        }
      } else if(this.state == STATE_OPEN) {
        local2 = local4 / OPEN_TIME;
        if(local2 < 1) {
          this.bgOpen.alpha = local2;
        } else {
          this.bgOpen.alpha = 1;
          this.inner.removeChild(this.bgClosed);
          this.timer = getTimer();
          this.state = STATE_LIGHT_UP;
        }
      } else if(this.state == STATE_LIGHT_UP) {
        local2 = local4 / LIGHT_UP_TIME;
        if(local2 < 1) {
          this.bgLight.alpha = local2;
          this.dust.alpha = local2;
        } else {
          this.bgLight.alpha = 1;
          this.dust.alpha = 1;
          this.timer = getTimer();
          this.state = STATE_DELAY;
        }
      } else if(this.state == STATE_DELAY) {
        if(local4 > local5.delay) {
          this.present.addChild(local5.bitmap);
          this.present.addChild(this.label);
          this.present.addChild(this.multiplier);
          this.label.text = local5.name;
          this.label.x = -this.label.width / 2;
          local5.bitmap.x = -local5.bitmap.width / 2;
          local5.bitmap.y = -local5.bitmap.height / 2;
          this.present.alpha = 0;
          this.timer = getTimer();
          this.state = STATE_PRESENT;
        }
      } else if(this.state == STATE_PRESENT) {
        if(local4 < PRESENT_MIDDLE_TIME) {
          local2 = local4 / PRESENT_MIDDLE_TIME;
          local2 = Math.pow(local2,1 / 3);
          local3 = 0.35 + (0.65 + 0.1) * local2;
          this.present.alpha = local2;
          this.present.scaleX = local3;
          this.present.scaleY = local3;
        } else if(local4 < PRESENT_APPEAR_TIME) {
          this.inner.addChild(this.shine1);
          this.inner.addChild(this.shine2);
          this.inner.addChild(this.dust);
          this.inner.addChild(this.stars);
          this.inner.addChild(this.present);
          this.dust.alpha = 1;
          this.stars.alpha = 1;
          local2 = 1 - (local4 - PRESENT_MIDDLE_TIME) / (PRESENT_APPEAR_TIME - PRESENT_MIDDLE_TIME);
          local3 = 1 + 0.1 * local2;
          this.present.alpha = 1;
          this.present.scaleX = local3;
          this.present.scaleY = local3;
        } else if(local4 < PRESENT_TIME) {
          this.present.alpha = 1;
          this.present.scaleX = 1;
          this.present.scaleY = 1;
        } else if(local4 < PRESENT_DISAPPEAR_TIME) {
          if(this.index < this.presents.length - 1) {
            if(local5.bitmap.bitmapData != local6.bitmap.bitmapData) {
              local2 = 1 - (local4 - PRESENT_TIME) / (PRESENT_DISAPPEAR_TIME - PRESENT_TIME);
              this.present.alpha = local2;
            }
          } else {
            this.timer = getTimer();
            this.state = STATE_COMPLETE;
          }
        } else {
          if(local6 != null && local6.bitmap.bitmapData == local5.bitmap.bitmapData) {
            this.state = STATE_MULTIPLIER;
            ++this.index;
          } else {
            this.state = STATE_SWITCH;
            this.present.alpha = 0;
            this.present.removeChild(local5.bitmap);
          }
          this.timer = getTimer();
        }
      } else if(this.state == STATE_SWITCH) {
        if(local4 < SWITCH_TIME) {
          local2 = local4 / SWITCH_TIME;
          this.interpolate(local5.color,local6.color,local2);
          this.colorize(this.color);
        } else {
          this.colorize(local6.color);
          ++this.index;
          this.timer = getTimer();
          this.state = STATE_DELAY;
        }
      } else if(this.state == STATE_COMPLETE) {
        this.window.addChild(this.closeButton);
      }
      this.shine1.rotation += 0.3;
      this.shine2.rotation -= 0.3;
      this.dust.update();
      this.stars.update();
    }

    private function onBoxResourcesLoaded() : void {
      var local1:int = WINDOW_WIDTH - 2 * MARGIN;
      var local2:int = WINDOW_HEIGHT - 2 * MARGIN - BUTTON_PANEL_HEIGHT - 5;
      this.inner = new TankWindowInner(local1,local2,TankWindowInner.GREEN);
      this.inner.x = MARGIN;
      this.inner.y = MARGIN;
      this.window.addChild(this.inner);
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseDialog,false,0,true);
      this.closeButton.x = WINDOW_WIDTH - this.closeButton.width - MARGIN;
      this.closeButton.y = WINDOW_HEIGHT - this.closeButton.height - MARGIN;
      this.addOpenButtons();
      this.bgClosed.addChild(new Bitmap(this.params.oneBoxImage.data));
      this.bgClosed.addChild(new Bitmap(this.params.threeBoxImage != null ? this.params.threeBoxImage.data : this.params.oneBoxImage.data));
      this.bgClosed.addChild(new Bitmap(this.params.fiveBoxImage != null ? this.params.fiveBoxImage.data : this.params.oneBoxImage.data));
      this.inner.addChild(this.bgClosed);
      this.bgOpen.addChild(new Bitmap(this.params.oneBoxOpenedImage.data));
      this.bgOpen.addChild(new Bitmap(this.params.threeBoxOpenedImage != null ? this.params.threeBoxOpenedImage.data : this.params.oneBoxOpenedImage.data));
      this.bgOpen.addChild(new Bitmap(this.params.fiveBoxOpenedImage != null ? this.params.fiveBoxOpenedImage.data : this.params.oneBoxOpenedImage.data));
      this.bgOpen.alpha = 0;
      this.bgLight.addChild(new Bitmap(this.params.oneBoxLightImage.data));
      this.bgLight.addChild(new Bitmap(this.params.threeBoxLightImage != null ? this.params.threeBoxLightImage.data : this.params.oneBoxOpenedImage.data));
      this.bgLight.addChild(new Bitmap(this.params.fiveBoxLightImage != null ? this.params.fiveBoxLightImage.data : this.params.oneBoxOpenedImage.data));
      this.bgLight.blendMode = BlendMode.ADD;
      this.bgLight.alpha = 0;
      this.bgClosed.width = local1;
      this.bgClosed.height = local2;
      this.bgOpen.width = local1;
      this.bgOpen.height = local2;
      this.bgLight.width = local1;
      this.bgLight.height = local2;
      this.shine1.addChild(new Bitmap(shine,PixelSnapping.NEVER,true));
      this.shine1.getChildAt(0).x = -this.shine1.getChildAt(0).width / 2;
      this.shine1.getChildAt(0).y = -this.shine1.getChildAt(0).height / 2;
      this.shine1.x = WINDOW_WIDTH / 2;
      this.shine1.y = WINDOW_HEIGHT / 2;
      this.shine1.width = 410;
      this.shine1.height = 410;
      this.shine1.blendMode = BlendMode.ADD;
      this.shine2.addChild(new Bitmap(shine,PixelSnapping.NEVER,true));
      this.shine2.getChildAt(0).x = -this.shine1.getChildAt(0).width / 2;
      this.shine2.getChildAt(0).y = -this.shine1.getChildAt(0).height / 2;
      this.shine2.x = WINDOW_WIDTH / 2;
      this.shine2.y = WINDOW_HEIGHT / 2;
      this.shine2.width = 410;
      this.shine2.height = 410;
      this.shine2.blendMode = BlendMode.ADD;
      this.dust.x = 50;
      this.dust.y = 20;
      this.dust.alpha = 0;
      this.stars.x = WINDOW_WIDTH / 2;
      this.stars.y = WINDOW_HEIGHT / 2;
      this.stars.alpha = 0;
      this.present.x = WINDOW_WIDTH / 2;
      this.present.y = WINDOW_HEIGHT / 2;
      this.present.alpha = 0;
      var local3:TextFormat = new TextFormat();
      local3.align = "center";
      this.label.autoSize = TextFieldAutoSize.CENTER;
      this.label.defaultTextFormat = local3;
      this.label.size = 40;
      this.label.x = -(local1 - 100) / 2;
      this.label.y = WINDOW_HEIGHT / 6;
      this.multiplier.autoSize = TextFieldAutoSize.CENTER;
      this.multiplier.defaultTextFormat = local3;
      this.multiplier.size = 40;
      this.multiplier.y = WINDOW_HEIGHT / 6 + 40;
      this.multiplier.alpha = 0;
      this.select(0);
    }

    private function addOpenButtons() : void {
      var local2:OpenBoxButton = null;
      var local3:Array = null;
      var local4:Array = null;
      var local5:int = 0;
      var local6:int = 0;
      var local7:OpenBoxButton = null;
      this.openButtonsPanel.y = WINDOW_HEIGHT - 2 * MARGIN - BUTTON_PANEL_HEIGHT + 15;
      this.window.addChild(this.closeButton);
      this.window.addChild(this.openButtonsPanel);
      var local1:int = 0;
      if(this.hasOpenAllButton) {
        local2 = this.createButton(localeService.getText(TanksLocale.TEXT_OPEN_ALL_CONTAINERS),this.boxesCount,0);
        this.openButtonsPanel.addChild(local2);
        local1 += OPEN_BUTTON_WIDTH;
      } else {
        local3 = [1,5,15];
        local4 = [localeService.getText(TanksLocale.TEXT_LOOT_1_OPEN_BUTTON),localeService.getText(TanksLocale.TEXT_LOOT_2_OPEN_BUTTON),localeService.getText(TanksLocale.TEXT_LOOT_3_OPEN_BUTTON)];
        local5 = 0;
        while(local5 < local3.length) {
          local6 = int(local3[local5]);
          local7 = this.createButton(local4[local5],local6,local5);
          local7.x = local1;
          this.openButtonsPanel.addChild(local7);
          local1 += OPEN_BUTTON_WIDTH;
          local7.enabled = local6 <= this.boxesCount;
          local5++;
        }
      }
      this.openButtonsPanel.x = (WINDOW_WIDTH - local1) / 2;
    }

    private function createButton(param1:String, param2:int, param3:int) : OpenBoxButton {
      var local4:OpenBoxButton = new OpenBoxButton(param1,param2,param3);
      local4.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver,false,0,true);
      local4.addEventListener(MouseEvent.CLICK,this.onBoxSelected,false,0,true);
      return local4;
    }

    private function interpolate(param1:ColorTransform, param2:ColorTransform, param3:Number) : void {
      this.color.redMultiplier = param1.redMultiplier + (param2.redMultiplier - param1.redMultiplier) * param3;
      this.color.greenMultiplier = param1.greenMultiplier + (param2.greenMultiplier - param1.greenMultiplier) * param3;
      this.color.blueMultiplier = param1.blueMultiplier + (param2.blueMultiplier - param1.blueMultiplier) * param3;
    }

    private function colorize(param1:ColorTransform) : void {
      this.bgLight.transform.colorTransform = param1;
      this.shine1.transform.colorTransform = param1;
      this.shine2.transform.colorTransform = param1;
      this.dust.transform.colorTransform = param1;
      this.stars.colorize(param1);
    }

    private function onRollOver(param1:MouseEvent) : void {
      var local2:OpenBoxButton = param1.target as OpenBoxButton;
      this.select(local2.mode);
    }

    private function onBoxSelected(param1:MouseEvent) : void {
      var local2:OpenBoxButton = param1.target as OpenBoxButton;
      this.window.removeChild(this.openButtonsPanel);
      this.window.removeChild(this.closeButton);
      this.boxesCount -= local2.count;
      dispatchEvent(new ContainerEvent(local2.count));
    }

    private function close() : void {
      dialogService.removeDialog(this);
    }

    private function onCloseDialog(param1:MouseEvent) : void {
      this.close();
    }

    override protected function cancelKeyPressed() : void {
      if(this.window.contains(this.closeButton)) {
        this.close();
      }
    }

    override protected function confirmationKeyPressed() : void {
      if(this.window.contains(this.closeButton)) {
        this.close();
      }
    }
  }
}
