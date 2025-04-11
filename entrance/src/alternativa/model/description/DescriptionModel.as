package alternativa.model.description {
  import platform.client.models.commons.description.DescriptionModelBase;
  import platform.client.models.commons.description.IDescriptionModelBase;

  [ModelInfo]
  public class DescriptionModel extends DescriptionModelBase implements IDescription, IDescriptionModelBase {
    public function DescriptionModel() {
      super();
    }

    public function getName() : String {
      return getInitParam().name;
    }

    public function getDescription() : String {
      return getInitParam().description;
    }
  }
}
