package alternativa.tanks.model.payment.modes.description {
  import platform.client.fp10.core.resource.types.ImageResource;

  [ModelInterface]
  public interface PayModeBottomDescription {
    function getDescription() : String;
    function getImages() : Vector.<ImageResource>;
    function enabled() : Boolean;
  }
}
