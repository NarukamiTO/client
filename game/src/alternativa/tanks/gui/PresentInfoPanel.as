package alternativa.tanks.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.types.Long;
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import forms.ColorConstants;
  import forms.userlabel.UserLabel;
  import projects.tanks.clients.flash.commons.services.datetime.DateFormatter;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class PresentInfoPanel extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    private var fromLabel:LabelBase;
    private var presenterLabel:UserLabel;
    private var dateLabel:LabelBase;
    private var messageLabel:LabelBase;

    public function PresentInfoPanel(param1:int) {
      super();
      this.fromLabel = new LabelBase();
      this.fromLabel.text = localeService.getText(TanksLocale.TEXT_PRESENT_INFO_FROM_LABEL);
      this.fromLabel.color = ColorConstants.GREEN_TEXT;
      addChild(this.fromLabel);
      this.dateLabel = new LabelBase();
      this.dateLabel.y = this.fromLabel.height;
      this.dateLabel.color = ColorConstants.GREEN_TEXT;
      addChild(this.dateLabel);
      var local2:LabelBase = new LabelBase();
      local2.y = this.dateLabel.y + this.dateLabel.height + 12;
      local2.text = localeService.getText(TanksLocale.TEXT_PRESENT_INFO_MESSAGE_LABEL);
      local2.color = ColorConstants.GREEN_TEXT;
      addChild(local2);
      this.messageLabel = new LabelBase();
      this.messageLabel.multiline = true;
      this.messageLabel.wordWrap = true;
      this.messageLabel.width = param1;
      this.messageLabel.color = ColorConstants.GREEN_TEXT;
      this.messageLabel.y = local2.y + this.dateLabel.height + 12;
      addChild(this.messageLabel);
    }

    public function update(param1:Long, param2:Date, param3:String) : void {
      this.destroyPresenterLabel();
      this.presenterLabel = new UserLabel(param1);
      this.presenterLabel.x = this.fromLabel.textWidth + 2;
      addChild(this.presenterLabel);
      this.dateLabel.text = localeService.getText(TanksLocale.TEXT_PRESENT_INFO_DATE_LABEL) + " " + DateFormatter.formatDateToLocalized(param2) + " " + DateFormatter.formatTime(param2);
      this.messageLabel.text = param3;
    }

    public function setMessageWidth(param1:Number) : void {
      this.messageLabel.width = param1;
    }

    public function destroyPresenterLabel() : void {
      if(this.presenterLabel != null) {
        if(contains(this.presenterLabel)) {
          removeChild(this.presenterLabel);
        }
        this.presenterLabel = null;
      }
    }

    public function destroy() : void {
      this.destroyPresenterLabel();
    }
  }
}
