package alternativa.tanks.gui.selectcountry {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.country.CountryService;
  import controls.TankWindow;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.dropdownlist.DropDownList;
  import flash.events.MouseEvent;
  import projects.tanks.client.panel.model.usercountry.CountryInfo;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class SelectCountryAlert extends DialogWindow {
    [Inject]
    public static var countryService:CountryService;

    [Inject]
    public static var dialogService:IDialogsService;

    [Inject]
    public static var localeService:ILocaleService;

    private const TOP_PADDING:int = 20;

    private var okButton:DefaultButtonBase;
    private var chooseCountryComboBox:DropDownList;
    private var countrySelectedCallback:Function;

    public function SelectCountryAlert(param1:Function) {
      var local4:LabelBase = null;
      super();
      this.countrySelectedCallback = param1;
      var local2:TankWindow = new TankWindow(340,140);
      addChild(local2);
      this.okButton = new DefaultButtonBase();
      this.okButton.label = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK);
      this.okButton.x = (width - this.okButton.width) / 2;
      this.okButton.y = local2.height - this.okButton.height - 20;
      this.okButton.addEventListener(MouseEvent.CLICK,this.onClick);
      addChild(this.okButton);
      var local3:LabelBase = new LabelBase();
      local3.text = localeService.getText(TanksLocale.TEXT_CHECK_YOU_LOCATION_TEXT);
      local3.x = this.TOP_PADDING;
      local3.y = this.TOP_PADDING + 5;
      addChild(local3);
      local4 = new LabelBase();
      local4.text = localeService.getText(TanksLocale.TEXT_YOURE_LOCATION_TEXT);
      local4.x = this.TOP_PADDING;
      local4.y = 55;
      local4.width = 300;
      local4.wordWrap = true;
      addChild(local4);
      this.chooseCountryComboBox = new DropDownList();
      this.chooseCountryComboBox.width = local2.width - 45 - local3.width;
      this.chooseCountryComboBox.y = this.TOP_PADDING;
      this.initCountries();
      addChild(this.chooseCountryComboBox);
      this.chooseCountryComboBox.x = local3.x + local3.width + 5;
      dialogService.addDialog(this);
    }

    private function initCountries() : void {
      var local1:Vector.<CountryInfo> = countryService.getRegisteredCountries();
      var local2:int = 0;
      while(local2 < local1.length) {
        this.chooseCountryComboBox.addItem({
          "rang":0,
          "index":local2,
          "id":local2,
          "gameName":local1[local2].countryName,
          "code":local1[local2].countryCode
        });
        local2++;
      }
      this.chooseCountryComboBox.sortOn("gameName");
      if(Boolean(countryService.getDefaultCountryCode())) {
        this.chooseCountryComboBox.selectItemByField("code",countryService.getDefaultCountryCode());
      } else {
        this.chooseCountryComboBox.selectItemByField("id",0);
      }
    }

    private function onClick(param1:MouseEvent) : void {
      dialogService.removeDialog(this);
      this.countrySelectedCallback(this.chooseCountryComboBox.selectedItem["code"]);
      this.destroyWindow();
    }

    private function destroyWindow() : void {
      this.okButton.removeEventListener(MouseEvent.CLICK,this.onClick);
      this.countrySelectedCallback = null;
      this.okButton = null;
      this.chooseCountryComboBox = null;
    }
  }
}
