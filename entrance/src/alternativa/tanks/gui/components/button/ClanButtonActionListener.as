package alternativa.tanks.gui.components.button {
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.IClanActionListener;
  import alternativa.tanks.models.service.ClanService;
  import controls.DefaultButton;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;

  public class ClanButtonActionListener extends DefaultButton implements IClanActionListener {
    [Inject]
    public static var clanService:ClanService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    private var action:ClanAction;

    public function ClanButtonActionListener(param1:ClanAction) {
      super();
      this.action = param1;
    }

    public function updateActions() : void {
      visible = !clanService.isBlocked && Boolean(clanService.isSelf) && Boolean(clanUserInfoService.hasAction(this.action));
    }
  }
}
