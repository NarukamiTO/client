package alternativa.tanks.view.registration {
  import alternativa.tanks.service.IExternalEntranceService;
  import alternativa.tanks.service.impl.ExternalEntranceService;
  import controls.FBButton;
  import controls.GoogleButton;
  import controls.TankWindow;
  import controls.VKButton;
  import controls.base.LabelBase;
  import controls.containers.HorizontalStackPanel;
  import flash.utils.Dictionary;

  public class ExternalEntranceForm extends TankWindow {
    [Inject]
    public static var externalEntranceService:IExternalEntranceService;

    public var vkButton:VKButton;
    public var fbButton:FBButton;
    public var googleButton:GoogleButton;

    private var infoLabel:LabelBase;
    private var buttonsPanel:HorizontalStackPanel;
    private var buttons:Dictionary;

    public function ExternalEntranceForm(param1:int, param2:int, param3:String) {
      var local4:String = null;
      this.vkButton = new VKButton();
      this.fbButton = new FBButton();
      this.googleButton = new GoogleButton();
      this.buttonsPanel = new HorizontalStackPanel();
      this.buttons = new Dictionary();
      super(param1,param2);
      this.infoLabel = new LabelBase();
      this.infoLabel.text = param3;
      this.infoLabel.y = 15;
      this.infoLabel.x = param1 / 2 - this.infoLabel.width / 2;
      addChild(this.infoLabel);
      if(externalEntranceService.vkontakteEnabled) {
        this.buttons[ExternalEntranceService.VKONTAKTE] = this.vkButton;
      }
      if(externalEntranceService.facebookEnabled) {
        this.buttons[ExternalEntranceService.FACEBOOK] = this.fbButton;
      }
      if(externalEntranceService.googleEnabled) {
        this.buttons[ExternalEntranceService.GOOGLE] = this.googleButton;
      }
      this.buttonsPanel.setMargin(5);
      for(local4 in this.buttons) {
        this.buttonsPanel.addItem(this.buttons[local4]);
      }
      this.buttonsPanel.y = 35;
      this.buttonsPanel.x = param1 / 2 - this.buttonsPanel.width / 2;
      addChild(this.buttonsPanel);
    }
  }
}
