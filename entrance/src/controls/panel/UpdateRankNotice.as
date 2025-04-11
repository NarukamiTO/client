package controls.panel {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.TimerEvent;
  import flash.filters.GlowFilter;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import flash.utils.Timer;
  import flash.utils.getTimer;
  import forms.ranks.BigRankIcon;
  import forms.ranks.RankIcon;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;

  public class UpdateRankNotice extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var premiumService:PremiumService;

    [Inject]
    public static var rankService:RankService;

    private static const IconCrystalClass:Class = UpdateRankNotice_IconCrystalClass;
    private static const RANK_OFFSET_Y:int = -73;
    private static const GIFT_OFFSET:int = 60;
    private static const HEIGHT_NORMAL:int = 90;
    private static const HEIGHT_WITH_GIFT:int = 135;

    private const showTime:int = 4000;
    private const hideTime:int = 2000;

    private var currentHeight:int;
    private var label:LabelBase;
    private var gift:LabelBase;
    private var timer:Timer;
    private var rankIcon:RankIcon;
    private var beginHideTime:int;

    public function UpdateRankNotice(param1:int, param2:int) {
      var local3:Bitmap = null;
      this.rankIcon = new BigRankIcon();
      super();
      filters = [new GlowFilter(0,1,6,6)];
      this.rankIcon.init(premiumService.hasPremium(),param1);
      this.rankIcon.x = -(this.rankIcon.width >> 1);
      this.rankIcon.y = RANK_OFFSET_Y;
      addChild(this.rankIcon);
      this.label = new LabelBase();
      this.label.color = 16776960;
      this.label.size = 18;
      this.label.bold = true;
      this.label.autoSize = TextFieldAutoSize.CENTER;
      this.label.align = TextFormatAlign.CENTER;
      this.label.multiline = true;
      this.label.text = localeService.getText(TanksLocale.TEXT_MAIN_PANEL_UPDATE_RANK_NOTICE,rankService.getRankName(param1));
      addChild(this.label);
      this.currentHeight = HEIGHT_NORMAL;
      if(param2 > 0) {
        this.gift = new LabelBase();
        this.gift.color = 16776960;
        this.gift.size = 18;
        this.gift.bold = true;
        this.gift.autoSize = TextFieldAutoSize.CENTER;
        this.gift.text = localeService.getText(TanksLocale.TEXT_MAIN_PANEL_UPDATE_RANK_NOTICE_GIFT,param2.toString());
        this.gift.x = -(this.gift.width >> 1);
        this.gift.y = GIFT_OFFSET;
        addChild(this.gift);
        local3 = new IconCrystalClass();
        local3.x = this.gift.x + this.gift.width + 2;
        local3.y = GIFT_OFFSET - 1;
        addChild(local3);
        this.currentHeight = HEIGHT_WITH_GIFT;
      }
      addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
    }

    private function addedToStageHandler(param1:Event) : void {
      stage.addEventListener(Event.RESIZE,this.stage_resizeHandler);
      this.timer = new Timer(this.showTime,1);
      this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.timer_timerCompleteHandler);
      this.timer.start();
      this.stage_resizeHandler(null);
    }

    private function removedFromStageHandler(param1:Event) : void {
      stage.removeEventListener(Event.RESIZE,this.stage_resizeHandler);
      removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
    }

    private function stage_resizeHandler(param1:Event) : void {
      x = stage.stageWidth / 2;
      y = stage.stageHeight - this.currentHeight >> 1;
    }

    private function timer_timerCompleteHandler(param1:TimerEvent) : void {
      this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.timer_timerCompleteHandler);
      addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      this.beginHideTime = getTimer();
    }

    private function enterFrameHandler(param1:Event) : void {
      var local2:Number = 1 - (getTimer() - this.beginHideTime) / this.hideTime;
      this.alpha = local2;
      if(local2 <= 0) {
        removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
        parent.removeChild(this);
      }
    }
  }
}
