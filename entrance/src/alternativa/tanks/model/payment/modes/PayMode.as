package alternativa.tanks.model.payment.modes {
  import platform.client.fp10.core.resource.types.ImageResource;

  [ModelInterface]
  public interface PayMode {
    function getName() : String;
    function getDescription() : String;
    function hasCustomManualDescription() : Boolean;
    function getCustomManualDescription() : String;
    function getOrderIndex() : int;
    function getImage() : ImageResource;
    function isDiscount() : Boolean;
    function setDiscount(param1:Boolean) : void;
  }
}
