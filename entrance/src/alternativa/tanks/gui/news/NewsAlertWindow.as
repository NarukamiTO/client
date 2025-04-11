package alternativa.tanks.gui.news {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import fl.containers.ScrollPane;
  import fl.controls.ScrollPolicy;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import forms.ColorConstants;
  import forms.TankWindowWithHeader;
  import projects.tanks.client.chat.models.news.showing.NewsItemData;
  import projects.tanks.clients.flash.commons.services.datetime.DateFormatter;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import utils.ScrollStyleUtils;

  public class NewsAlertWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private static const SCROLL_SPEED_MULTIPLIER:int = 3;
    private static const WIDTH:int = 500;

    private var scrollPane:ScrollPane = new ScrollPane();
    private var scrollContainer:Sprite = new Sprite();
    private var window:TankWindowWithHeader;
    private var closeButton:DefaultButtonBase;
    private var innerWidth:int;

    public function NewsAlertWindow(param1:Vector.<NewsItemData>) {
      super();
      this.innerWidth = WIDTH - 2 * 10;
      this.addNewsItems(param1);
      var local2:int = this.scrollContainer.height < 300 ? int(this.scrollContainer.height + 100) : 400;
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_NEWS,WIDTH,local2);
      addChild(this.window);
      var local3:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      local3.x = 10;
      local3.y = 10;
      local3.height = this.window.height - 50 - 2 * 10;
      local3.width = this.window.width - 2 * 10;
      addChild(local3);
      ScrollStyleUtils.setGreenStyle(this.scrollPane);
      this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
      this.scrollPane.verticalScrollPolicy = ScrollPolicy.AUTO;
      this.scrollPane.source = this.scrollContainer;
      this.scrollPane.x = 10;
      this.scrollPane.y = 10;
      this.scrollPane.focusEnabled = false;
      this.scrollPane.setSize(local3.width - 10,local3.height - 2 * 10);
      this.scrollPane.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,true);
      this.scrollPane.update();
      local3.addChild(this.scrollPane);
      this.scrollPane.update();
      this.closeButton = new DefaultButtonBase();
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
      this.closeButton.x = (this.window.width - this.closeButton.width) / 2;
      this.closeButton.y = this.window.height - this.closeButton.height - 20;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onClickCancel);
      addChild(this.closeButton);
    }

    private function onClickCancel(param1:MouseEvent = null) : void {
      this.destroy();
      dialogService.removeDialog(this);
    }

    private function onMouseWheel(param1:MouseEvent) : void {
      param1.delta *= SCROLL_SPEED_MULTIPLIER;
    }

    private function createNewsItem(param1:NewsItemData) : NewsItem {
      var local2:NewsItem = new NewsItem(param1,null,0);
      local2.x = -4;
      return local2;
    }

    private function addNewsItems(param1:Vector.<NewsItemData>) : void {
      var local4:NewsItemData = null;
      var local5:Sprite = null;
      var local6:NewsItem = null;
      var local7:String = null;
      var local8:LabelBase = null;
      var local2:int = 0;
      var local3:String = "";
      for each(local4 in param1) {
        local6 = this.createNewsItem(local4);
        local7 = this.getDateString(local4.dateInSeconds);
        if(local3 != local7) {
          local3 = local7;
          local8 = new LabelBase();
          local8.htmlText = local3;
          local8.textColor = ColorConstants.NEWS_DATE;
          this.scrollContainer.addChild(local8);
          local8.x = this.innerWidth - local8.textWidth - 20 >> 1;
          local8.y = local2;
          local2 += 10;
        }
        local6.y = local2;
        local6.resize(this.innerWidth - 20);
        this.scrollContainer.addChild(local6);
        local2 = local6.y + local6.height + 10;
      }
      local5 = new Sprite();
      local5.graphics.beginFill(0,0);
      local5.graphics.drawRect(0,0,10,20);
      local5.graphics.endFill();
      local5.y = local2;
      this.scrollContainer.addChild(local5);
    }

    private function getDateString(param1:int) : String {
      var local2:Date = new Date();
      local2.setTime(param1 * 1000);
      return DateFormatter.formatDateToLocalized(local2);
    }

    override protected function cancelKeyPressed() : void {
      this.onClickCancel();
    }

    override protected function confirmationKeyPressed() : void {
      this.onClickCancel();
    }

    override public function get height() : Number {
      return this.window.height;
    }

    override public function get width() : Number {
      return this.window.width;
    }

    private function destroy() : void {
      var local2:NewsItem = null;
      this.scrollPane.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onClickCancel);
      var local1:int = 0;
      while(local1 < this.scrollContainer.numChildren) {
        local2 = this.scrollContainer.getChildAt(local1) as NewsItem;
        if(local2 != null) {
          local2.destroy();
        }
        local1++;
      }
    }
  }
}
