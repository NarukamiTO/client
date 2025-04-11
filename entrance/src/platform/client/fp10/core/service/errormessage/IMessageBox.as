package platform.client.fp10.core.service.errormessage {
  import flash.display.DisplayObject;
  import platform.client.fp10.core.service.errormessage.errors.ErrorType;

  public interface IMessageBox {
    function getDisplayObject(param1:ErrorType) : DisplayObject;
    function hide() : void;
  }
}
