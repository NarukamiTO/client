package alternativa.tanks.models.clan.block {
  import alternativa.tanks.gui.clanmanagement.ClanActionsManager;
  import alternativa.tanks.models.service.ClanService;
  import projects.tanks.client.clans.clan.block.ClanBlockModelBase;
  import projects.tanks.client.clans.clan.block.IClanBlockModelBase;

  [ModelInfo]
  public class ClanBlockModel extends ClanBlockModelBase implements IClanBlockModelBase {
    [Inject]
    public static var clanService:ClanService;

    public function ClanBlockModel() {
      super();
    }

    public function clanBaned(param1:String) : void {
      clanService.clanBlock(param1);
      ClanActionsManager.updateActions();
    }
  }
}
