package alternativa.tanks.model.payment.shop.indemnity {
  import projects.tanks.client.panel.model.shop.indemnity.IIndemnityModelBase;
  import projects.tanks.client.panel.model.shop.indemnity.IndemnityModelBase;

  [ModelInfo]
  public class IndemnityModel extends IndemnityModelBase implements IIndemnityModelBase, Indemnity {
    public function IndemnityModel() {
      super();
    }

    public function getIndemnitySize() : int {
      return getInitParam().indemnitySize;
    }
  }
}
