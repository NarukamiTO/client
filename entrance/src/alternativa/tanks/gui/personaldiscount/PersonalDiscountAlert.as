package alternativa.tanks.gui.personaldiscount {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.itemslist.PartsList;
  import controls.timer.CountDownTimer;
  import flash.events.Event;
  import flash.text.TextFormatAlign;
  import flash.utils.getTimer;
  import forms.alert.AlertDialogWindow;
  import forms.events.PartsListEvent;
  import projects.tanks.client.panel.model.garage.GarageItemInfo;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class PersonalDiscountAlert extends AlertDialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private var messageLabel:PersonalDiscountLabel;

    public var partsList:PartsList;

    private var discount:int;
    private var discountTimer:CountDownTimer = new CountDownTimer();
    private var priceWithDiscount:int;
    private var windowWidth:int = 425;
    private var windowHeight:int = 190;

    public function PersonalDiscountAlert(param1:GarageItemInfo, param2:String, param3:int, param4:int, param5:int, param6:String) {
      super(param2,localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK));
      this.discount = param3;
      this.priceWithDiscount = param4;
      this.discountTimer.start(getTimer() + param5 * 1000);
      this.messageLabel = new PersonalDiscountLabel();
      this.messageLabel.y = 8;
      this.messageLabel.width = this.windowWidth;
      this.messageLabel.multiline = true;
      this.messageLabel.wordWrap = true;
      this.messageLabel.text = param6;
      this.messageLabel.align = TextFormatAlign.CENTER;
      this.messageLabel.startTimer(this.discountTimer);
      this.messageLabel.color = 5898034;
      this.messageLabel.addEventListener(PersonalDiscountTimerLabelEvent.TIME_ON_COMPLETE_PERSONAL_DISCOUNT_TIMER,this.accept);
      this._contentPlace.addChild(this.messageLabel);
      this.partsList = new PartsList();
      this.partsList.height = 148;
      this.partsList.width = 204;
      this.partsList.x = this.windowWidth / 2 - this.partsList.width / 2;
      this.partsList.y = this.messageLabel.y + this.messageLabel.height + 8;
      this._contentPlace.addChild(this.partsList);
      this.partsList.addEventListener(PartsListEvent.SELECT_PARTS_LIST_ITEM,this.close);
      this.windowHeight = this.messageLabel.height + this.partsList.height + 2 * 8;
      setContentPlaceSize(this.windowWidth,this.windowHeight);
      this.addItems(param1);
    }

    private function addItems(param1:GarageItemInfo) : void {
      this.partsList.addItem(param1.item,param1.name,param1.category,param1.position,this.priceWithDiscount,0,false,false,0,param1.preview,this.discount,null,-1,this.discountTimer);
    }

    private function accept(param1:Event = null) : void {
      this.close();
    }

    override protected function alignCancelButton() : void {
      _cancelButton.x = _contentPlaceWidth - _cancelButton.width >> 1;
    }

    public function close(param1:Event = null) : void {
      this.messageLabel.removeEventListener(PersonalDiscountTimerLabelEvent.TIME_ON_COMPLETE_PERSONAL_DISCOUNT_TIMER,this.accept);
      this.partsList.addEventListener(PartsListEvent.SELECT_PARTS_LIST_ITEM,this.close);
      destroy();
    }
  }
}
