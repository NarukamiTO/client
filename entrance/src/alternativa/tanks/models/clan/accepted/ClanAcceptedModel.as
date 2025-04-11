package alternativa.tanks.models.clan.accepted {
  import alternativa.tanks.gui.clanmanagement.ClanManagementPanel;
  import alternativa.tanks.models.service.ClanService;
  import alternativa.types.Long;
  import projects.tanks.client.clans.clan.accepted.ClanAcceptedModelBase;
  import projects.tanks.client.clans.clan.accepted.IClanAcceptedModelBase;

  [ModelInfo]
  public class ClanAcceptedModel extends ClanAcceptedModelBase implements IClanAcceptedModel, IClanAcceptedModelBase {
    [Inject]
    public static var clanService:ClanService;

    public function ClanAcceptedModel() {
      super();
    }

    public function onAdding(param1:Long) : void {
      if(this.getManagementPanel() != null) {
        this.getManagementPanel().addingAcceptedUser(param1);
      }
    }

    public function onRemoved(param1:Long) : void {
      if(this.getManagementPanel() != null) {
        this.getManagementPanel().removeAcceptedUser(param1);
      }
    }

    public function getAcceptedUsers() : Vector.<Long> {
      return getInitParam().objects;
    }

    private function getManagementPanel() : ClanManagementPanel {
      return clanService.clanManagementPanel;
    }
  }
}
