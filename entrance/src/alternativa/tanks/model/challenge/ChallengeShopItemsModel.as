package alternativa.tanks.model.challenge {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.panel.model.shop.challenges.toclient.ChallengeShopItemsModelBase;
  import projects.tanks.client.panel.model.shop.challenges.toclient.IChallengeShopItemsModelBase;
  import projects.tanks.clients.flash.commons.models.challenge.shopitems.ChallengeShopItems;

  [ModelInfo]
  public class ChallengeShopItemsModel extends ChallengeShopItemsModelBase implements IChallengeShopItemsModelBase, ObjectLoadListener {
    [Inject]
    public static var challengeShopItems:ChallengeShopItems;

    public function ChallengeShopItemsModel() {
      super();
    }

    public function objectLoaded() : void {
      challengeShopItems.battlePass = getInitParam().shopBattlePass;
      challengeShopItems.starsBundle = getInitParam().starsBundle;
    }

    public function itemsLoaded() : void {
    }
  }
}
