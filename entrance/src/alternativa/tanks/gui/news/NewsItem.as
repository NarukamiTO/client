package alternativa.tanks.gui.news {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.startup.CacheLoader;
  import alternativa.tanks.gui.communication.tabs.news.NewsTab;
  import alternativa.tanks.gui.frames.GreenFrame;
  import alternativa.tanks.services.NewsService;
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.events.TextEvent;
  import flash.events.TimerEvent;
  import flash.globalization.DateTimeFormatter;
  import flash.net.URLRequest;
  import flash.utils.Dictionary;
  import flash.utils.Timer;
  import forms.ColorConstants;
  import projects.tanks.client.chat.models.news.showing.NewsItemData;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class NewsItem extends Sprite {
    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    [Inject]
    public static var newsService:NewsService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var rankService:RankService;

    private static const WIDTH:int = 280;
    private static const TEXT_LEFT_MARGIN:int = 80;
    private static const GAP:int = 5;
    private static const MIN_HEIGHT:int = 80;
    private static const BOTTOM_GAP:int = 27;

    private var newsHeader:LabelBase = new LabelBase();
    private var newsText:LabelBase = new LabelBase();
    private var shopCategories:Dictionary = new Dictionary();
    private var frame:GreenFrame;
    private var newsItem:NewsItemData;
    private var timer:Timer;
    private var newsTab:NewsTab;

    public function NewsItem(param1:NewsItemData, param2:NewsTab, param3:int) {
      super();
      this.newsItem = param1;
      this.newsTab = param2;
      if(!newsService.isViewed(param1) && param2 != null) {
        this.frame = new GreenFrame(WIDTH,MIN_HEIGHT);
        addChild(this.frame);
      }
      this.addImage();
      this.addHeader();
      this.addDescription();
      if(param3 > 0 && param2 != null) {
        this.timer = new Timer(param3);
        this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
        this.timer.start();
      }
      this.initShopCategoriesDictionary();
    }

    private static function replaceAllMetaVars(param1:String) : String {
      var local3:String = null;
      var local4:RegExp = null;
      var local2:Dictionary = createMetaVars();
      for(local3 in local2) {
        local4 = new RegExp(local3,"g");
        param1 = param1.replace(local4,local2[local3]);
      }
      return param1;
    }

    private static function createMetaVars() : Dictionary {
      var local1:Dictionary = new Dictionary();
      local1["%USERNAME%"] = userPropertiesService.userName;
      local1["%ID%"] = userPropertiesService.userId;
      local1["%RANK%"] = rankService.getRankName(userPropertiesService.fullRank);
      local1["%RANK_NUM%"] = userPropertiesService.fullRank;
      local1["%LOCALE%"] = localeService.language;
      local1["%REG_DATETIME%"] = getFormattedRegistrationDateTime();
      return local1;
    }

    private static function getFormattedRegistrationDateTime() : String {
      var local1:Date = new Date(userPropertiesService.registrationTimestamp * 1000);
      var local2:DateTimeFormatter = new DateTimeFormatter("en-US");
      local2.setDateTimePattern("yyyy-MM-dd\'T\'HH:mm:ss");
      return local2.format(local1);
    }

    public function read() : void {
      if(!this.isRead()) {
        removeChild(this.frame);
        newsService.setIsViewed(this.newsItem.id);
      }
    }

    public function isRead() : Boolean {
      return this.frame == null || !contains(this.frame);
    }

    private function onTimer(param1:TimerEvent) : void {
      this.timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
      this.timer = null;
      this.newsTab.removeNewsItem(this);
    }

    private function addImage() : void {
      var local1:CacheLoader = new CacheLoader();
      var local2:URLRequest = new URLRequest(this.newsItem.imageUrl);
      local1.load(local2);
      addChild(local1);
      local1.x = GAP;
      local1.y = GAP;
    }

    private function addHeader() : void {
      this.newsHeader.x = TEXT_LEFT_MARGIN;
      this.newsHeader.y = GAP;
      this.newsHeader.htmlText = "<b>" + this.newsItem.header + "<\b>";
      this.newsHeader.width = WIDTH - TEXT_LEFT_MARGIN - GAP;
      this.newsHeader.color = ColorConstants.GREEN_LABEL;
      addChild(this.newsHeader);
    }

    private function addDescription() : void {
      this.newsText.x = TEXT_LEFT_MARGIN;
      this.newsText.y = 23;
      this.newsText.wordWrap = true;
      this.newsText.multiline = true;
      this.newsText.width = this.newsHeader.width;
      this.newsText.htmlText = replaceAllMetaVars(this.newsItem.description);
      this.newsText.color = ColorConstants.GREEN_LABEL;
      this.newsText.addEventListener(TextEvent.LINK,this.linkActivated);
      addChild(this.newsText);
    }

    private function initShopCategoriesDictionary() : void {
      var local1:ShopCategoryEnum = null;
      this.shopCategories["shop"] = ShopCategoryEnum.NO_CATEGORY;
      for each(local1 in ShopCategoryEnum.values) {
        this.shopCategories["shop/" + local1.name.toLocaleLowerCase()] = local1;
      }
    }

    private function linkActivated(param1:TextEvent) : void {
      var local2:String = param1.text.toLowerCase();
      if(this.shopCategories.hasOwnProperty(local2)) {
        paymentDisplayService.openPaymentAt(this.shopCategories[local2]);
      }
    }

    public function destroy() : void {
      if(this.timer != null) {
        this.timer.stop();
        this.timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
      }
      this.newsText.removeEventListener(TextEvent.LINK,this.linkActivated);
    }

    public function resize(param1:int) : void {
      this.newsText.width = param1 - TEXT_LEFT_MARGIN - GAP;
      if(this.frame != null) {
        this.frame.setWidth(param1);
        this.frame.setHeight(this.getHeight());
      }
    }

    public function getHeight() : int {
      return Math.max(this.newsText.textHeight + BOTTOM_GAP,MIN_HEIGHT);
    }
  }
}
