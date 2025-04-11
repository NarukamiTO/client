package alternativa.tanks.view.mainview.groupinvite {
  import alternativa.osgi.service.locale.ILocaleService;
  import base.DiscreteSprite;
  import controls.base.LabelBase;
  import controls.statassets.StatLineHeader;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import forms.ColorConstants;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class InviteHeader extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;

    private var bg:StatLineHeader = new StatLineHeader();
    private var label:LabelBase = new LabelBase();

    public function InviteHeader() {
      super();
      this.bg.width = width;
      this.bg.height = 18;
      addChild(this.bg);
      addChild(this.label);
      this.label.color = ColorConstants.HEADER_COLOR;
      this.label.x = 2;
      this.label.y = 0;
      this.label.mouseEnabled = false;
      this.label.autoSize = TextFieldAutoSize.NONE;
      this.label.align = TextFormatAlign.LEFT;
      this.label.height = 18;
      this.label.text = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_CALLSIGN);
    }

    override public function set width(param1:Number) : void {
      super.width = width;
      this.bg.width = param1;
      this.label.width = width - 4;
    }
  }
}
