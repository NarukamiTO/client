package alternativa.tanks.model.socialnetwork.notification {
  import alternativa.tanks.gui.socialnetwork.AbstractSNGroupEnteringWindow;
  import alternativa.tanks.gui.socialnetwork.ok.OkGroupReminderWindow;
  import alternativa.tanks.gui.socialnetwork.ok.OkGroupThanksForEnteringWindow;
  import alternativa.tanks.gui.socialnetwork.vk.VkGroupReminderWindow;
  import alternativa.tanks.gui.socialnetwork.vk.VkGroupThanksForEnteringWindow;
  import flash.external.ExternalInterface;
  import flash.system.Security;
  import projects.tanks.client.commons.socialnetwork.SocialNetworkEnum;
  import projects.tanks.client.panel.model.socialnetwork.notification.ISNGroupReminderModelBase;
  import projects.tanks.client.panel.model.socialnetwork.notification.SNGroupReminderModelBase;

  [ModelInfo]
  public class SNGroupReminderModel extends SNGroupReminderModelBase implements ISNGroupReminderModelBase {
    private var snId:String;

    public function SNGroupReminderModel() {
      super();
    }

    public function checkIsInGroup(param1:String, param2:String) : void {
      this.snId = param2;
      this.checkGroup(param1);
    }

    private function checkGroup(param1:String) : void {
      if(ExternalInterface.available) {
        Security.allowDomain("*");
        ExternalInterface.addCallback("onReceiveIsInTOGroup",getFunctionWrapper(this.onReceiveIsInTOGroup));
        ExternalInterface.call("isMemberOfTOGroup",param1);
      }
    }

    private function onReceiveIsInTOGroup(param1:Boolean) : void {
      if(param1) {
        server.giveBonus();
      } else {
        this.showReminderWindow();
      }
    }

    private function showReminderWindow() : void {
      var local1:AbstractSNGroupEnteringWindow = null;
      switch(this.snId) {
        case SocialNetworkEnum.VKONTAKTE_INTERNAL.name.toLocaleLowerCase():
          local1 = new VkGroupReminderWindow();
          break;
        case SocialNetworkEnum.ODNOKLASSNIKI_INTERNAL.name.toLocaleLowerCase():
          local1 = new OkGroupReminderWindow();
      }
      local1.show();
    }

    public function showCongratulationsWindow() : void {
      var local1:AbstractSNGroupEnteringWindow = null;
      switch(this.snId) {
        case SocialNetworkEnum.VKONTAKTE_INTERNAL.name.toLocaleLowerCase():
          local1 = new VkGroupThanksForEnteringWindow();
          break;
        case SocialNetworkEnum.ODNOKLASSNIKI_INTERNAL.name.toLocaleLowerCase():
          local1 = new OkGroupThanksForEnteringWindow();
      }
      local1.show();
    }
  }
}
