package alternativa.tanks.gui.confirm {
  import controls.base.LabelBase;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.flash.commons.services.timeunit.ITimeUnitService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class DeviceRentConfirmAlert extends DeviceConfirmAlert {
    [Inject]
    public static var timeUnitService:ITimeUnitService;

    public function DeviceRentConfirmAlert(param1:IGameObject, param2:int, param3:int) {
      super(param1,param2);
      var local4:LabelBase = new LabelBase();
      local4.text = localeService.getText(TanksLocale.TEXT_RENT_TIME) + " " + param3 + " " + timeUnitService.getLocalizedDaysName(param3);
      local4.x = windowWidth - local4.width >> 1;
      local4.width = windowWidth - WINDOW_MARGIN * 2;
      local4.y = nameLabel.y + nameLabel.height + SPACE_MODULE;
      addChild(local4);
    }

    override protected function getWindowHeight() : int {
      return 270;
    }

    override protected function getQuestion() : String {
      return localeService.getText(TanksLocale.TEXT_CONFIRM_RENT_QUESTION);
    }
  }
}
