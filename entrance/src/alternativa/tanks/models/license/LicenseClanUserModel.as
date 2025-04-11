package alternativa.tanks.models.license {
  import alternativa.tanks.models.user.ClanUserService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.clans.license.user.ILicenseClanUserModelBase;
  import projects.tanks.client.clans.license.user.LicenseClanUserModelBase;

  [ModelInfo]
  public class LicenseClanUserModel extends LicenseClanUserModelBase implements ILicenseClanUserModelBase, ObjectLoadListener {
    [Inject]
    public static var clanUserService:ClanUserService;

    public function LicenseClanUserModel() {
      super();
    }

    public function objectLoaded() : void {
      if(getInitParam() == null) {
        return;
      }
      clanUserService.hasClanLicense = getInitParam().clanLicense;
      clanUserService.licenseGarageObject = getInitParam().licenseGarageObject;
    }

    public function addClanLicense() : void {
      clanUserService.hasClanLicense = true;
    }

    public function removeClanLicense() : void {
      clanUserService.hasClanLicense = false;
    }
  }
}
