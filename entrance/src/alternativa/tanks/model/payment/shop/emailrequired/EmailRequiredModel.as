package alternativa.tanks.model.payment.shop.emailrequired {
  import projects.tanks.client.panel.model.shop.emailrequired.EmailRequiredModelBase;
  import projects.tanks.client.panel.model.shop.emailrequired.IEmailRequiredModelBase;

  [ModelInfo]
  public class EmailRequiredModel extends EmailRequiredModelBase implements IEmailRequiredModelBase, ShopItemEmailRequired {
    public function EmailRequiredModel() {
      super();
    }

    public function isEmailRequired() : Boolean {
      return getInitParam().emailRequired;
    }
  }
}
