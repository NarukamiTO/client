package alternativa.tanks.model.item.itemforpartners {
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.commons.socialnetwork.SocialNetworkEnum;
  import projects.tanks.client.garage.models.item.itemforpartners.IItemEnabledForPartnerModelBase;
  import projects.tanks.client.garage.models.item.itemforpartners.ItemEnabledForPartnerModelBase;

  [ModelInfo]
  public class ItemEnabledForPartnerModel extends ItemEnabledForPartnerModelBase implements IItemEnabledForPartnerModelBase, ItemEnabledForPartner {
    [Inject]
    public static var partnerService:IPartnerService;

    public function ItemEnabledForPartnerModel() {
      super();
    }

    public function isAvailable() : Boolean {
      var local1:String = getInitParam().partnerId;
      if(local1 == SocialNetworkEnum.MAIN.name.toLowerCase()) {
        return true;
      }
      return !partnerService.isRunningInsidePartnerEnvironment() && getInitParam().availableForNonPartnerUsers || Boolean(partnerService.isRunningInsidePartnerEnvironment()) && partnerService.getEnvironmentPartnerId() == local1;
    }
  }
}
