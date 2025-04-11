package alternativa.tanks.gui.communication.tabs.news {
  import alternativa.tanks.gui.communication.tabs.*;
  import alternativa.tanks.gui.news.NewsItem;
  import alternativa.tanks.services.NewsService;
  import alternativa.tanks.services.NewsServiceEvent;
  import alternativa.types.Long;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import fl.containers.ScrollPane;
  import fl.controls.ScrollPolicy;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.utils.Dictionary;
  import forms.ColorConstants;
  import projects.tanks.client.chat.models.news.showing.NewsItemData;
  import projects.tanks.clients.flash.commons.services.datetime.DateFormatter;
  import utils.ScrollStyleUtils;

  public class NewsTab extends AbstractCommunicationPanelTab {
    [Inject]
    public static var newsService:NewsService;

    private static const AROUND_GAP:int = 25;
    private static const SCROLL_GAP:int = 5;
    private static const SCROLL_PANE_BOTTOM_PADDING:int = 15;
    private static const SCROLL_SHIFT_GAP:int = 5;
    private static const SCROLL_SPEED_MULTIPLIER:int = 3;
    private static const LEFT_MARGIN:int = 10;
    private static const VERTICAL_GAP:int = 12;
    private static const NEWS_VERTICAL_GAP:int = 24;

    private var scrollPane:ScrollPane = new ScrollPane();
    private var scrollContainer:Sprite = new Sprite();
    private var scrollPaneBottomPadding:Sprite = new Sprite();
    private var inner:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
    private var scrollEnabled:Boolean;
    private var _width:int;
    private var _height:int;
    private var newsId2NewsItem:Dictionary = new Dictionary();

    public function NewsTab() {
      super();
      this.inner.showBlink = true;
      addChild(this.inner);
      this.scrollContainer.addChild(this.scrollPaneBottomPadding);
      ScrollStyleUtils.setGreenStyle(this.scrollPane);
      this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
      this.scrollPane.verticalScrollPolicy = ScrollPolicy.AUTO;
      this.scrollPane.source = this.scrollContainer;
      this.scrollPane.update();
      this.scrollPane.focusEnabled = false;
      this.scrollPane.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,true);
      this.inner.addChild(this.scrollPane);
      newsService.setNewsAddingCallback(this.addNewsItems);
      newsService.addEventListener(NewsServiceEvent.NEWS_ITEM_IS_SENT,this.onNewsItemAdded);
      newsService.addEventListener(NewsServiceEvent.NEWS_ITEM_IS_REMOVED,this.onNewsItemRemoved);
      addEventListener(MouseEvent.CLICK,this.onClick);
    }

    private function onClick(param1:MouseEvent) : void {
      var local3:DisplayObject = null;
      var local4:NewsItem = null;
      var local5:int = 0;
      var local2:int = 0;
      while(local2 < this.scrollContainer.numChildren) {
        local3 = this.scrollContainer.getChildAt(local2);
        if(local3 is NewsItem) {
          local4 = NewsItem(local3);
          local5 = local3.y - (this.scrollEnabled ? this.scrollPane.verticalScrollPosition : 0);
          if(!local4.isRead() && local3.x <= mouseX && local3.x + local3.width >= mouseX && local5 <= mouseY && local5 + local3.height >= mouseY) {
            local4.read();
            break;
          }
        }
        local2++;
      }
    }

    private function onMouseWheel(param1:MouseEvent) : void {
      param1.delta *= SCROLL_SPEED_MULTIPLIER;
    }

    private function onNewsItemRemoved(param1:NewsServiceEvent) : void {
      var local2:Long = param1.getNewsId();
      var local3:NewsItem = this.newsId2NewsItem[local2];
      if(local3 != null) {
        this.removeNewsItem(local3);
      }
    }

    public function removeNewsItem(param1:NewsItem) : void {
      param1.destroy();
      var local2:int = this.scrollContainer.getChildIndex(param1);
      this.scrollContainer.removeChildAt(local2);
      this.removeUnusedDateLabel(local2);
      this.resize(this._width,this._height);
    }

    private function removeUnusedDateLabel(param1:int) : void {
      if(!(this.scrollContainer.getChildAt(param1 - 1) is LabelBase)) {
        return;
      }
      if(param1 == this.scrollContainer.numChildren || this.scrollContainer.getChildAt(param1) is LabelBase) {
        this.scrollContainer.removeChildAt(param1 - 1);
      }
    }

    private function onNewsItemAdded(param1:NewsServiceEvent) : void {
      var local6:LabelBase = null;
      var local2:NewsItemData = param1.getNewsItem();
      var local3:Long = local2.id;
      if(this.newsId2NewsItem[local3] != null) {
        return;
      }
      var local4:NewsItem = this.createNewsItem(local2);
      if(local4 == null) {
        return;
      }
      this.newsId2NewsItem[local3] = local4;
      var local5:String = this.getDateString(local2.dateInSeconds);
      if(this.scrollContainer.numChildren > 1) {
        local6 = this.scrollContainer.getChildAt(1) as LabelBase;
        if(local5 == local6.text) {
          this.scrollContainer.addChildAt(local4,2);
        } else {
          this.addNewsItemAndNewDateBlock(local4,local5);
        }
      } else {
        this.addNewsItemAndNewDateBlock(local4,local5);
      }
      this.resize(this._width,this._height);
      dispatchEvent(new NewsTabNewsItemAddedEvent());
    }

    private function createNewsItem(param1:NewsItemData) : NewsItem {
      var local2:int = 0;
      if(param1.endDate > 0) {
        local2 = param1.endDate * 1000 - new Date().time;
        if(local2 < 5000) {
          return null;
        }
      }
      var local3:NewsItem = new NewsItem(param1,this,local2);
      local3.x = LEFT_MARGIN;
      return local3;
    }

    private function addNewsItemAndNewDateBlock(param1:NewsItem, param2:String) : void {
      this.scrollContainer.addChildAt(param1,1);
      var local3:LabelBase = new LabelBase();
      local3.htmlText = param2;
      local3.textColor = ColorConstants.NEWS_DATE;
      this.scrollContainer.addChildAt(local3,1);
    }

    override public function resize(param1:int, param2:int) : void {
      this._width = param1;
      this._height = param2;
      this.scrollPane.y = SCROLL_GAP;
      this.scrollPane.setSize(param1 + SCROLL_SHIFT_GAP,param2 - SCROLL_GAP * 2);
      this.inner.width = param1;
      this.inner.height = param2;
      var local3:int = this.resizeAll(param1 - 20);
      this.scrollEnabled = false;
      if(this.scrollPane.height < local3 + SCROLL_SHIFT_GAP * 2) {
        local3 = this.resizeAll(param1 - 25);
        this.scrollEnabled = true;
      }
      this.fixScrollPaneBottomPadding(local3);
      this.scrollPane.update();
    }

    private function fixScrollPaneBottomPadding(param1:int) : void {
      this.scrollPaneBottomPadding.graphics.lineStyle(1,ColorConstants.WHITE,0);
      this.scrollPaneBottomPadding.graphics.beginFill(ColorConstants.WHITE,0);
      this.scrollPaneBottomPadding.graphics.drawRect(0,0,1,SCROLL_PANE_BOTTOM_PADDING);
      this.scrollPaneBottomPadding.graphics.endFill();
      this.scrollPaneBottomPadding.x = AROUND_GAP;
      this.scrollPaneBottomPadding.y = param1;
    }

    private function resizeAll(param1:int) : int {
      var local4:DisplayObject = null;
      var local5:NewsItem = null;
      var local6:LabelBase = null;
      var local2:int = VERTICAL_GAP >> 1;
      var local3:int = 0;
      while(local3 < this.scrollContainer.numChildren) {
        local4 = this.scrollContainer.getChildAt(local3);
        if(local4 is NewsItem) {
          local5 = NewsItem(local4);
          local5.resize(param1);
          local5.y = local2;
          local2 += local5.getHeight() + NEWS_VERTICAL_GAP;
        }
        if(local4 is LabelBase) {
          local6 = LabelBase(local4);
          local6.x = param1 - local6.textWidth >> 1;
          local6.y = local2;
          local2 = local6.y + local6.textHeight + VERTICAL_GAP;
        }
        local3++;
      }
      return local2;
    }

    private function addNewsItems(param1:Vector.<NewsItemData>) : void {
      var local3:NewsItemData = null;
      var local4:NewsItem = null;
      var local5:String = null;
      var local6:LabelBase = null;
      this.clearAll();
      var local2:String = "";
      for each(local3 in param1) {
        local4 = this.createNewsItem(local3);
        if(local4 != null) {
          local5 = this.getDateString(local3.dateInSeconds);
          if(local2 != local5) {
            local2 = local5;
            local6 = new LabelBase();
            local6.htmlText = local2;
            local6.textColor = ColorConstants.NEWS_DATE;
            this.scrollContainer.addChild(local6);
          }
          this.newsId2NewsItem[local3.id] = local4;
          this.scrollContainer.addChild(local4);
        }
      }
      this.resize(this._width,this._height);
    }

    private function getDateString(param1:int) : String {
      var local2:Date = new Date();
      local2.setTime(param1 * 1000);
      return DateFormatter.formatDateToLocalized(local2);
    }

    private function clearAll() : void {
      this.scrollContainer = new Sprite();
      this.scrollPaneBottomPadding = new Sprite();
      this.scrollContainer.addChild(this.scrollPaneBottomPadding);
      this.scrollPane.source = this.scrollContainer;
      this.scrollPane.update();
      newsService.clearExpiredReadNews();
    }

    public function destroy() : void {
      var local2:NewsItem = null;
      newsService.resetNewsAddingCallback();
      this.scrollPane.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
      newsService.removeEventListener(NewsServiceEvent.NEWS_ITEM_IS_SENT,this.onNewsItemAdded);
      newsService.removeEventListener(NewsServiceEvent.NEWS_ITEM_IS_REMOVED,this.onNewsItemRemoved);
      removeEventListener(MouseEvent.CLICK,this.onClick);
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
