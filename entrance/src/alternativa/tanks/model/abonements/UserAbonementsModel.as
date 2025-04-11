package alternativa.tanks.model.abonements {
  import projects.tanks.client.panel.model.abonements.IUserAbonementsModelBase;
  import projects.tanks.client.panel.model.abonements.ShopAbonementData;
  import projects.tanks.client.panel.model.abonements.UserAbonementsModelBase;

  [ModelInfo]
  public class UserAbonementsModel extends UserAbonementsModelBase implements IUserAbonementsModelBase {
    public function UserAbonementsModel() {
      super();
    }

    public function updateAbonement(param1:ShopAbonementData) : void {
    }
  }
}
